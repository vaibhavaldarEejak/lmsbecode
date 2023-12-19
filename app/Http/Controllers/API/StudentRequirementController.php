<?php

namespace App\Http\Controllers\API;

use App\Models\UserLearningPlan;
use App\Models\UserTrainingAssignment;
use App\Models\OrganizationTrainingLibrary;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;

class StudentRequirementController extends BaseController
{

    public function getStudentLearningPlanList(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

         $UserLearningPlan = UserLearningPlan::
            leftJoin('lms_org_learning_plan', 'lms_org_learning_plan.learning_plan_id', '=', 'user_learning_plan.learning_plan_id')
            ->leftJoin('lms_learning_plan_requirements', 'lms_learning_plan_requirements.learning_plan_requirement_id', '=', 'user_learning_plan.requirement_id')
            ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'user_learning_plan.requirement_id')
            ->leftJoin('lms_training_types', 'lms_training_types.training_type_id', '=', 'user_learning_plan.requirement_type')
            ->where('user_learning_plan.is_active', '!=', '0')
            ->where('user_learning_plan.org_id', $organizationId)
            ->where('user_learning_plan.user_id', $authId)
            ->select('lms_org_learning_plan.learning_plan_name as learningPlanName', 'lms_org_learning_plan.learning_plan_id as learningPlanId', 'lms_org_training_library.training_id AS requirementId', 'lms_org_training_library.training_name AS trainingName', 'lms_training_types.training_type AS trainingType', 'user_learning_plan.orders AS orders','user_learning_plan.assign_date AS assignDate','lms_learning_plan_requirements.learning_plan_requirement_id  AS learningPlanRequirementId', 'lms_learning_plan_requirements.due_date_type  AS dueDateType', 'lms_learning_plan_requirements.due_date_value  AS dueDateValue', 'lms_learning_plan_requirements.expiration_date_type  AS expirationDateType', 'lms_learning_plan_requirements.expiration_date_value  AS expirationDateValue')
            ->orderBy('orders', 'asc')
            ->get();

        $responseData = [];
        foreach ($UserLearningPlan as $plan) {
            $learningPlanId = $plan->learningPlanId;

            if (!isset($responseData[$learningPlanId])) {
                $responseData[$learningPlanId] = [
                    'learningPlanName' => $plan->learningPlanName,
                    'learningPlanId' => $plan->learningPlanId,
                    'learningPlanRequirements' => [],
                ];
            }

            $requirement = [
                'requirementId' => $plan->requirementId,
                'trainingName' => $plan->trainingName,
                'trainingType' => $plan->trainingType,
                'orders' => $plan->orders,
                'learningPlanRequirementId' => $plan->learningPlanRequirementId,
                'dueDateType' => $plan->dueDateType,
                'dueDateValue' => $plan->dueDateValue,
                'expirationDateType' => $plan->expirationDateType,
                'expirationDateValue' => $plan->expirationDateValue,
            ];

            $responseData[$learningPlanId]['learningPlanRequirements'][] = $requirement;
        }

        $responseData = array_values($responseData); 

        return response()->json(['status' => true, 'code' => 200, 'data' => $responseData], 200);
    }

    public function getStudentAssignmentList(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $UserLearningPlan  = UserTrainingAssignment::
        leftJoin('lms_org_assignment_user_course', 'lms_org_assignment_user_course.assignment_id', '=', 'user_training_assignments.assignment_id') 
        ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'lms_org_assignment_user_course.training_id')          
        ->select('user_training_assignments.user_id',
        'lms_org_assignment_user_course.assignment_id as assignmentId',
        'lms_org_assignment_user_course.assignment_due_date as assignmentDueDate',
        'lms_org_training_library.training_id AS trainingId','lms_org_training_library.training_name AS trainingName','lms_org_training_library.training_type_id  AS trainingType','description AS trainingDescription','user_training_assignments.assign_date AS assignDate')
        ->where('user_training_assignments.org_id', $organizationId)
         ->where('user_training_assignments.user_id', $authId)
        ->get();

       /* $transformedData = [];

        foreach ($UserLearningPlan as $item) {
            $assignmentName = $item['assignmentName'];

            if (!isset($transformedData[$assignmentName])) {
                $transformedData[$assignmentName] = [
                    'assignmentId' => $item['assignmentId'],
                    'assignmentName' => $assignmentName,
                    'assignmentDueDate' => $item['assignmentDueDate'],
                    'assignedTraining' => [],
                ];
            }

            $UserTrainingPlan = OrganizationTrainingLibrary::    
            where('lms_org_training_library.training_id',$item['training_id'])
            ->select('lms_org_training_library.training_id AS trainingId','training_name AS trainingName','training_type_id  AS trainingType')
            ->get();

             foreach ($UserTrainingPlan as $plan) {
                $transformedData[$assignmentName]['assignedTraining'][] = [
                    'trainingId' => $plan['trainingId'],
                    'trainingName' => $plan['trainingName'],
                    'trainingType' => $plan['trainingType'],
                ];
            }
        }

        // Convert the transformed data into a numerical array
        $transformedData = array_values($transformedData);*/

        return response()->json(['status' => true, 'code' => 200, 'data' => $UserLearningPlan], 200);
    }

    public function getStudentAllList(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $UserLearningPlan = UserLearningPlan::
            leftJoin('lms_org_learning_plan', 'lms_org_learning_plan.learning_plan_id', '=', 'user_learning_plan.learning_plan_id')
            ->leftJoin('lms_learning_plan_requirements', 'lms_learning_plan_requirements.learning_plan_requirement_id', '=', 'user_learning_plan.requirement_id')
            ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'user_learning_plan.requirement_id')
            ->leftJoin('lms_training_types', 'lms_training_types.training_type_id', '=', 'user_learning_plan.requirement_type')
            ->where('user_learning_plan.is_active', '!=', '0')
            ->where('user_learning_plan.org_id', $organizationId)
            ->where('user_learning_plan.user_id', $authId)
            ->select(
                 DB::raw("CONCAT('lp-', lms_org_learning_plan.learning_plan_id) AS requirementId"),
                'lms_org_learning_plan.learning_plan_name as requirementName',
                'lms_org_training_library.training_name AS trainingName',
                'lms_training_types.training_type_id AS trainingTypeId',
                'lms_training_types.training_type AS trainingType',
                DB::raw("'Learning Plan' AS requirementType"),
                'user_learning_plan.due_date AS dueDate',
                'user_learning_plan.assign_date AS assignDate'
            )
           ->orderBy('user_learning_plan.due_date', 'desc');

        $UserRequirementPlan  = UserTrainingAssignment::
        leftJoin('lms_org_assignment_user_course', 'lms_org_assignment_user_course.assignment_id', '=', 'user_training_assignments.assignment_id') 
        ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'lms_org_assignment_user_course.training_id')
         ->leftJoin('lms_training_types', 'lms_training_types.training_type_id', '=', 'lms_org_training_library.training_type_id')         
        ->select(DB::raw("CONCAT('as-', lms_org_assignment_user_course.assignment_id) as requirementId"),'lms_org_assignment_user_course.assignment_name as requirementName','lms_org_training_library.training_name AS trainingName','lms_org_training_library.training_type_id  AS trainingTypeId','lms_training_types.training_type  AS trainingType', DB::raw("'Assignment' AS requirementType"),'user_training_assignments.due_date AS dueDate','user_training_assignments.assign_date AS assignDate')
        ->where('user_training_assignments.org_id', $organizationId)
         ->where('user_training_assignments.user_id', $authId)
          ->where('user_training_assignments.due_date', 'IS NOT', null)
         ->orderBy('user_training_assignments.due_date', 'desc');

        //$combinedArray = array_merge($UserLearningPlan->toArray(), $UserRequirementPlan->toArray());

        $combinedResults = $UserLearningPlan->union($UserRequirementPlan)->orderBy('dueDate', 'desc')->get();


        return response()->json(['status' => true, 'code' => 200, 'data' => $combinedResults], 200);
    }

  

    
}