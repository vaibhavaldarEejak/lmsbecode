<?php

namespace App\Http\Controllers\API;

use App\Models\TrainingLibrary;
use App\Models\OrganizationTrainingLibrary;
use App\Models\OrganizationCertificate;
use App\Models\StudentInprogress;
use App\Models\UserElearningProgress;
use App\Models\UserClassroomProgress;
use App\Models\UserAssessmentProgress;
use App\Models\UserTrainingHistory;
use App\Models\DynamicField;
use App\Models\Enrollment;
use App\Models\Transcript;
use App\Models\Jobs;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;
use Illuminate\Support\Facades\Storage;
use PDF;
use Aws\S3\S3Client;
use Illuminate\Support\Str;


class EnrollmentController extends BaseController
{

    public function getEnrollmentList(Request $request)
    {
        $organizationId = Auth::user()->org_id;

        $sort = $request->has('sort') ? $request->get('sort') : 'trainingLibrary.training_id';
        $order = $request->has('order') ? $request->get('order') : 'DESC';
        $search = $request->has('search') ? $request->get('search') : '';

        $trainingType = $request->has('trainingType') ? $request->get('trainingType') : '';
        $category = $request->has('category') ? $request->get('category') : '';
        $status = $request->has('status') ? $request->get('status') : '';


        $sortColumn = $sort;
        if ($sort == 'courseCatalogId') {
            $sortColumn = 'trainingLibrary.training_id';
        } elseif ($sort == 'courseTitle') {
            $sortColumn = 'trainingLibrary.training_name';
        } elseif ($sort == 'trainingType') {
            $sortColumn = 'trainingType.training_type';
        } elseif ($sort == 'categoryName') {
            $sortColumn = 'category.category_name';
        } elseif ($sort == 'trainingCode') {
            $sortColumn = 'trainingLibrary.training_code';
        } elseif ($sort == 'status') {
            $sortColumn = 'trainingStatus.training_status';
        } elseif ($sort == 'isActive') {
            $sortColumn = 'trainingLibrary.is_active';
        }

        $courseCatalogs = DB::table('lms_org_training_library as trainingLibrary')
            ->join('lms_training_types as trainingType', 'trainingLibrary.training_type_id', '=', 'trainingType.training_type_id')
            ->join('lms_training_status as trainingStatus', 'trainingLibrary.training_status_id', '=', 'trainingStatus.training_status_id')
            ->join('lms_image as image', 'image.image_id', '=', 'trainingLibrary.image_id')
            ->where('trainingLibrary.is_active', '!=', '0')
            ->where('trainingLibrary.org_id', $organizationId)
            ->where('trainingType.training_type_id', 2)
            ->where(function ($query) use ($search) {
                if ($search != '') {
                    $query->where('trainingLibrary.training_id', 'LIKE', '%' . $search . '%');
                    $query->orWhere('trainingLibrary.training_name', 'LIKE', '%' . $search . '%');
                    $query->orWhere('trainingType.training_type', 'LIKE', '%' . $search . '%');
                    $query->orWhere('trainingLibrary.training_code', 'LIKE', '%' . $search . '%');
                    $query->orWhere('trainingStatus.training_status', 'LIKE', '%' . $search . '%');
                    if (in_array($search, ['active', 'act', 'acti', 'activ'])) {
                        $query->orWhere('trainingLibrary.is_active', '1');
                    }
                    if (in_array($search, ['inactive', 'inact', 'inacti', 'inactiv'])) {
                        $query->orWhere('trainingLibrary.is_active', '2');
                    }
                }
            })
            ->where(function ($query) use ($trainingType, $category, $status) {
                if ($trainingType != '') {
                    $query->where('trainingLibrary.training_type_id', '=', $trainingType);
                    $query->where('trainingLibrary.training_status_id', '=', '2');
                }
                if ($status != '') {
                    $query->where('trainingLibrary.training_status_id', '=', $status);
                }
            })
            ->orderBy($sortColumn, $order)
            ->select(
                'trainingLibrary.training_id as courseLibraryId',
                'trainingLibrary.training_library_id as trainingLibraryId',
                'trainingLibrary.content_type as contentTypesId',
                'trainingLibrary.training_name as courseTitle',
                'trainingLibrary.training_code as trainingCode',
                'trainingLibrary.reference_code as referenceCode',
                'trainingType.training_type_id as trainingTypeId',
                'trainingType.training_type as trainingType',
                'trainingStatus.training_status as status',
                'trainingLibrary.category_id as categoryName',
                'trainingLibrary.is_active as isActive',
                'image.image_url as courseImage',
                'trainingLibrary.is_modified as isModified',
                'trainingLibrary.student_rating as studentRating',
                'trainingLibrary.date_modified as dateModified'
            )
            ->get()->toArray();
        foreach ($courseCatalogs as $courseCatalog) {


            $classes = DB::table('lms_org_training_classes AS training_class')
                ->leftjoin('lms_org_classroom_class_sessions as class_session', 'class_session.class_id', '=', 'training_class.class_id')
                ->leftJoin('lms_user_master', 'lms_user_master.user_id', '=', 'class_session.instructor_id')
                ->where('training_class.is_active', '!=', '0')
                ->where('training_class.org_id', $organizationId)
                ->where('training_class.training_catalog_id', $courseCatalog->courseLibraryId)
                ->select(
                    'training_class.class_id  as classId',
                    'training_class.class_name as className',
                    'max_seats as maxSeats',
                    'total_hours as totalHours',
                    'start_date as startDate',
                    'end_date as endDate',
                    'class_session.date as sessionDate',
                    'class_session.hrs as hrs',
                    'class_session.minutes as minutes',
                    'class_session.location as location',
                    DB::raw('CONCAT(lms_user_master.first_name," ",lms_user_master.last_name) AS instructor')
                )
                ->get()->toArray();

            $groupedClasses = [];

            foreach ($classes as $class) {
                $classId = $class->classId;

                // Check if the class is already in the grouped array
                if (!isset($groupedClasses[$classId])) {
                    $groupedClasses[$classId] = [
                        'classId' => $classId,
                        'className' => $class->className,
                        'maxSeats' => $class->maxSeats,
                        'totalHours' => $class->totalHours,
                        'startDate' => $class->startDate,
                        'endDate' => $class->endDate,
                        'sessions' => [],
                    ];
                }

                if (!is_null($class->sessionDate)) {
                    $groupedClasses[$classId]['sessions'][] = [
                        'Date' => $class->sessionDate,
                        'hours' => $class->hrs,
                        'minutes' => $class->minutes,
                        'location' => $class->location,
                        'instructor' => $class->instructor
                    ];

                }
            }

            $courseCatalog->class = array_values($groupedClasses);
        }

        return response()->json(['status' => true, 'code' => 200, 'data' => $courseCatalogs], 200);
    }

    public function getEnrollmentByCourseId($courseId)
    {
        $organizationId = Auth::user()->org_id;

        $courseCatalogs = DB::table('lms_org_training_library as trainingLibrary')
            ->where('trainingLibrary.is_active', '!=', '0')
            ->where('trainingLibrary.org_id', $organizationId)
            ->where('trainingLibrary.training_type_id', 2)
            ->where('trainingLibrary.training_id', $courseId);

        if ($courseCatalogs->count() < 1) {
            return response()->json(['status' => false, 'code' => 404, 'error' => 'Course is not found.'], 404);
        }

        $courseCatalogs = $courseCatalogs->join('lms_training_types as trainingType', 'trainingLibrary.training_type_id', '=', 'trainingType.training_type_id')
            ->join('lms_training_status as trainingStatus', 'trainingLibrary.training_status_id', '=', 'trainingStatus.training_status_id')
            ->join('lms_image as image', 'image.image_id', '=', 'trainingLibrary.image_id')
            ->select(
                'trainingLibrary.training_id as courseLibraryId',
                'trainingLibrary.training_library_id as trainingLibraryId',
                'trainingLibrary.content_type as contentTypesId',
                'trainingLibrary.training_name as courseTitle',
                'trainingLibrary.training_code as trainingCode',
                'trainingLibrary.reference_code as referenceCode',
                'trainingType.training_type_id as trainingTypeId',
                'trainingType.training_type as trainingType',
                'trainingStatus.training_status as status',
                'trainingLibrary.category_id as categoryName',
                'trainingLibrary.is_active as isActive',
                'image.image_url as courseImage',
                'trainingLibrary.is_modified as isModified',
                'trainingLibrary.student_rating as studentRating',
                'trainingLibrary.date_modified as dateModified'
            )
            ->get()->toArray();
        foreach ($courseCatalogs as $courseCatalog) {


            $classes = DB::table('lms_org_training_classes AS training_class')
                ->leftjoin('lms_org_classroom_class_sessions as class_session', 'class_session.class_id', '=', 'training_class.class_id')
                ->leftJoin('lms_user_master', 'lms_user_master.user_id', '=', 'class_session.instructor_id')
                ->where('training_class.is_active', '!=', '0')
                ->where('training_class.org_id', $organizationId)
                ->where('training_class.training_catalog_id', $courseCatalog->courseLibraryId)
                ->select(
                    'training_class.class_id  as classId',
                    'training_class.class_name as className',
                    'max_seats as maxSeats',
                    'total_hours as totalHours',
                    'start_date as startDate',
                    'end_date as endDate',
                    'class_session.date as sessionDate',
                    'class_session.hrs as hrs',
                    'class_session.minutes as minutes',
                    'class_session.location as location',
                    DB::raw('CONCAT(lms_user_master.first_name," ",lms_user_master.last_name) AS instructor')
                )
                ->get()->toArray();

            $groupedClasses = [];

            foreach ($classes as $class) {
                $classId = $class->classId;

                // Check if the class is already in the grouped array
                if (!isset($groupedClasses[$classId])) {
                    $groupedClasses[$classId] = [
                        'classId' => $classId,
                        'className' => $class->className,
                        'maxSeats' => $class->maxSeats,
                        'totalHours' => $class->totalHours,
                        'startDate' => $class->startDate,
                        'endDate' => $class->endDate,
                        'sessions' => [],
                    ];
                }

                if (!is_null($class->sessionDate)) {
                    $groupedClasses[$classId]['sessions'][] = [
                        'Date' => $class->sessionDate,
                        'hours' => $class->hrs,
                        'minutes' => $class->minutes,
                        'location' => $class->location,
                        'instructor' => $class->instructor
                    ];

                }
            }

            $courseCatalog->class = array_values($groupedClasses);
        }

        return response()->json(['status' => true, 'code' => 200, 'data' => $courseCatalogs], 200);
    }


    public function addEnrollment(Request $request)
    {

        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;

        $validator = Validator::make($request->all(), [
            'courseLibraryId' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        $enrollment = Enrollment::where('org_id', $organizationId)->where('user_id', $authId)
            ->where('training_id', $request->courseLibraryId);
        if ($enrollment->count() > 0) {
            return response()->json(['status' => true, 'code' => 400, 'error' => 'Enrollment is already exist.'], 400);
        }

        $enrollment = new Enrollment;
        $enrollment->training_id = $request->courseLibraryId;
        $enrollment->org_id = $organizationId;
        $enrollment->user_id = $authId;
        $enrollment->created_id = $authId;
        $enrollment->modified_id = $authId;
        $enrollment->save();

        return response()->json(['status' => true, 'code' => 200, 'message' => 'Enrollment has been created successfully.'], 200);
    }

    public function studentInprogressCourse(Request $request)
    {
        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;

        $validator = Validator::make($request->all(), [
            'courseId' => 'required',
            'progress' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'code' => 400, 'errors' => $validator->errors()->all()], 400);
        }

        $catalogs = DB::table('lms_org_assignment_user_course')->where('courses', $request->courseId)->where('users', $authId)->where('org_id', $organizationId);
        if ($catalogs->count() > 0) {
            $catalogs->update([
                'progress' => $request->progress,
                'date_modified' => date('Y-m-d H:i:s'),
                'modified_id' => $authId,
            ]);
        }

        return response()->json(['status' => true, 'code' => 200, 'message' => 'Updated successfully.'], 200);
    }

    public function studentCompletedCourse(Request $request)
    {
        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;
        $objectURL = '';
        $fileName = '';
        $pdfFileName = "";

        /*$studentRating = 0;
        $studentCourse = DB::table('lms_org_assignment_user_course')->where('courses',$request->courseId)->where('org_id',$organizationId);
        if($studentCourse->count() > 0){

            $noOfStudent = $studentCourse->count();
            $totalSum = $studentCourse->sum('rating');

            $studentRating = $totalSum/$noOfStudent;
        }*/

        $certificateId = 0;

        $OrganizationTrainingLibrary = OrganizationTrainingLibrary::where('training_id',$request->courseId);
        if($OrganizationTrainingLibrary->count() > 0){
            /*$OrganizationTrainingLibrary->update([
                'student_rating'=>$studentRating
            ]);*/

            $certificateId = $OrganizationTrainingLibrary->first()->certificate_id;
            /* #certificate
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
                    $result = $s3->putObject([
                        'Bucket' => env('AWS_BUCKET'),
                        'Key'    => $pdfFileName,
                        'Body'   => $pdfContents,
                        'ACL'    => 'public-read', // Set the desired ACL for the uploaded file
                    ]);

                }
            }*/
        }

        $transcriptDetail = Transcript::where('user_id',$authId)->where('org_id', $organizationId)->where('training_catalog_id', $request->courseId)->first();
        
        if (is_null($transcriptDetail)) {
            $transcript = new Transcript;
        }
        else{
            $transcript = $transcriptDetail;
        }

        $transcript->user_id = $authId;
        $transcript->org_id = $organizationId;
        $transcript->training_catalog_id = $request->courseId;
        //$transcript->notes = $request->comment;
        $transcript->certificate_id = $certificateId;
        //$transcript->certificate_link = $pdfFileName;
        $transcript->completion_date = date('Y-m-d');
        $transcript->created_id = $authId;
        $transcript->modified_id = $authId;
        $transcript->save();

        $jobsDetail = Jobs::where('job_type_id',6)->where('data_table_id', $transcript->user_transcript_id)->where('job_process', 'certificate_generation_job')->first();
        
            if (is_null($jobsDetail)) {
                $learningPlanJob = new Jobs;
            }
            else{
                $learningPlanJob = $jobsDetail;
            }
            
            $learningPlanJob->job_name = 'Certificate Generation for completed Training';
            $learningPlanJob->job_type_id = 6;
            $learningPlanJob->job_process = 'certificate_generation_job';
            $learningPlanJob->data_table_id = $transcript->user_transcript_id ;
            $learningPlanJob->job_data = serialize($transcript->toArray());
            $learningPlanJob->is_active = 1;
            $learningPlanJob->created_id = $authId;
            $learningPlanJob->save();

            

             $StudentInprogressDetail = StudentInprogress::where('training_catalog_id',$request->courseId)->where('user_id', $authId)->where('org_id', $organizationId)->first();
            
            $UserTrainingHistory = new UserTrainingHistory();
            $UserTrainingHistory->user_training_id = $StudentInprogressDetail->user_training_id;
            $UserTrainingHistory->training_catalog_id = $StudentInprogressDetail->training_catalog_id;
            $UserTrainingHistory->training_type_id = $StudentInprogressDetail->training_type_id;
            $UserTrainingHistory->training_name = $StudentInprogressDetail->course_name;
            $UserTrainingHistory->training_code = $StudentInprogressDetail->course_code;
            $UserTrainingHistory->content_id = $StudentInprogressDetail->content_id;
            $UserTrainingHistory->version = $StudentInprogressDetail->version;
            $UserTrainingHistory->user_id = $StudentInprogressDetail->user_id;
            $UserTrainingHistory->org_id = $StudentInprogressDetail->org_id;
            $UserTrainingHistory->start_date = $StudentInprogressDetail->start_date;
            $UserTrainingHistory->date_of_completion = date('Y-m-d');
            $UserTrainingHistory->save();
        
            if ($StudentInprogressDetail) {
                //$StudentInprogressDetail->status = 1;
                $StudentInprogressDetail->status = 3;
                $StudentInprogressDetail->save();

                $UserProgressDetails = [];

                if($StudentInprogressDetail->training_type_id==1){
                    $UserProgressDetails = UserElearningProgress::where('user_training_catalog_id',$request->courseId)->first();
                }
                elseif($StudentInprogressDetail->training_type_id==2){
                    $UserProgressDetails = UserClassroomProgress::where('user_training_catalog_id',$request->courseId)->first();
                }
                elseif($StudentInprogressDetail->training_type_id==3){
                    $UserProgressDetails = UserAssessmentProgress::where('user_training_catalog_id',$request->courseId)->first();
                }

                if($UserProgressDetails){
                    $UserProgressDetails->is_active = 0;
                    $UserProgressDetails->save();
                }

            }

            
        

        return response()->json(['status'=>true,'code'=>200,'message'=>'Updated successfully.'],200);
    } 
}
