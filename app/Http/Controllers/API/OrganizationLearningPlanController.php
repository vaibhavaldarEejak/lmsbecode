<?php

namespace App\Http\Controllers\API;

use App\Models\GroupOrganization;
use App\Models\Jobs;
use App\Models\JobTitle;
use App\Models\OrganizationLearningPlan;
use App\Models\OrganizationLearningPlanGroups;
use App\Models\OrganizationLearningPlanJobTitles;
use App\Models\OrganizationLearningPlanRequirement;
use App\Models\OrganizationLearningPlanUsers;
use App\Models\OrganizationTrainingLibrary;
use App\Models\OrganizationCategory;
use App\Models\User;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;

class OrganizationLearningPlanController extends BaseController
{
    public function getOrgLearningPlanList(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $OrganizationLearningPlan = OrganizationLearningPlan::
        where('is_active','!=','0')
        ->where('org_id',$organizationId)
        ->select('learning_plan_id as learningPlanId','learning_plan_name as learningPlanName','is_active as isActive')
        ->get();

        return response()->json(['status'=>true,'code'=>200,'data'=>$OrganizationLearningPlan],200);
    }

    public function addOrgLearningPlan(Request $request){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'learningPlanName' => 'required',
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $OrganizationLearningPlan = new OrganizationLearningPlan;
        $OrganizationLearningPlan->learning_plan_name = $request->learningPlanName;
        $OrganizationLearningPlan->force_order = $request->forceOrder;
        $OrganizationLearningPlan->description = $request->description;
        $OrganizationLearningPlan->is_active = $request->isActive == '' ? '1' : $request->isActive;
        $OrganizationLearningPlan->org_id = $organizationId;
        $OrganizationLearningPlan->created_id = $authId;
        $OrganizationLearningPlan->save(); 

        // $jobObject = new Object;
        // $jobObject->learning_plan_name =  $OrganizationLearningPlan->learning_plan_name;

        $learningPlanJob = new Jobs;
        $learningPlanJob->job_name = 'Add New Learning Plan Record';
        $learningPlanJob->job_type_id = 3;
        $learningPlanJob->job_process = 'add_new_learning_plan';
        $learningPlanJob->data_table_id = $OrganizationLearningPlan->learning_plan_id;
        $learningPlanJob->job_data = serialize($OrganizationLearningPlan->toArray());
        $learningPlanJob->is_active = 1;
        $learningPlanJob->created_id = $authId;
        $learningPlanJob->save();


        return response()->json(['status'=>true,'code'=>201, 'data'=>$OrganizationLearningPlan->learning_plan_id, 'message'=>'Learning Plan has been created successfully.'],201);
    }

    public function getOrgLearningPlanById($id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $OrganizationLearningPlan = OrganizationLearningPlan::where('is_active','!=','0')
        ->select('learning_plan_id as learningPlanId','learning_plan_name as learningPlanName','description','force_order as forceOrder','is_active as isActive')
        ->find($id);
        if(is_null($OrganizationLearningPlan)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Learning Plan not found.'],400);
        }

        // to get the requirement list if any
        $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::
        leftJoin('lms_org_training_library','lms_org_training_library.training_id','=','lms_learning_plan_requirements.requirement_id')
        ->leftJoin('lms_training_types','lms_training_types.training_type_id','=','lms_org_training_library.training_type_id')
        ->where('lms_learning_plan_requirements.is_active','!=','0')
        ->where('lms_learning_plan_requirements.learning_plan_id',$id);
        if($OrganizationLearningPlanRequirement->count()){
            $OrganizationLearningPlan->learningPlanRequirements = $OrganizationLearningPlanRequirement
            ->select('lms_learning_plan_requirements.learning_plan_requirement_id as learningPlanRequirementId',
            'lms_learning_plan_requirements.requirement_id as requirementId',
            'lms_training_types.training_type as typeName',
            'lms_org_training_library.training_name as requirementName',
            'lms_learning_plan_requirements.orders',
            'lms_learning_plan_requirements.due_date_value as dueDateValue',
            'lms_learning_plan_requirements.due_date_type as dueDateType',
            'lms_learning_plan_requirements.expiration_date_value as expirationDateValue',
            'lms_learning_plan_requirements.expiration_date_type as expirationType',
            'lms_learning_plan_requirements.is_active as isActive')
            ->orderBy('orders','Asc')
            ->get();
        }else{
            $OrganizationLearningPlan->learningPlanRequirements = Null;
        }


        // to get the Users list if any
        $OrganizationLearningPlanUsers = OrganizationLearningPlanUsers::
        leftJoin('lms_user_master','lms_user_master.user_id','=','lms_learning_plan_users.user_id')
        ->leftJoin('lms_org_roles','lms_org_roles.role_id','=','lms_user_master.role_id')
        ->leftjoin('lms_job_title','lms_job_title.job_title_id','=','lms_user_master.job_title')
        ->leftjoin('lms_division','lms_division.division_id','=','lms_user_master.divisions')
        ->leftjoin('lms_area','lms_area.area_id','=','lms_user_master.area')
        ->leftjoin('lms_location','lms_location.location_id','=','lms_user_master.location')
        ->where('lms_learning_plan_users.is_active','!=','0')
        ->where('lms_org_roles.org_id',$organizationId)
        ->where('lms_learning_plan_users.learning_plan_id',$id);
        if($OrganizationLearningPlanUsers->count()){
            $OrganizationLearningPlan->learningPlanUsers = $OrganizationLearningPlanUsers
            ->select('lms_learning_plan_users.learning_plan_users_id',
            'lms_learning_plan_users.user_id as userId',
            'lms_user_master.first_name as firstName',
            'lms_user_master.last_name as lastName',
            'lms_org_roles.role_name as roleName',
            'lms_learning_plan_users.assign_date as assignDate',
            'email_id as email','lms_job_title.job_title_name as jobTitle','lms_division.division_name AS divisions', 'lms_area.area_name AS area', 'lms_location.location_name AS location',
            'lms_learning_plan_users.is_active as isActive')
            ->get();
        }else{
            $OrganizationLearningPlan->learningPlanUsers = Null;
        }

        // to get the Groups list if any
        $OrganizationLearningPlanGroups = OrganizationLearningPlanGroups::
        leftJoin('lms_group_org','lms_group_org.group_id','=','lms_learning_plan_groups.group_id')
        ->where('lms_learning_plan_groups.is_active','!=','0')
        ->where('lms_learning_plan_groups.learning_plan_id',$id);
        if($OrganizationLearningPlanGroups->count()){
            $OrganizationLearningPlan->learningPlanGroups = $OrganizationLearningPlanGroups
            ->select('lms_learning_plan_groups.learning_plan_group_id',
            'lms_group_org.group_name as groupName',
            'lms_group_org.group_code as groupCode',
            'lms_learning_plan_groups.assign_date as assignDate',
            'lms_learning_plan_groups.is_active as isActive')
            ->get();
        }else{
            $OrganizationLearningPlan->learningPlanGroups = Null;
        }

        
        // to get the Job Title list if any
        $OrganizationLearningPlanJobTitles = OrganizationLearningPlanJobTitles::
        leftJoin('lms_job_title','lms_job_title.job_title_id','=','lms_learning_plan_jobtitles.job_title_id')
        ->where('lms_learning_plan_jobtitles.is_active','!=','0')
        ->where('lms_learning_plan_jobtitles.learning_plan_id',$id);
        if($OrganizationLearningPlanJobTitles->count()){
            $OrganizationLearningPlan->learningPlanJobTitles = $OrganizationLearningPlanJobTitles
            ->select('lms_learning_plan_jobtitles.learning_plan_jobtitle_id',
            'lms_job_title.job_title_id as jobTitleId',
            'lms_job_title.job_title_name as jobTitleName',
            'lms_job_title.job_title_code as jobTitleCode',
            'lms_learning_plan_jobtitles.assign_date as assignDate',
            'lms_learning_plan_jobtitles.is_active as isActive')
            ->get();
        }else{
            $OrganizationLearningPlan->learningPlanJobTitles = Null;
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$OrganizationLearningPlan],200);
    }

    public function updateOrgLearningPlanById(Request $request,$id){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'learningPlanName' => 'required',
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $OrganizationLearningPlan = OrganizationLearningPlan::where('is_active','!=','0')->find($id);
        if(is_null($OrganizationLearningPlan)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Learning Plan not found.'],400);
        }
        $OrganizationLearningPlan->learning_plan_name = $request->learningPlanName;
        $OrganizationLearningPlan->force_order = $request->forceOrder;
        $OrganizationLearningPlan->description = $request->description;
        $OrganizationLearningPlan->is_active = $request->isActive == '' ? '1' : $request->isActive;
        $OrganizationLearningPlan->org_id = $organizationId;
        $OrganizationLearningPlan->modified_id = $authId;
        $OrganizationLearningPlan->save();


        if(!empty($request->learningPlanRequirements)){
            foreach($request->learningPlanRequirements as $learningPlanRequirement){
                if(!empty($learningPlanRequirement['learningPlanRequirementId'])){
                    $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::find($learningPlanRequirement['learningPlanRequirementId']);
                }else{
                    $OrganizationLearningPlanRequirement = new OrganizationLearningPlanRequirement;
                    $OrganizationLearningPlanRequirement->learning_plan_id = $OrganizationLearningPlan->learning_plan_id;
                    $OrganizationLearningPlanRequirement->org_id = $organizationId;
                    $OrganizationLearningPlanRequirement->created_id = $authId;
                }
                $OrganizationLearningPlanRequirement->requirement_id = @$learningPlanRequirement['requirementId'];
                $OrganizationLearningPlanRequirement->requirement_type = @$learningPlanRequirement['requirementType'];
                $OrganizationLearningPlanRequirement->orders = @$learningPlanRequirement['orders'];
                $OrganizationLearningPlanRequirement->due_date_value = @$learningPlanRequirement['dueDateValue'];
                $OrganizationLearningPlanRequirement->due_date_type = @$learningPlanRequirement['dueDateType'];
                $OrganizationLearningPlanRequirement->expiration_date_type = @$learningPlanRequirement['expirationType'];
                $OrganizationLearningPlanRequirement->expiration_date_value = @$learningPlanRequirement['expirationDateValue'];
                $OrganizationLearningPlanRequirement->is_active = @$learningPlanRequirement['isActive'];
                $OrganizationLearningPlanRequirement->modified_id = $authId;
                $OrganizationLearningPlanRequirement->save();
            }
        }
        if(!empty($request->learningPlanUsers)){
            foreach($request->learningPlanUsers as $learningPlanUserData){
                if(!empty($learningPlanUserData['learning_plan_users_id'])){
                    $learningPlanUser = OrganizationLearningPlanUsers::find($learningPlanUserData['learning_plan_users_id']);
                }else{
                    $learningPlanUser = new OrganizationLearningPlanUsers;
                    $learningPlanUser->learning_plan_id = $OrganizationLearningPlan->learning_plan_id;
                    $learningPlanUser->created_id = $authId;
                    $learningPlanUser->org_id = $organizationId;
                }
                $learningPlanUser->user_id = @$learningPlanUserData['userId'];
                $learningPlanUser->assign_date = @$learningPlanUserData['assignDate'];
                $learningPlanUser->is_active = @$learningPlanUserData['isActive'];
                $learningPlanUser->modified_id = $authId;
                $learningPlanUser->save();
            }        
        }
        if(!empty($request->learningPlanJobTitles)){
            foreach($request->learningPlanJobTitles as $learningPlanJobTitleData){
                if(!empty($learningPlanJobTitleData['learning_plan_jobtitle_id'])){
                    $learningPlanJobTitle = OrganizationLearningPlanJobTitles::find($learningPlanJobTitleData['learning_plan_jobtitle_id']);
                }else{
                    $learningPlanJobTitle = new OrganizationLearningPlanJobTitles;
                    $learningPlanJobTitle->learning_plan_id = $OrganizationLearningPlan->learning_plan_id;
                    $learningPlanJobTitle->created_id = $authId;
                    $learningPlanJobTitle->org_id = $organizationId;
                }
                $learningPlanJobTitle->job_title_id = @$learningPlanJobTitleData['jobTitleId'];
                $learningPlanJobTitle->assign_date = @$learningPlanJobTitleData['assignDate'];
                $learningPlanJobTitle->is_active = @$learningPlanJobTitleData['isActive'];                
                $learningPlanJobTitle->modified_id = $authId;
                $learningPlanJobTitle->save();
            }        
        }
        if(!empty($request->learningPlanGroups)){
            foreach($request->learningPlanGroups as $learningPlanGroupData){
                if(!empty($learningPlanGroupData['learning_plan_group_id'])){
                    $learningPlanGroup = OrganizationLearningPlanGroups::find($learningPlanGroupData['learning_plan_group_id']);
                }else{
                    $learningPlanGroup = new OrganizationLearningPlanGroups;
                    $learningPlanGroup->learning_plan_id = $OrganizationLearningPlan->learning_plan_id;
                    $learningPlanGroup->org_id = $organizationId;
                    $learningPlanGroup->created_id = $authId;
                }
                $learningPlanGroup->group_id = @$learningPlanGroupData['groupId'];
                $learningPlanGroup->assign_date = @$learningPlanGroupData['assignDate'];
                $learningPlanGroup->is_active = @$learningPlanGroupData['isActive'];
                $learningPlanGroup->modified_id = $authId;
                $learningPlanGroup->save();
            }        
        }


        /*$jobsDetail = Jobs::where('job_type_id',3)->where('data_table_id', $OrganizationLearningPlan->learning_plan_id)->where('job_process', 'update_existing_learning_plan')->first();
        
        if (is_null($jobsDetail)) {
             $learningPlanJob = new Jobs;
        }
        else{
             $learningPlanJob = $jobsDetail;
        }*/
        
        $learningPlanJob = new Jobs;
        $learningPlanJob->job_name = 'Update Learning Plan Record';
        $learningPlanJob->job_type_id = 3;
        $learningPlanJob->job_process = 'update_existing_learning_plan';
        $learningPlanJob->data_table_id = $OrganizationLearningPlan->learning_plan_id;
        $learningPlanJob->job_data = 'Update New Learning Plan Record';
        $learningPlanJob->is_active = 1;
        $learningPlanJob->created_id = $authId;
        $learningPlanJob->save();

        return response()->json(['status'=>true,'code'=>200,'message'=>'Learning Plan has been updated successfully.'],200);

    }

    public function deleteOrgLearningPlanById($id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $OrganizationLearningPlan = OrganizationLearningPlan::where('is_active','!=','0')->find($id);
        if(is_null($OrganizationLearningPlan)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Learning Plan not found.'],400);
        }
        $OrganizationLearningPlan->is_active = 0; 
        $OrganizationLearningPlan->modified_id = $authId;
        $OrganizationLearningPlan->save();


        $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::where('learning_plan_id',$id);
        if($OrganizationLearningPlanRequirement->count() > 0){
            $OrganizationLearningPlanRequirement->update([
                'is_active' => 0,
                'modified_id' => $authId,
            ]);
        }

        $OrganizationLearningPlanJobTitles = OrganizationLearningPlanJobTitles::where('learning_plan_id',$id);
        if($OrganizationLearningPlanJobTitles->count() > 0){
            $OrganizationLearningPlanJobTitles->update([
                'is_active' => 0,
                'modified_id' => $authId,
            ]);
        }

        $OrganizationLearningPlanUsers = OrganizationLearningPlanUsers::where('learning_plan_id',$id);
        if($OrganizationLearningPlanUsers->count() > 0){
            $OrganizationLearningPlanUsers->update([
                'is_active' => 0,
                'modified_id' => $authId,
            ]);
        }

        $OrganizationLearningPlanGroups = OrganizationLearningPlanGroups::where('learning_plan_id',$id);
        if($OrganizationLearningPlanGroups->count() > 0){
            $OrganizationLearningPlanGroups->update([
                'is_active' => 0,
                'modified_id' => $authId,
            ]);
        }
        // $learningPlanJob = new Jobs;
        // $learningPlanJob->job_name = 'Add New Learning Plan Record';
        // $learningPlanJob->job_type_id = 'Add New Learning Plan Record';
        // $learningPlanJob->job_process = 'Add New Learning Plan Record';
        // $learningPlanJob->data_table_id = 'Add New Learning Plan Record';
        // $learningPlanJob->job_data = 'Add New Learning Plan Record';
        // $learningPlanJob->is_active = 'Add New Learning Plan Record';
        // $learningPlanJob->created_id = 'Add New Learning Plan Record';
        // $learningPlanJob->save();

        return response()->json(['status'=>true,'code'=>200,'message'=>'Learning Plan has been deleted successfully.'],200); 
    }

    public function getOrgRequirementListByLearningPlanId($id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $OrganizationTrainingLibrarys = OrganizationTrainingLibrary::
        join('lms_training_types','lms_training_types.training_type_id','=','lms_org_training_library.training_type_id')
        ->where('lms_org_training_library.is_active','1')
        ->where('lms_org_training_library.org_id',$organizationId)
        ->select('lms_org_training_library.training_id as requirementId','lms_org_training_library.training_name as requirementName','lms_training_types.training_type as typeName','lms_training_types.training_type_id as typeId','lms_org_training_library.category_id as category')
        ->get();
        if($OrganizationTrainingLibrarys->count() > 0){
            foreach($OrganizationTrainingLibrarys as $OrganizationTrainingLibrary){

                if(!empty($OrganizationTrainingLibrary->category)){
                    $categoryId = explode(',',$OrganizationTrainingLibrary->category);
                    $OrganizationTrainingLibrary->category = OrganizationCategory::whereIn('category_org_id',$categoryId)->pluck('category_name');
                }else{
                    $OrganizationTrainingLibrary->category = []; 
                }

                $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::where('is_active','=','1')
                ->where('learning_plan_id',$id)
                ->where('requirement_id',$OrganizationTrainingLibrary->requirementId);
                if($OrganizationLearningPlanRequirement->count() > 0){
                    if($OrganizationLearningPlanRequirement->first()->is_active == 1){
                        $OrganizationTrainingLibrary->isChecked = 1;
                    }else{
                        $OrganizationTrainingLibrary->isChecked = 0;
                    }
                }else{
                    $OrganizationTrainingLibrary->isChecked = 0;
                }
            }
        }
        return response()->json(['status'=>true,'code'=>200,'data'=>$OrganizationTrainingLibrarys],200);
    }

    public function getUserListByLearningPlanId($id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $users = User::join('lms_roles as role','role.role_id','lms_user_master.role_id')
        ->leftjoin('lms_job_title','lms_job_title.job_title_id','=','lms_user_master.job_title')
        ->leftjoin('lms_division','lms_division.division_id','=','lms_user_master.divisions')
        ->leftjoin('lms_area','lms_area.area_id','=','lms_user_master.area')
        ->leftjoin('lms_location','lms_location.location_id','=','lms_user_master.location')
        ->where('lms_user_master.is_active','=','1')
        ->where('lms_user_master.org_id',$organizationId)
        ->select('user_id as userId','first_name as firstName','last_name as lastName', 'role.role_name as roleName','email_id as email','lms_job_title.job_title_name as jobTitle','lms_division.division_name AS divisions', 'lms_area.area_name AS area', 'lms_location.location_name AS location','lms_user_master.is_active')
        ->get();
        if($users->count() > 0){
            foreach($users as $userData){
                if($id !== 0)
                {
                    $OrganizationLearningPlanUsers = OrganizationLearningPlanUsers::where('user_id',$userData->userId)
                    ->where('org_id',$organizationId)
                    ->where('learning_plan_id',$id);
                    if($OrganizationLearningPlanUsers->count() > 0){
                        $userData->isChecked = $OrganizationLearningPlanUsers->first()->is_active;
                        continue;
                    }
                }               
               else{
                    $userData->isChecked = 0;
                }
            }
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$users],200);
    }
    public function getJobTitleListByLearningPlanId($id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $jobTitles = JobTitle::where('lms_job_title.is_active','=','1')
        ->where('org_id',$organizationId)
        ->select('job_title_id as jobTitleId','job_title_name as jobTitleName','job_title_code as jobTitleCode')
        ->get();
        if($jobTitles->count() > 0){
            foreach($jobTitles as $jobTitle){

                if($id !== 0)
                {
                    $OrganizationLearningPlanJobTitles = OrganizationLearningPlanJobTitles::where('job_title_id',$jobTitle->jobTitleId)
                    ->where('org_id',$organizationId)
                    ->where('learning_plan_id',$id);

                    if($OrganizationLearningPlanJobTitles->count() > 0){
                        $jobTitle->isChecked = $OrganizationLearningPlanJobTitles->first()->is_active;
                        continue;
                    }
                }               
               else{
                    $jobTitle->isChecked = 0;
                }
            }
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$jobTitles],200);
    }

    public function getGroupsListByLearningPlanId($id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        
        $GroupOrganizations = GroupOrganization::where('lms_group_org.is_active','=','1')
        ->where('org_id',$organizationId)
        ->select('group_id as groupId','group_name as groupName','group_code as groupCode')
        ->get();
        if($GroupOrganizations->count() > 0){
            foreach($GroupOrganizations as $GroupOrganization){

                if($id !== 0)
                {
                    $OrganizationLearningPlanGroups = OrganizationLearningPlanGroups::where('group_id',$GroupOrganization->groupId)
                    ->where('org_id',$organizationId)
                    ->where('learning_plan_id',$id);

                    if($OrganizationLearningPlanGroups->count() > 0){
                        $GroupOrganization->isChecked = $OrganizationLearningPlanGroups->first()->is_active;
                        continue;
                    }
                }               
               else{
                    $GroupOrganization->isChecked = 0;
                }
            }
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$GroupOrganizations],200);
    }

    //Below API's are not required at the moment

    // public function deleteOrgLearningPlanRequirementById($id){
    //     $authId = Auth::user()->user_id;
    //     $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::where('is_active','!=','0')->find($id);
    //     if(is_null($OrganizationLearningPlanRequirement)){
    //         return response()->json(['status'=>true,'code'=>400,'error'=>'Learning plan requirement not found.'],400);
    //     }
    //     $OrganizationLearningPlanRequirement->is_active = 0; 
    //     $OrganizationLearningPlanRequirement->modified_id = $authId;
    //     $OrganizationLearningPlanRequirement->save();
    //     return response()->json(['status'=>true,'code'=>200,'message'=>'Learning plan requirement has been deleted successfully.'],200); 
    // }

    // public function learningPlanUserAssignment(Request $request){

    //     $organizationId = Auth::user()->org_id;
    //     $validator = Validator::make($request->all(), [
    //         'users' => 'required|array',
    //         'learningPlanIds' => 'required|array'
    //     ]);

    //     if ($validator->fails())
    //     {
    //         return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
    //     }

    //     $users = $request->users;
    //     $learningPlanIds = $request->learningPlanIds;

    //     foreach($users as $user){

    //         $userId = @$user['id'];
    //         $isChecked = @$user['isChecked'] ? $user['isChecked'] : 0;

    //         foreach($learningPlanIds as $learningPlanId){

    //             $learningPlanUserAssignment = LearningPlanUserAssignment::where('user_id',$userId)->where('org_id',$organizationId)->where('learning_plan_id',$learningPlanId);
    //             if($learningPlanUserAssignment->count() > 0){

    //                 $learningPlanUserAssignment->update([
    //                     'is_active' => $isChecked
    //                 ]);

    //             }else{
    //                 $learningPlanUserAssignment = new LearningPlanUserAssignment;
    //                 $learningPlanUserAssignment->learning_plan_id = $learningPlanId;
    //                 $learningPlanUserAssignment->user_id = $userId;
    //                 $learningPlanUserAssignment->org_id = $organizationId;
    //                 $learningPlanUserAssignment->is_active = $isChecked;
    //                 $learningPlanUserAssignment->save();
    //             }
    //         }
    //     }
    //     return response()->json(['status'=>true,'code'=>200,'message'=>'Learning plan assignment successfully.'],200);
    // }

    // public function getOrgLearningPlanRequirementById($id){
    //     $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::
    //     leftJoin('lms_org_training_library','lms_org_training_library.training_id','=','lms_org_learning_plan_requirements.requirement_id')
    //     ->leftJoin('lms_training_types','lms_training_types.training_type_id','=','lms_org_training_library.training_type_id')
    //     ->where('lms_org_learning_plan_requirements.is_active','!=','0')
    //     ->select('lms_org_learning_plan_requirements.id','lms_org_learning_plan_requirements.requirement_id as requirementId','lms_training_types.training_type as type','lms_org_training_library.training_name as requirementName','lms_org_learning_plan_requirements.orders',
    //         'lms_org_learning_plan_requirements.due_date_value as dueDateValue','lms_org_learning_plan_requirements.from_date_of_assign as fromDateOfAssign','lms_org_learning_plan_requirements.from_date_of_expiration as fromDateOfExpiration',
    //         'lms_org_learning_plan_requirements.from_order_of_previous_completion as fromOrderOfPreviousCompletion',
    //         'lms_org_learning_plan_requirements.expiration_date_value as expirationDateValue','lms_org_learning_plan_requirements.from_date_of_completion as fromDateOfCompletion','lms_org_learning_plan_requirements.from_date_of_assignment as fromDateOfAssignment',
    //         'lms_org_learning_plan_requirements.is_active as isActive')
    //     ->find($id);
    //     if(is_null($OrganizationLearningPlanRequirement)){
    //         return response()->json(['status'=>true,'code'=>400,'error'=>'Learning plan requirement not found.'],400);
    //     }
    //     return response()->json(['status'=>true,'code'=>200,'data'=>$OrganizationLearningPlanRequirement],200);
    // }

    // public function updateOrgLearningPlanRequirementById(Request $request,$id){
    //     $authId = Auth::user()->user_id;
    //     $organizationId = Auth::user()->org_id;

    //     $OrganizationLearningPlanRequirement = OrganizationLearningPlanRequirement::find($id);
    //     if(is_null($OrganizationLearningPlanRequirement)){
    //         return response()->json(['status'=>true,'code'=>400,'error'=>'Learning Plan requirement not found.'],400);
    //     }
    //     //$OrganizationLearningPlanRequirement->requirement_id = $request->requirementId;
    //     $OrganizationLearningPlanRequirement->due_date_value = $request->dueDateValue;
    //     $OrganizationLearningPlanRequirement->from_date_of_assign = $request->fromDateOfAssign;
    //     $OrganizationLearningPlanRequirement->from_date_of_expiration = $request->fromDateOfExpiration;
    //     $OrganizationLearningPlanRequirement->from_order_of_previous_completion = $request->fromOrderOfPreviousCompletion;
    //     $OrganizationLearningPlanRequirement->expiration_date_value = $request->expirationDateValue;
    //     $OrganizationLearningPlanRequirement->from_date_of_completion = $request->fromDateOfCompletion;
    //     $OrganizationLearningPlanRequirement->from_date_of_assignment = $request->fromDateOfAssignment;
    //     $OrganizationLearningPlanRequirement->modified_id = $authId;
    //     $OrganizationLearningPlanRequirement->save();

    //     return response()->json(['status'=>true,'code'=>200,'message'=>'Learning plan requirement has been updated successfully.'],200);
    // }


}
