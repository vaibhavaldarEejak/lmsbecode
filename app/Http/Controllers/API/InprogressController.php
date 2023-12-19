<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\StudentInprogress;
use App\Models\UserElearningProgress;
use App\Models\UserClassroomProgress;
use App\Models\UserAssessmentProgress;
use App\Models\UserTrainingHistory;
use App\Models\OrganizationCategory;
use Illuminate\Http\Request;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;
use Illuminate\Support\Facades\Storage;
use PDF;
use Aws\S3\S3Client;
use Validator;
use Illuminate\Support\Str;


class InprogressController extends BaseController
{
    public function getInProgressList(Request $request){
        
        $organizationId = Auth::user()->org_id;
        $authId = Auth::user()->user_id;

        $courseArray = [];
        $coursesArray = [];
        $trainingMedias = [];
        $progress = '';
        $imageUrl = '';

        $courses = DB::table('lms_user_training_progress as inprogress')
        ->leftJoin('lms_org_training_library as trainingLibrary','inprogress.training_catalog_id','=','trainingLibrary.training_id')
        ->join('lms_training_types as trainingType','trainingType.training_type_id','=','trainingLibrary.training_type_id')
        ->leftJoin('lms_image as image','trainingLibrary.image_id','=','image.image_id')
        ->leftJoin('lms_content_types as contentTypes','trainingLibrary.content_type','=','contentTypes.content_types_id')
        ->leftJoin('lms_assessment as assessmentSettings','trainingLibrary.training_id','=','assessmentSettings.training_id')
        ->where('inprogress.org_id',$organizationId)
        ->where('inprogress.user_id',$authId)
        ->where('trainingLibrary.org_id',$organizationId)
        ->where('trainingLibrary.is_active','=','1')
        ->select('trainingLibrary.training_id as courseLibraryId',
        'trainingLibrary.training_type_id as trainingTypeId', 
        'trainingType.training_type as trainingType',
        'trainingLibrary.content_type as contentTypeId',
        'trainingLibrary.credits_visible as creditsVisible','assessmentSettings.require_passing_score as passingScore','trainingLibrary.quiz_type as quizType','trainingLibrary.training_name as courseTitle','trainingLibrary.description','image.image_url as imageUrl','trainingLibrary.content_type as contentTypesId','contentTypes.content_type as contentType')
        ->get();
        if($courses->count() > 0){
            foreach($courses as $course){

                // $progress = '';
                // $check = DB::table('lms_org_assignment_user_course')->where('user_id',$authId)->where('courses',$course->courseLibraryId)->where('org_id',$organizationId);
                // if($check->count() > 0){
                //     $progress = $check->first()->progress;
                // }

                $imageUrl = '';
                if($course->imageUrl != ''){
                    $imageUrl = getFileS3Bucket(getPathS3Bucket().'/courses/'.$course->imageUrl); 
                }

                if ($course->trainingTypeId == 1) {
                    $trainingMedia = DB::table('lms_org_training_media')
                        ->join('lms_content_library as medialibrary', 'medialibrary.content_id', '=', 'lms_org_training_media.content_id')
                        ->join('lms_media as media', 'media.media_id', '=', 'medialibrary.media_id')
                        ->leftJoin('lms_scorm_details as scorm', 'medialibrary.media_id', '=', 'scorm.media_id')
                        ->where('lms_org_training_media.training_catalog_id', $course->courseLibraryId)
                        ->where('lms_org_training_media.org_id', $organizationId)
                        ->orderBy('lms_org_training_media.training_media_id', 'DESC');
                    if ($trainingMedia->count() > 0) {
                        $trainingMedia = $trainingMedia
                            ->select(
                                'medialibrary.media_id as mediaId',
                                'medialibrary.content_name as mediaName',
                                'media.media_size as mediaSize',
                                'media.media_type as mediaType',
                                'media.media_url as mediaUrl',
                                'scorm.launch'
                            )
                            ->first();
                        $mediaName = $trainingMedia->mediaName;
                        if ($trainingMedia->mediaType == 'zip' || $trainingMedia->mediaType == 'rar') {
                            if ($trainingMedia->launch) {
                                $mediaUrl = $trainingMedia->mediaUrl;
                                $trainingMedia->mediaUrl = getFileS3Bucket(getPathS3Bucket()) . '/media/' . $mediaUrl . '/' . $mediaName . '/' . $trainingMedia->launch;
                            } else {
                                $mediaHref = '';
                                $mediaUrl = $trainingMedia->mediaUrl;
                                $files = Storage::disk('s3')->allFiles(getPathS3Bucket() . '/media/' . $mediaUrl . '/' . $mediaName);
                                foreach ($files as $file) {
                                    $fileName = substr($file, strrpos($file, "/") + 1);
                                    $fileExtension = pathinfo($fileName, PATHINFO_EXTENSION);
                                    if ($fileName == 'imsmanifest.xml') {
                                        $fileUrl = getFileS3Bucket($file);
                                        $xmlString = file_get_contents($fileUrl);
                                        $xmlObject = simplexml_load_string($xmlString);
                                        $mediaHref = $xmlObject->resources->resource[0]->attributes()->href;
                                    }
                                }
                                $trainingMedia->mediaUrl = getFileS3Bucket(getPathS3Bucket() . '/media/') . $mediaUrl . '/' . $mediaName . '/' . $mediaHref;
                            }
                        } else if ($course->contentTypesId == 5 || $course->contentTypesId == 8) {
                            $trainingMedia->mediaUrl = $trainingMedia->mediaUrl;
                        } else {
                            $trainingMedia->mediaUrl = getFileS3Bucket(getPathS3Bucket() . '/media/' . $trainingMedia->mediaUrl);
                        }
                        $trainingMedias = $trainingMedia;
                    }
                }

                $courseArray['courseLibraryId'] = $course->courseLibraryId;
                $courseArray['courseTitle'] = $course->courseTitle;
                $courseArray['description'] = $course->description;
                $courseArray['imageUrl'] = $imageUrl;
                $courseArray['contentType'] = $course->contentType;
                $courseArray['trainingMedias'] = $trainingMedias;
                $courseArray['trainingTypeId'] = $course->trainingTypeId;
                $courseArray['trainingType'] = $course->trainingType;
                //$courseArray['progress'] = $progress;
                $coursesArray[] = $courseArray;

            }
        }
        
        return response()->json(['status'=>true,'code'=>200,'data'=>$coursesArray],200);
    }

    
    public function addInProgressCourse(Request $request){

        $validator = Validator::make($request->all(), [
            'trainingCatalogId' => 'required'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;
        $UserProgressDetails = [];

        if(isset($request->trainingCatalogId)){
            try{
                $trainingData = DB::table('lms_org_training_library')
                ->where('lms_org_training_library.training_id', '=', $request->trainingCatalogId)
                ->select('lms_org_training_library.training_id as orgTrainingId',
                'lms_org_training_library.training_type_id as trainingType',
                'lms_org_training_library.training_code as courseCode',
                'lms_org_training_library.training_name as courseName')
                ->get();


                $StudentInprogressDetail = StudentInprogress::where('training_catalog_id',$trainingData->first()->orgTrainingId)->where('user_id', $authId)->where('org_id', $organizationId)->first();
        
                if (is_null($StudentInprogressDetail)) {
                    $inProgressCourseData = new StudentInprogress;
                    $inProgressCourseData->status = 1;
                }
                else{
                    $inProgressCourseData = $StudentInprogressDetail;
                    $inProgressCourseData->status = 2;
                }

                $inProgressCourseData->training_catalog_id = $trainingData->first()->orgTrainingId;
                $inProgressCourseData->user_id = $authId;
                $inProgressCourseData->org_id = $organizationId;
                $inProgressCourseData->training_type_id = $trainingData->first()->trainingType;
                $inProgressCourseData->course_code = $trainingData->first()->courseCode;
                $inProgressCourseData->course_name = $trainingData->first()->courseName;
                $inProgressCourseData->save();

                if (is_null($StudentInprogressDetail)) {
                    if($trainingData->first()->trainingType==1){
                        $UserProgressDetails = new UserElearningProgress();
                        $UserProgressDetails->user_training_catalog_id = $trainingData->first()->orgTrainingId;
                    }
                    elseif($trainingData->first()->trainingType==2){
                        $UserProgressDetails = new UserClassroomProgress();
                        $UserProgressDetails->user_training_catalog_id = $trainingData->first()->orgTrainingId;
                    }
                    elseif($trainingData->first()->trainingType==3){
                        $UserProgressDetails = new UserAssessmentProgress();
                        $UserProgressDetails->user_training_catalog_id = $trainingData->first()->orgTrainingId;
                    }
                }
                else{
                    if($trainingData->first()->trainingType==1){
                        $UserProgressDetails = UserElearningProgress::where('user_training_catalog_id',$trainingData->first()->orgTrainingId)->first();
                    }
                    elseif($trainingData->first()->trainingType==2){
                        $UserProgressDetails = UserClassroomProgress::where('user_training_catalog_id',$trainingData->first()->orgTrainingId)->first();
                    }
                    elseif($trainingData->first()->trainingType==3){
                        $UserProgressDetails = UserAssessmentProgress::where('user_training_catalog_id',$trainingData->first()->orgTrainingId)->first();
                    }
                }

                if($UserProgressDetails){
                $progressPerc = rand(10, 100);
                    $UserProgressDetails->user_training_percent_progress = $progressPerc;
                    $UserProgressDetails->user_id = $authId;
                    $UserProgressDetails->is_active = 1;
                    $UserProgressDetails->save();
                }

                $UserTrainingHistory = new UserTrainingHistory();
                $UserTrainingHistory->user_training_id = $inProgressCourseData->user_training_id;
                $UserTrainingHistory->training_catalog_id = $inProgressCourseData->training_catalog_id;
                $UserTrainingHistory->training_type_id = $inProgressCourseData->training_type_id;
                $UserTrainingHistory->training_name = $inProgressCourseData->course_name;
                $UserTrainingHistory->training_code = $inProgressCourseData->course_code;
                $UserTrainingHistory->content_id = $inProgressCourseData->content_id;
                $UserTrainingHistory->version = $inProgressCourseData->version;
                $UserTrainingHistory->user_id = $inProgressCourseData->user_id;
                $UserTrainingHistory->org_id = $inProgressCourseData->org_id;
                $UserTrainingHistory->start_date = $inProgressCourseData->start_date;
                $UserTrainingHistory->save();


                return response()->json(['status'=>true,'code'=>201,'data'=>$inProgressCourseData->user_training_id,'message'=>'Starting Course Please wait'],201);

            } catch (\Throwable $e) {
                return response()->json(['status'=>false,'code'=>501,'message'=>$e->getMessage()],501);
            }
        }
    }


    public function getUserTrainingProgress(Request $request,$userid){
        
        $organizationId = Auth::user()->org_id;

        $courses = DB::table('lms_user_training_progress as inprogress')
        ->leftJoin('lms_org_training_library as trainingLibrary','inprogress.training_catalog_id','=','trainingLibrary.training_id')
        ->leftjoin('lms_training_types as trainingType','trainingType.training_type_id','=','trainingLibrary.training_type_id')
        ->where('inprogress.org_id',$organizationId)
        ->where('inprogress.user_id',$userid)
        ->where('trainingLibrary.org_id',$organizationId)
        ->where('trainingLibrary.is_active','=','1')
        ->select('inprogress.user_training_id as userProgressId','trainingLibrary.training_id as trainingId',
        'trainingLibrary.training_name as trainingName',
        'trainingLibrary.category_id AS categoryId',
        'trainingLibrary.training_type_id as trainingTypeId', 
        'trainingType.training_type as trainingTypeName')
        ->get();

        if (isset($courses)) {
                foreach ($courses as $training) {
                    $categoryArr = explode(',', $training->categoryId);
                    
                    $categoryDetails = OrganizationCategory::where('is_active', '!=', '0')
                        ->whereIn('category_org_id', $categoryArr)
                        ->pluck('category_name')
                        ->toArray();
                    $training->categoryName = $categoryDetails;
                }

            }
        
        
        return response()->json(['status'=>true,'code'=>200,'data'=>$courses],200);
    }

}
