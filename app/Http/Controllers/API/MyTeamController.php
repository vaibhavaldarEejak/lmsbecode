<?php

namespace App\Http\Controllers\API;

use App\Models\TeamApproval;
use App\Models\User;
use App\Models\JobTitle;
use App\Models\Transcript;
use App\Models\OrganizationTrainingLibrary;
use App\Models\OrganizationCategory;
use App\Models\UserLearningPlan;
use App\Models\UserTrainingAssignment;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;

class MyTeamController extends BaseController
{

    public function getMyTeamList(Request $request)
    {
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $roleId = Auth::user()->user->role_id;

        $name = $request->name ? $request->name : '';
        $email = $request->email ? $request->email : '';
        $jobTitle = $request->jobTitle ? $request->jobTitle : '';
        $role = $request->role ? $request->role : '';
        $level = $request->level ? $request->level : '';


       $myTeams = User::leftJoin('lms_roles as role', 'lms_user_master.role_id', '=', 'role.role_id')
        ->where('lms_user_master.is_active', 1)
        //->where('lms_user_master.is_supervisor', $authId)
        ->where('lms_user_master.org_id',$organizationId)
       ->when($level == 1 || $roleId==1, function ($query) {
             $query->select('lms_user_master.user_id as userId',DB::raw('CONCAT(lms_user_master.first_name," ",lms_user_master.last_name) AS userName'),'lms_user_master.email_id as email','lms_user_master.job_title as jobTitle');
        })
        ->when($level == 2, function ($query) {
            // for supervisor level 2
            $query->Join('lms_user_master AS lms_user_master2', 'lms_user_master2.is_supervisor', '=', 'lms_user_master.user_id');
            $query->select('lms_user_master2.user_id as userId',DB::raw('CONCAT(lms_user_master2.first_name," ",lms_user_master2.last_name) AS userName'),'lms_user_master2.email_id as email','lms_user_master2.job_title as jobTitle')
            ->orderBy('lms_user_master2.is_supervisor', 'ASC');
        })
        ->when($level == 3, function ($query) {
            // for supervisor level 3
            $query->Join('lms_user_master AS lms_user_master2', 'lms_user_master2.is_supervisor', '=', 'lms_user_master.user_id')
            ->Join('lms_user_master AS lms_user_master3', 'lms_user_master3.is_supervisor', '=', 'lms_user_master2.user_id')
            ->select('lms_user_master3.user_id as userId',DB::raw('CONCAT(lms_user_master3.first_name," ",lms_user_master3.last_name) AS userName'),'lms_user_master3.email_id as email','lms_user_master3.job_title as jobTitle')
            ->orderBy('lms_user_master3.is_supervisor', 'ASC');
        })
        ->where(function($query) use ($name,$email,$jobTitle,$role,$organizationId){
            if($name != ''){
                $query->where(DB::raw('CONCAT_WS(lms_user_master.first_name," ",lms_user_master.last_name) AS userName'), 'LIKE',$name);
            }
            if($email != ''){
                $query->where('lms_user_master.email_id','LIKE',$email);
            }
            if($jobTitle != ''){
                $jobTitles = JobTitle::where('is_active',1)->where('org_id',$organizationId)->where('job_title_name','LIKE',$jobTitle)->pluck('job_title_id')->toArray();
                $query->whereIn('lms_user_master.job_title',$jobTitles);
            }
            if($role != ''){
                $query->where('role.role_name','LIKE',$role);
            }
        })
        ->when($roleId != 1, function ($query) use ($authId) {
            $query->where('lms_user_master.is_supervisor', $authId);
        })
        ->get();
        
        if($myTeams->count() > 0){
            foreach($myTeams as $myTeam){
                if(!empty($myTeam->jobTitle)){
                    $jobTitle = JobTitle::where('is_active',1)->where('org_id',$organizationId)->whereIn('job_title_id',explode(',',$myTeam->jobTitle));
                    if($jobTitle->count() > 0){
                        $myTeam->jobTitle = $jobTitle->pluck('job_title_name');
                    }else{
                        $myTeam->jobTitle = '';
                    }
                    
                }
            }
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$myTeams],200);

        exit;

        $sort = $request->has('sort') ? $request->get('sort') : 'lms_team_approvals.team_approval_id';
        $order = $request->has('order') ? $request->get('order') : 'DESC';
        $search = $request->has('search') ? $request->get('search') : '';

        $sortColumn = $sort;
        if($sort == 'jobTitle'){
            $sortColumn = 'user.job_title';
        }elseif($sort == 'courseName'){
            $sortColumn = 'training.training_name';
        }elseif($sort == 'roleName'){
            $sortColumn = 'role.role_name';
        }elseif($sort == 'creditScore'){
            $sortColumn = 'training.credits';
        }elseif($sort == 'progress'){
            $sortColumn = 'training.points';
        }elseif($sort == 'isActive'){
            $sortColumn = 'lms_team_approvals.is_active';
        }

        $myTeams = TeamApproval::leftJoin('lms_user_master as user','user.user_id','=','lms_team_approvals.user_id')
        ->leftJoin('lms_training_library as training','training.training_id','=','lms_team_approvals.course_id')
        ->leftJoin('lms_training_types as trainingType','training.training_type_id','=','trainingType.training_type_id')
        ->leftJoin('lms_roles as role','user.role_id','=','role.role_id')
        ->where('lms_team_approvals.is_active','1')
        ->select('lms_team_approvals.team_approval_id as myTeamId',
        DB::raw('CONCAT(user.first_name," ",user.last_name) AS userName'), 
        'role.role_name as roleName', 'user.job_title as jobTitle', 
         'training.credits as creditScore', 'training.points as progress', 'lms_team_approvals.is_active as isActive')
        ->where(function($query) use ($search){
            if($search != ''){
                $query->where('user.job_title', 'LIKE', '%'.$search.'%');
                $query->orWhere('training.training_name', 'LIKE', '%'.$search.'%');
                $query->orWhere('user.first_name', 'LIKE', '%'.$search.'%');
                $query->orWhere('user.last_name', 'LIKE', '%'.$search.'%');
                $query->orWhere('role.role_name', 'LIKE', '%'.$search.'%');
                $query->orWhere('training.credits', 'LIKE', '%'.$search.'%');
                $query->orWhere('training.points', 'LIKE', '%'.$search.'%');
                if(in_array($search,['active','act','acti','activ'])){
                    $query->orWhere('lms_team_approvals.is_active','1');
                }
                if(in_array($search,['inactive','inact','inacti','inactiv'])){
                    $query->orWhere('lms_team_approvals.is_active','2');
                }
            }
        })
        ->when($sort=='userName',function($query) use ($order){ 
            return $query->orderBy("user.first_name",$order)->orderBy('user.last_name',$order);
        }, function($query) use ($sortColumn,$order){                   
            return $query->orderBy($sortColumn,$order);
        })
        ->get();
        return response()->json(['status'=>true,'code'=>200,'data'=>$myTeams],200);
    }

    public function getCourseListByUserId(Request $request)
    {
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'userIds' => 'required|array'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $courses = DB::table('lms_org_assignment_user_course as assignment')
        ->join('lms_org_training_library as trainingLibrary','assignment.courses','=','trainingLibrary.training_id')
        ->join('lms_training_types as trainingType', 'trainingType.training_type_id', '=', 'trainingLibrary.training_type_id')
        ->whereIn('assignment.users',$request->userIds)
        ->where('assignment.org_id',$organizationId)
        ->select('trainingLibrary.training_id as courseId','trainingLibrary.training_name as courseName','trainingLibrary.credits as credit','trainingType.training_type as trainingType')
        ->get();
        return response()->json(['status'=>true,'code'=>200,'data'=>$courses],200);
    }

    public function giveCredit(Request $request)
    {
        $organizationId = Auth::user()->org_id;
        $validator = Validator::make($request->all(), [
            'userIds' => 'required|array',
            'courseIds' => 'required|array'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        foreach($request->courseIds as $courseId){
            $transcript = Transcript::whereIn('user_id',$request->userIds)
            ->where('training_id',$courseId)
            ->where('org_id',$organizationId);
            if($transcript->count() > 0){

                $organizationTrainingLibrary = OrganizationTrainingLibrary::where('training_id',$courseId);
                if($organizationTrainingLibrary->count() > 0){
                    $credits = $organizationTrainingLibrary->first()->credits;
                    $transcript->update([
                        'credit' => $credits ? $credits : 0
                    ]);
                }
            }
        }

        return response()->json(['status'=>true,'code'=>200,'message'=>'Credited successfully.'],200);

    }

    public function viewCreditListByUserId($userId)
    {
        $organizationId = Auth::user()->org_id;
        $transcripts = Transcript::
        join('lms_org_training_library as trainingLibrary','lms_user_transcript.training_id','=','trainingLibrary.training_id')
        ->where('lms_user_transcript.user_id',$userId)
        ->where('lms_user_transcript.org_id',$organizationId)
        ->where('lms_user_transcript.status','!=','1')
        ->where('lms_user_transcript.is_active','=','1')
        ->select('trainingLibrary.training_name as courseName','lms_user_transcript.credit',DB::raw('(CASE WHEN lms_user_transcript.status = 1 THEN "Completed"  ELSE "InProgress" END) AS progress'),'lms_user_transcript.date_created as dateCreated')
        ->get();

        return response()->json(['status'=>true,'code'=>200,'data'=>$transcripts],200);
    }

    public function creditHistoryByUserId($userId)
    {
        $organizationId = Auth::user()->org_id;
        $transcripts = Transcript::
        join('lms_org_training_library as trainingLibrary','lms_user_transcript.training_catalog_id','=','trainingLibrary.training_id')
        ->leftjoin('lms_training_types','lms_training_types.training_type_id','=','trainingLibrary.training_type_id')
        ->where('lms_user_transcript.user_id',$userId)
        ->where('lms_user_transcript.org_id',$organizationId)
        ->where('lms_user_transcript.status','=','1')
        ->where('lms_user_transcript.is_active','=','1')
        ->select('trainingLibrary.training_name as courseName','trainingLibrary.credits',DB::raw('(CASE WHEN lms_user_transcript.status = 1 THEN "Completed"  ELSE "InProgress" END) AS progress'),'lms_user_transcript.date_created as dateCreated','lms_training_types.training_type as trainingType','completion_date as completionDate')
        ->get();

        return response()->json(['status'=>true,'code'=>200,'data'=>$transcripts],200);
    }

    public function getTeamCreditRequirementPopup(Request $request,$userid){

        $organizationId = Auth::user()->org_id;

        $TeamLearningPlan = UserLearningPlan::
            leftJoin('lms_org_learning_plan', 'lms_org_learning_plan.learning_plan_id', '=', 'user_learning_plan.learning_plan_id')
            ->leftJoin('lms_learning_plan_requirements', 'lms_learning_plan_requirements.learning_plan_requirement_id', '=', 'user_learning_plan.requirement_id')
            ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'user_learning_plan.requirement_id')
            ->leftJoin('lms_training_types', 'lms_training_types.training_type_id', '=', 'user_learning_plan.requirement_type')
            ->where('user_learning_plan.is_active', '!=', '0')
            ->where('user_learning_plan.org_id', $organizationId)
            ->where('user_learning_plan.user_id', $userid)
            ->select(
                 DB::raw("lms_org_learning_plan.learning_plan_id AS userLearningPlanId"),
                'lms_org_learning_plan.learning_plan_name as learningPlanName',
                'user_learning_plan.due_date AS dueDate',
                'lms_org_training_library.training_name AS trainingName',
                'lms_org_training_library.category_id AS categoryId',
                'lms_learning_plan_requirements.learning_plan_requirement_id  AS requirementId',
                'lms_learning_plan_requirements.requirement_type  AS requirementTypeId',              
               // 'lms_training_types.training_type AS trainingType',
                DB::raw("'Learning Plan' AS requirementType"),
               // 'user_learning_plan.assign_date AS assignDate'
            )
           ->orderBy('user_learning_plan.due_date', 'desc')->get();

           if (isset($TeamLearningPlan)) {
                foreach ($TeamLearningPlan as $training) {
                    $categoryArr = explode(',', $training->categoryId);
                    
                    $categoryDetails = OrganizationCategory::where('is_active', '!=', '0')
                        ->whereIn('category_org_id', $categoryArr)
                        ->pluck('category_name')
                        ->toArray();

                    $training->categoryName = $categoryDetails;
                }

            }



        $TeamRequirementPlan  = UserTrainingAssignment::
        leftJoin('lms_org_assignment_user_course', 'lms_org_assignment_user_course.assignment_id', '=', 'user_training_assignments.assignment_id') 
        ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'lms_org_assignment_user_course.training_id')
         ->leftJoin('lms_training_types', 'lms_training_types.training_type_id', '=', 'lms_org_training_library.training_type_id')         
        ->select('user_training_assignment_id  as userAssignmentId','lms_org_assignment_user_course.assignment_id as assignmentId','lms_org_assignment_user_course.assignment_name as assignmentName','user_training_assignments.due_date AS dueDate','lms_org_training_library.training_name AS trainingName','lms_org_training_library.category_id AS categoryId','lms_org_training_library.training_type_id  AS trainingTypeId','lms_training_types.training_type  AS trainingTypeName')
        ->where('user_training_assignments.org_id', $organizationId)
         ->where('user_training_assignments.user_id', $userid)
          ->where('user_training_assignments.due_date', 'IS NOT', null)
         ->orderBy('user_training_assignments.due_date', 'desc')->get();
        
         if (isset($TeamRequirementPlan)) {
                foreach ($TeamRequirementPlan as $training) {
                    $categoryArr = explode(',', $training->categoryId);
                    
                    $categoryDetails = OrganizationCategory::where('is_active', '!=', '0')
                        ->whereIn('category_org_id', $categoryArr)
                        ->pluck('category_name')
                        ->toArray();

                    $training->categoryName = $categoryDetails;
                }

            }

        $combinedResults = new \stdClass();

        $combinedResults->learning = $TeamLearningPlan;
        $combinedResults->requirement = $TeamRequirementPlan;



        return response()->json(['status' => true, 'code' => 200, 'data' => $combinedResults], 200);
    }

    public function viewCreditCertificate($userId){

        $organizationId = Auth::user()->org_id;
        
        $transcripts = Transcript::
        join('lms_org_training_library as trainingLibrary','lms_user_transcript.training_catalog_id','=','trainingLibrary.training_id')
        ->where('lms_user_transcript.user_id',$userId)
        ->where('lms_user_transcript.org_id',$organizationId)
        ->where('lms_user_transcript.is_active','=','1')
        ->selectRaw('trainingLibrary.training_name as trainingName, trainingLibrary.credits, CONCAT(?, certificate_link) as certificateLink', [getFileS3Bucket(getPathS3Bucket())])
        ->get();

        return response()->json(['status' => true, 'code' => 200, 'data' => $transcripts], 200);
    }
}
