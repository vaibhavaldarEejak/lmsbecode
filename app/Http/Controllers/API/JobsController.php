<?php

namespace App\Http\Controllers\API;

use App\Models\Jobs;
use App\Models\UserLearningPlan;
use App\Models\UserTrainingAssignment;
use App\Models\OrganizationCertificate;
use App\Models\Transcript;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;
use PDF;
use Aws\S3\S3Client;
use Illuminate\Support\Str;

class JobsController extends BaseController
{

    public function addlearningPlan(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $jobs = Jobs::
        leftJoin('lms_job_type','lms_jobs.job_type_id','=','lms_job_type.job_type_id')
        ->leftJoin('lms_org_learning_plan','lms_jobs.data_table_id','=','lms_org_learning_plan.learning_plan_id')
        ->leftJoin('lms_learning_plan_users','lms_jobs.data_table_id','=','lms_learning_plan_users.learning_plan_id')
        ->leftJoin('lms_learning_plan_requirements','lms_jobs.data_table_id','=','lms_learning_plan_requirements.learning_plan_id')
        ->where('lms_jobs.job_type_id','=',3)
        ->where('lms_jobs.is_active','=',1)
        ->select('lms_jobs.lms_job_id  AS lms_job_id','lms_jobs.data_table_id AS learning_plan_id','lms_learning_plan_users.user_id','lms_learning_plan_requirements.requirement_id','lms_learning_plan_requirements.requirement_type','lms_org_learning_plan.org_id','lms_learning_plan_requirements.orders','lms_learning_plan_requirements.due_date_type','lms_learning_plan_requirements.due_date_value','lms_jobs.date_created AS assignDate')
        ->groupBy('lms_jobs.data_table_id')
        ->orderBy('data_table_id', 'asc')
        ->get();
        foreach ($jobs as $jobItems) {

            $UserLearningDetail = UserLearningPlan::where('learning_plan_id',$jobItems->learning_plan_id)->first();
        
            if (is_null($UserLearningDetail)) {
                $UserLearningPlan = new UserLearningPlan;
            }
            else{
                $UserLearningPlan = $UserLearningDetail;
            }

            $UserLearningPlan->learning_plan_id = $jobItems->learning_plan_id;
            $UserLearningPlan->user_id = $jobItems->user_id;
            $UserLearningPlan->requirement_id = $jobItems->requirement_id;
            $UserLearningPlan->requirement_type = $jobItems->requirement_type;
            $UserLearningPlan->org_id = $jobItems->org_id;
            $UserLearningPlan->orders = $jobItems->orders;
            $UserLearningPlan->assign_date = $jobItems->assignDate;

            if($jobItems->due_date_type == 1){

                if($jobItems->due_date_value && $jobItems->assignDate){
                     $assignDate = is_string($jobItems->assignDate) ? \Carbon\Carbon::parse($jobItems->assignDate) : $jobItems->assignDate;
                    $due_date = $assignDate->addDays($jobItems->due_date_value);
                    $UserLearningPlan->due_date = $due_date;
                }
            }

            $UserLearningPlan->created_id = $authId;
            $UserLearningPlan->save();

           $jobsDetail = Jobs::where('data_table_id', $jobItems->learning_plan_id)
                ->where('is_active', 1)
                ->where('job_type_id', 3) 
                ->get();

            if (!$jobsDetail->isEmpty()) {
                Jobs::where('data_table_id', $jobItems->learning_plan_id)
                    ->where('is_active', 1)
                    ->where('job_type_id', 3)
                    ->update(['is_active' => 0]);
            }
        }

        return response()->json(['status' => true, 'code' => 200, 'data' => "Data inserted Sucessfully"], 200);
    }

    public function addassignmentPlan(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $jobs = Jobs::
        leftJoin('lms_job_type','lms_jobs.job_type_id','=','lms_job_type.job_type_id')
        ->Join('lms_org_assignment_user_course','lms_jobs.data_table_id','=','lms_org_assignment_user_course.assignment_id')
        ->leftJoin('lms_org_training_library', 'lms_org_training_library.training_id', '=', 'lms_org_assignment_user_course.training_id')
        ->where('lms_jobs.job_type_id','=',5)
        ->where('lms_jobs.job_process','add_new_assignment_plan')
        ->where('lms_jobs.is_active','=',1)
        ->where('lms_org_assignment_user_course.is_active','=',1)
        ->select('lms_jobs.data_table_id AS assignment_id','lms_org_assignment_user_course.training_id AS courseId','lms_org_training_library.training_type_id','lms_jobs.date_created AS assignDate','lms_org_assignment_user_course.user_id','lms_org_assignment_user_course.group_id','lms_org_assignment_user_course.org_id','lms_org_assignment_user_course.assignment_due_date As dueDate')
        ->get();
        foreach ($jobs as $jobItems) {

            $userArr = explode(',',$jobItems->user_id);
            $groupArr = explode(',',$jobItems->group_id);

            $userGroup =DB::table('lms_user_org_group')
                    ->whereIn('group_id', $groupArr)
                    ->where('org_id', $organizationId)
                    ->pluck('user_id')
                    ->toArray();

            $userAllArr = array_unique(array_merge($userArr, $userGroup));


             foreach ($userAllArr as $userId) {

                 $UserLearningDetail = UserTrainingAssignment::where('assignment_id',$jobItems->assignment_id)->where('user_id', $userId)->first();
        
                if (is_null($UserLearningDetail)) {
                    $UserTrainingAssignment = new UserTrainingAssignment;
                }
                else{
                    $UserTrainingAssignment = $UserLearningDetail;
                }

                //$UserTrainingAssignment = new UserTrainingAssignment;
                $UserTrainingAssignment->assignment_id = $jobItems->assignment_id;
                $UserTrainingAssignment->training_type_id =  $jobItems->training_type_id;
                $UserTrainingAssignment->training_catalog_id = $jobItems->courseId;
                $UserTrainingAssignment->user_id = $userId;
                $UserTrainingAssignment->org_id = $jobItems->org_id;
                $UserTrainingAssignment->assign_date = $jobItems->assignDate;
                $UserTrainingAssignment->due_date = $jobItems->dueDate;
                $UserTrainingAssignment->created_id = $authId;
                $UserTrainingAssignment->save();
             }

        }

        return response()->json(['status' => true, 'code' => 200, 'data' => "Data inserted Sucessfully"], 200);
    }

    public function generateCertificateCompleted(Request $request){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $jobs = Jobs::
        leftJoin('lms_job_type','lms_jobs.job_type_id','=','lms_job_type.job_type_id')
        ->Join('lms_user_transcript','lms_jobs.data_table_id','=','lms_user_transcript.user_transcript_id')
        ->where('lms_jobs.job_type_id','=',6)
        ->where('lms_jobs.job_process','certificate_generation_job')
        ->where('lms_jobs.is_active','=',1)
        ->select('lms_user_transcript.certificate_id AS certificateId','lms_user_transcript.user_transcript_id')
        ->get();
        foreach ($jobs as $jobItems) {
            $pdfFileLink = "";
            $certificateId = $jobItems->certificateId;
            if($certificateId != ''){
                $OrganizationCertificate = OrganizationCertificate::where('certificate_id',$certificateId);
               
                if($OrganizationCertificate->count() > 0){

                    $OrganizationCertificate = $OrganizationCertificate->first();

                    $dynamicFieldForCertificate = dynamicFieldForCertificate($OrganizationCertificate->cert_structure,$authId);

                    

                    $certificateData = [
                        'cert_structure' => $dynamicFieldForCertificate,
                        'base_language' => $OrganizationCertificate->base_language,
                        'bgimage' => $OrganizationCertificate->bgimage ? getFileS3Bucket(getPathS3Bucket().'/certificate/'.$OrganizationCertificate->bgimage) : '',
                        'meta' => $OrganizationCertificate->meta,
                        'description' => $OrganizationCertificate->description
                    ];

                    $orientation = $OrganizationCertificate->orientation == 'P' ? 'portrait' : 'landscape';
                    $pdf = PDF::loadView('pdf.pdf', $certificateData)->setPaper('a4', $orientation);
                    $pdfContents = $pdf->output();

                    $s3 = new S3Client([
                        'credentials' => [
                            'key'    => env('AWS_ACCESS_KEY_ID'),
                            'secret' => env('AWS_SECRET_ACCESS_KEY'),
                        ],
                        'region' => env('AWS_DEFAULT_REGION'),
                        'version' => 'latest',
                    ]);

                    $fileName = $authId.time().Str::random(16).".pdf";
                    $pdfFileName = getPathS3Bucket()."/user/certificate/$fileName"; // Replace with the desired filename for the PDF
                    $pdfFileLink = "/user/certificate/$fileName";

                    $result = $s3->putObject([
                        'Bucket' => env('AWS_BUCKET'),
                        'Key'    => $pdfFileName,
                        'Body'   => $pdfContents,
                        'ACL'    => 'public-read', // Set the desired ACL for the uploaded file
                    ]);

                }

                 $transcriptDetail = Transcript::where('user_id',$authId)->where('org_id', $organizationId)->find($jobItems->user_transcript_id);
        
                if ($transcriptDetail) {
                    $transcriptDetail->certificate_link = $pdfFileLink;
                    $transcriptDetail->modified_id = $authId;
                    $transcriptDetail->save();
                }

                $jobsDetail = Jobs::where('data_table_id', $jobItems->user_transcript_id)
                ->where('is_active', 1)
                ->where('job_type_id', 6)
                ->get();

                if (!$jobsDetail->isEmpty()) {
                    Jobs::where('data_table_id', $jobItems->user_transcript_id)
                        ->where('is_active', 1)
                        ->where('job_type_id', 6)
                        ->update(['is_active' => 0]);
                }
            }
        }

        return response()->json(['status' => true, 'code' => 200, 'data' => "Data inserted Sucessfully"], 200);
    }
}