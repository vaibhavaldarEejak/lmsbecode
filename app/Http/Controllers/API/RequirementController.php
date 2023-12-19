<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Requirement;
use App\Models\OrganizationLearningPlan;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;

class RequirementController extends BaseController
{

    public function getRequirementList(Request $request){ 
        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;

        $requirements = Requirement::
        leftJoin('lms_org_training_library as trainingLibrary','lms_user_requirement_courses.training_id','=','trainingLibrary.training_id')
        ->leftJoin('lms_image as image','trainingLibrary.image_id','=','image.image_id')
        ->where('lms_user_requirement_courses.user_id',$authId)->where('lms_user_requirement_courses.is_active','1')
        ->where('lms_user_requirement_courses.org_id',$organizationId)
        ->where('trainingLibrary.org_id',$organizationId)
        ->select('lms_user_requirement_courses.training_id as courseLibraryId','trainingLibrary.training_name as courseName','trainingLibrary.description as description','image.image_url as imageUrl',
        DB::raw('(CASE WHEN lms_user_requirement_courses.progress = 1 THEN "Progress" WHEN lms_user_requirement_courses.progress = 2 THEN "Completed" ELSE "Pending" END) AS progress'),
        'lms_user_requirement_courses.date_created as dateCreated',
        'lms_user_requirement_courses.due_date as dueDate',
        DB::raw('(CASE WHEN lms_user_requirement_courses.status = 1 THEN "Open" WHEN lms_user_requirement_courses.status = 2 THEN "Completed" ELSE "Past due" END) AS status')
        )
        ->get();
        if($requirements->count() > 0){
            foreach($requirements as $requirement){
                if($requirement->imageUrl != ''){
                    $requirement->imageUrl = getFileS3Bucket(getPathS3Bucket().'/courses/'.$requirement->imageUrl);
                }
            }
        }
        
        return response()->json(['status'=>true,'code'=>200,'data'=>$requirements],200);
    }

    public function getUserLearningPlanList(Request $request){
        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;

        $learningPlanData = OrganizationLearningPlan ::
        leftJoin('lms_org_training_library','lms_org_training_library.training_id','=','lms_learning_plan_requirements.requirement_id')
        ->leftJoin('lms_training_types','lms_training_types.training_type_id','=','lms_org_training_library.training_type_id')
        ->leftJoin('lms_learning_plan_requirements','lms_learning_plan_requirements.learning_plan_id','=','lms_org_learning_plan.learning_plan_id')
        ->where('lms_learning_plan_requirements.is_active','!=','0')
        ->where('lms_learning_plan_requirements.learning_plan_id',$id);
    }
    public function getUserAssignmentList(Request $request){
    }
}
