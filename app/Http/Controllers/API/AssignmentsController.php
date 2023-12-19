<?php

namespace App\Http\Controllers\API;

use App\Models\Assignments;
use App\Models\OrganizationTrainingLibrary;
use App\Models\User;
use App\Models\GroupOrganization;
use App\Models\Jobs;
use App\Models\CategoryMaster;
use App\Models\GroupMaster;
use App\Models\OrganizationCategory;
use App\Models\TrainingLibrary;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use Illuminate\Support\Facades\Redis;
use Carbon\Carbon;
use DB;

class AssignmentsController extends BaseController
{

    public function getAssignmentsList(Request $request)
    {
        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;

        $sort = $request->has('sort') ? $request->get('sort') : 'assignment_id';
        $order = $request->has('order') ? $request->get('order') : 'DESC';
        $search = $request->has('search') ? $request->get('search') : '';

        $sortColumn = $sort;
        if ($sort == 'assignmentName') {
            $sortColumn = 'assignment_name';
        } elseif ($sort == 'dueDate') {
            $sortColumn = 'assignment_due_date';
        }

        $assignments = DB::table('lms_org_assignment_user_course')
            ->leftjoin('lms_org_training_library as trainingLibrary','trainingLibrary.training_id','=','lms_org_assignment_user_course.training_id')
            ->leftJoin('lms_training_types as courseType','courseType.training_type_id','=','trainingLibrary.training_type_id')
            ->where('lms_org_assignment_user_course.is_active', '!=', '0')
            ->where('lms_org_assignment_user_course.org_id', $organizationId)
            ->where(function ($query) use ($search) {
                if ($search != '') {
                    $query->where('assignment_name', 'LIKE', '%' . $search . '%');
                    $query->orWhere('assignment_due_date', 'LIKE', '%' . $search . '%');
                    if (in_array($search, ['active', 'act', 'acti', 'activ'])) {
                        $query->orWhere('is_active', '1');
                    }
                    if (in_array($search, ['inactive', 'inact', 'inacti', 'inactiv'])) {
                        $query->orWhere('is_active', '2');
                    }
                }
            })
            ->orderBy($sortColumn, $order)
            ->select('assignment_id as assignmentId', 'assignment_name as assignmentName', 'assignment_due_date as dueDate', 'lms_org_assignment_user_course.is_active as isActive', 'trainingLibrary.training_id AS courseId', 'trainingLibrary.training_name AS courseName','trainingLibrary.training_type_id AS courseType', 'courseType.training_type AS courseTypeName','lms_org_assignment_user_course.date_created AS createdDate')
            // ->groupBy('assignment_name')
            ->get();
        return response()->json(['status' => true, 'code' => 200, 'data' => $assignments], 200);
    }

    public function addNewAssignment(Request $request)
    {
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;


        $validator = Validator::make($request->all(), [
            'assignmentName' => 'required|max:150|unique:lms_category_master,category_name,null,null,is_active,!0',
            'courseId' => 'required|array'
        ]);


        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        try {

            foreach ($request->courseId as $courseIdData) {
                $assignment = new Assignments;
                $assignment->assignment_name = $request->assignmentName;
                $assignment->assignment_due_date = $request->dueDate;
                $assignment->training_id = $courseIdData;
                $assignment->group_id = implode(",", $request->groupId);
                $assignment->user_id = implode(",", $request->userId);
                $assignment->org_id = $organizationId;
                $assignment->is_active = $request->isActive == '' ? '1' : $request->isActive;
                $assignment->created_id = $authId;
                $assignment->save();

                $learningPlanJob = new Jobs;
                $learningPlanJob->job_name = 'Add New Assignment Plan Record';
                $learningPlanJob->job_type_id = 5;
                $learningPlanJob->job_process = 'add_new_assignment_plan';
                $learningPlanJob->data_table_id = $assignment->assignment_id;
                $learningPlanJob->job_data = serialize($assignment->toArray());
                $learningPlanJob->is_active = 1;
                $learningPlanJob->created_id = $authId;
                $learningPlanJob->save();
            }
            return response()->json(['status' => true, 'code' => 201, 'data' => $assignment->category_id, 'message' => 'Assignment has been created successfully.'], 201);
        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function getAssignmentById($assignmentId)
    {
        try {

            $AssignmentDetail = Assignments::where('lms_org_assignment_user_course.is_active', '!=', '0')->where('assignment_id', $assignmentId);
            if ($AssignmentDetail->count() < 1) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Assignment is not found.'], 404);
            }
            $AssignmentDetail = $AssignmentDetail->join('lms_org_training_library as trainingLibrary','trainingLibrary.training_id','=','lms_org_assignment_user_course.training_id')
            ->leftjoin('lms_training_types as trainingType','trainingLibrary.training_type_id','=','trainingType.training_type_id')
                ->select('assignment_id as assignmentId', 'assignment_name as assignmentName', 'assignment_due_date As dueDate', 'group_id AS group_id', 'user_id AS user_id', 'lms_org_assignment_user_course.training_id AS courseId', 'trainingLibrary.category_id AS categoryId', 'trainingLibrary.training_name', 'trainingLibrary.credits','trainingType.training_type')->first();
            if (isset($AssignmentDetail)) {
                $groupArr = explode(',', $AssignmentDetail->group_id);
                $userArr = explode(',', $AssignmentDetail->user_id);
                $categoryArr = explode(',', $AssignmentDetail->categoryId);

                $userDetails = User::
                    leftjoin('lms_job_title as job','job.job_title_id','=','lms_user_master.job_title')
                    ->where('lms_user_master.is_active', '!=', '0')
                    ->whereIn('user_id', $userArr)
                    ->select(['user_id as userId', DB::raw('CONCAT(first_name, " ", last_name) as fullName'),'job_title_name as jobTitle'])
                    ->get();

                $groupDetails = GroupOrganization::where('is_active', '!=', '0')
                    ->whereIn('group_id', $groupArr)
                    ->select(['group_id as groupId', 'group_name as groupName'])
                    ->get();
                
                $categoryDetails = OrganizationCategory::where('is_active', '!=', '0')
                    ->whereIn('category_org_id', $categoryArr)
                    ->select(['category_org_id as categoryId', 'category_name as categoryName'])
                    ->get();

                $AssignmentDetail->user = $userDetails;
                $AssignmentDetail->group = $groupDetails;
                $AssignmentDetail->trainingCategory = $categoryDetails;

            }

            return response()->json(['status' => true, 'code' => 200, 'data' => $AssignmentDetail], 200);

        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function updateAssignmentById(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'assignmentId' => 'required|integer'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        $assignmentId = $request->assignmentId;
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        try {
            $AssignmentDetail = Assignments::where('is_active', '!=', '0')->where('assignment_id', $assignmentId)->first();
            if (is_null($AssignmentDetail)) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Assignment is not found.'], 404);
            }



            $AssignmentDetail->assignment_name = @$request->assignmentName;
            $AssignmentDetail->assignment_due_date = @$request->dueDate;
            $AssignmentDetail->training_id = @$request->courseId;
            if ($request->groupId)
                $AssignmentDetail->group_id = implode(",", $request->groupId);
            else
                $AssignmentDetail->group_id = '';

            if ($request->userId)
                $AssignmentDetail->user_id = implode(",", $request->userId);
            else
                $AssignmentDetail->user_id = '';

            $AssignmentDetail->org_id = $organizationId;
            $AssignmentDetail->is_active = $request->isActive == '' ? '1' : $request->isActive;
            $AssignmentDetail->save();

            $jobsDetail = Jobs::where('job_type_id',5)->where('data_table_id', $AssignmentDetail->assignment_id)->where('job_process', 'update_existing_assignment_plan')->first();
        
            if (is_null($jobsDetail)) {
                $learningPlanJob = new Jobs;
            }
            else{
                $learningPlanJob = $jobsDetail;
            }
            
            $learningPlanJob->job_name = 'Update Existing Assignment Plan Record';
            $learningPlanJob->job_type_id = 5;
            $learningPlanJob->job_process = 'update_existing_assignment_plan';
            $learningPlanJob->data_table_id = $AssignmentDetail->assignment_id;
            $learningPlanJob->job_data = serialize($AssignmentDetail->toArray());
            $learningPlanJob->is_active = 1;
            $learningPlanJob->created_id = $authId;
            $learningPlanJob->save();

            return response()->json(['status' => true, 'code' => 200, 'message' => 'Assignment has been updated successfully.'], 200);
        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function deleteAssignment(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'assignmentId' => 'required|integer'
        ]);

        $authId = Auth::user()->user_id;

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        try {
            $AssignmentDetail = Assignments::where('is_active', '!=', '0')->where('assignment_id', $request->assignmentId)->first();

            if (is_null($AssignmentDetail)) {
                return response()->json(['status' => true, 'code' => 400, 'error' => 'Assignment Plan not found.'], 400);
            }


            $AssignmentDetail->is_active = 0;
            $AssignmentDetail->save();

            $learningPlanJob = new Jobs;
            $learningPlanJob->job_name = 'Delete Existing Assignment Plan Record';
            $learningPlanJob->job_type_id = 5;
            $learningPlanJob->job_process = 'delete_new_assignment_plan';
            $learningPlanJob->data_table_id = $AssignmentDetail->assignment_id;
            $learningPlanJob->job_data = serialize($AssignmentDetail->toArray());
            $learningPlanJob->is_active = 1;
            $learningPlanJob->created_id = $authId;
            $learningPlanJob->save();


            return response()->json(['status' => true, 'code' => 200, 'message' => 'Assignment has been deleted successfully.'], 200);

        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function deleteUserGroupAssignment(Request $request,$id)
    {
        $validator = Validator::make($request->all(), [
            'type' => 'required|integer',
            'id' => 'required|integer'
        ]);

        $authId = Auth::user()->user_id;

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        try {
            $AssignmentDetail = Assignments::where('is_active', '!=', '0')->where('assignment_id', $id)->first();

            if (is_null($AssignmentDetail)) {
                return response()->json(['status' => true, 'code' => 404, 'error' => 'Assignment Plan not found.'], 404);
            }

            $idToDelete = $request->id;
            $msg = "";

            if($request->type==1){
                $userArr = explode(',',$AssignmentDetail->user_id);

                if($userArr){
                    if (in_array($idToDelete, $userArr)) {
                        $userArr = array_diff($userArr, [$idToDelete]);
                        $AssignmentDetail->user_id = implode(',', $userArr);
                        $AssignmentDetail->save();
                    }
                }

                $msg = "User";
                
            }
            else if($request->type==2){
                $groupArr = explode(',',$AssignmentDetail->group_id);
                
                if($groupArr){
                    if (in_array($idToDelete, $groupArr)) {
                        $groupArr = array_diff($groupArr, [$idToDelete]);
                        $AssignmentDetail->group_id = implode(',', $groupArr);
                        $AssignmentDetail->save();
                    }
                }

                $msg = "Group";
            }

            return response()->json(['status' => true, 'code' => 200, 'message' => $msg.' has been deleted successfully.'], 200);

        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function getUserListByAssignmentId($assignmentId,$courseId)
    {
        $organizationId = Auth::user()->org_id;
        $progressStatus = 'kkk';

        try {

            $AssignmentDetail = Assignments::where('lms_org_assignment_user_course.is_active', '!=', '0')->where('assignment_id', $assignmentId)->where('lms_org_assignment_user_course.training_id', $courseId);
            if ($AssignmentDetail->count() < 1) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Assignment is not found.'], 404);
            }
            $AssignmentDetail = $AssignmentDetail->join('lms_org_training_library as trainingLibrary','trainingLibrary.training_id','=','lms_org_assignment_user_course.training_id')
                ->select('assignment_id as assignmentId', 'assignment_name as assignmentName', 'assignment_due_date As dueDate', 'group_id AS group_id', 'user_id AS user_id', 'lms_org_assignment_user_course.training_id AS courseId', 'trainingLibrary.training_name')->first();
            if (isset($AssignmentDetail)) {
                $AssignmentUserDetail = [];
                $userArr = explode(',', $AssignmentDetail->user_id);

               $userDetails = User::
                leftjoin('lms_roles as roles','roles.role_id','=','lms_user_master.role_id')
                ->leftjoin('lms_job_title as job_title','job_title.job_title_id','=','lms_user_master.job_title')
                ->leftjoin('lms_user_master as supervisor','supervisor.user_id','=','lms_user_master.is_supervisor')
                ->where('lms_user_master.is_active', '!=', '0')
                    ->whereIn('lms_user_master.user_id', $userArr)
                    ->select(['lms_user_master.user_id as userId', DB::raw('CONCAT(lms_user_master.first_name, " ", lms_user_master.last_name) as Name'),'roles.role_name as roleName','lms_user_master.email_id as Email','job_title_name as jobTitle', DB::raw('CONCAT(supervisor.first_name, " ", supervisor.last_name) as supervisorName')])
                    ->get();
                

                foreach ($userDetails as $user) {
                    $transcript = DB::table('lms_user_transcript')
                        ->where('training_catalog_id', $courseId)
                        ->where('org_id', $organizationId)
                        ->where('user_id', $user->userId)
                        ->select('user_transcript_id')
                        ->get();

                    if ($transcript->isEmpty()) {
                        
                         $inprogress = DB::table('lms_user_training_progress as inprogress')
                            ->where('inprogress.training_catalog_id', $courseId)
                            ->where('inprogress.org_id', $organizationId)
                            ->where('inprogress.user_id', $user->userId)
                            ->select('inprogress.user_training_id as userProgressId')
                            ->get();

                        if ($inprogress->isEmpty()) {
                            $user->progressStatus = 'Incomplete';
                        } else {
                            $user->progressStatus = 'In Progress';
                        }
                    } else {
                        $user->progressStatus = 'Completed';
                    }
                }

                $AssignmentUserDetail = $userDetails;

            }

            return response()->json(['status' => true, 'code' => 200, 'data' => $AssignmentUserDetail], 200);

        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }

    public function getGroupListByAssignmentId($assignmentId, $courseId)
    {
        try {

            $AssignmentDetail = Assignments::where('lms_org_assignment_user_course.is_active', '!=', '0')->where('assignment_id', $assignmentId)->where('lms_org_assignment_user_course.training_id', $courseId);
            if ($AssignmentDetail->count() < 1) {
                return response()->json(['status' => false, 'code' => 404, 'error' => 'Assignment is not found.'], 404);
            }
            $AssignmentDetail = $AssignmentDetail->join('lms_org_training_library as trainingLibrary','trainingLibrary.training_id','=','lms_org_assignment_user_course.training_id')
                ->select('assignment_id as assignmentId', 'assignment_name as assignmentName', 'assignment_due_date As dueDate', 'group_id AS group_id', 'user_id AS user_id', 'lms_org_assignment_user_course.training_id AS courseId', 'trainingLibrary.training_name')->first();
            if (isset($AssignmentDetail)) {
                $AssignmentGroupDetail = [];
                $groupArr = explode(',', $AssignmentDetail->group_id);
               

                $groupDetails = GroupOrganization::where('is_active', '!=', '0')
                    ->whereIn('group_id', $groupArr)
                    ->select(['group_id as groupId', 'group_name as groupName','group_code AS groupCode'])
                    ->get();

                $AssignmentGroupDetail = $groupDetails;

            }

            return response()->json(['status' => true, 'code' => 200, 'data' => $AssignmentGroupDetail], 200);

        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'code' => 501, 'message' => $e->getMessage()], 501);
        }
    }
}
