<?php

namespace App\Http\Controllers\API;

use App\Models\ClassroomClasses;
use App\Models\ClassroomClassSessions;
use App\Models\OrganizationCategory;
use Illuminate\Http\Request;
use Validator;
use App\Http\Controllers\API\BaseController as BaseController;
use Auth;
use DB;

class ClassRoomClassController extends BaseController
{
   public function getOrgClassCourse(Request $request,$courseId){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $classId = $request->has('classId') ? $request->get('classId') : '';


        $ClassroomClassDetail =  DB::table('lms_org_training_library as trainingLibrary')
        ->leftJoin('lms_training_types as trainingTypes','trainingLibrary.training_type_id','=','trainingTypes.training_type_id')
        ->where('trainingLibrary.training_id',$courseId)
        ->select('trainingLibrary.training_name as trainingName','credits','trainingLibrary.category_id AS categoryId','trainingTypes.training_type as trainingType')
        ->first();

        if (isset($ClassroomClassDetail)) {
            $categoryArr = explode(',', $ClassroomClassDetail->categoryId);

            $categoryDetails = OrganizationCategory::where('is_active', '!=', '0')
                ->whereIn('category_org_id', $categoryArr)
                ->select(['category_org_id as categoryId', 'category_name as categoryName'])
                ->get();

            $ClassroomClassDetail->trainingCategory = $categoryDetails;

        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClassDetail],200);
    }

    public function getOrgClassList(Request $request,$id){

        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

       // $classId = $request->has('classId') ? $request->get('classId') : '';


        $ClassroomClassSessions = ClassroomClasses::
        where('lms_org_training_classes.org_id',$organizationId)
        ->where('lms_org_training_classes.training_catalog_id',$id)
   
        ->select('lms_org_training_classes.class_id  AS classId','lms_org_training_classes.class_name as className','max_seats As maxSeats','delivery_type As deliveryType',
        'lms_org_training_classes.is_active as isActive')
        ->get();

        if($ClassroomClassSessions->count() > 0){
            foreach($ClassroomClassSessions as $ClassroomClass){
               $totalHours = ClassroomClassSessions::where('is_active', '!=', '0')
                ->where('class_id', $ClassroomClass->classId)
                ->selectRaw('SUM(duration_hours) as totalHours, MIN(session_date) as sessionDate')
                ->orderBy('sessionDate', 'asc') 
                ->first();

                $ClassroomClass->totalHours = $totalHours ? $totalHours->totalHours : 0;
                $ClassroomClass->sessionDate = $totalHours ? $totalHours->sessionDate : null;
            }
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClassSessions],200);
    }

    public function addOrgClass(Request $request){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'courseId' => 'required',
            'className' => 'required'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $ClassroomClasses = new ClassroomClasses;
        $ClassroomClasses->	training_catalog_id = $request->courseId;
        $ClassroomClasses->class_name = $request->className;
        $ClassroomClasses->max_seats = $request->maxSeats;
        $ClassroomClasses->delivery_type = $request->deliveryType;
        $ClassroomClasses->location = $request->location;
        $ClassroomClasses->waiting_allowed = $request->waitingAllowed;
        $ClassroomClasses->no_of_waiting = $request->noOfWaiting;
        $ClassroomClasses->virtual_class_description = @$request->virtualClassDescription;
        $ClassroomClasses->is_active = $request->isActive == '' ? '1' : $request->isActive;
        $ClassroomClasses->org_id = $organizationId;
        $ClassroomClasses->created_id = $authId;
        $ClassroomClasses->modified_id = $authId;
        $ClassroomClasses->save();

        return response()->json(['status'=>true,'code'=>201,'data'=>$ClassroomClasses->class_id,'message'=>'Class has been created successfully.'],201);
    }

    public function addOrgSession(Request $request){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'class' => 'required'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        if(!empty($request->sessionData)){
            foreach($request->sessionData as $sessions){
                $ClassroomClassSessions = new ClassroomClassSessions;
                $ClassroomClassSessions->class_id = $request->class;
                $ClassroomClassSessions->org_id = $organizationId;
                $ClassroomClassSessions->session_date = @$sessions['sessionDate'] ? date('Y-m-d',strtotime(@$sessions['sessionDate'])) : Null;
                $ClassroomClassSessions->duration_hours = $sessions['hrs'];
                $ClassroomClassSessions->duration_minutes = @$sessions['minutes'];
                $ClassroomClassSessions->start_time = @$sessions['startTime'];
                $ClassroomClassSessions->timezone = @$sessions['timezone'];
                $ClassroomClassSessions->instructor_id = @$sessions['instructorId'];
                // $ClassroomClassSessions->location = @$sessions['location'];
                $ClassroomClassSessions->created_id = $authId;
                $ClassroomClassSessions->modified_id = $authId;
                $ClassroomClassSessions->save();
            }
        }
        return response()->json(['status'=>true,'code'=>201,'data'=>$ClassroomClassSessions->training_session_id ,'message'=>'Session has been created successfully.'],201);
    }
        return response()->json(['status'=>true,'code'=>201,'data'=>$ClassroomClassSessions->training_session_id ,'message'=>'Session has been created successfully.'],201);
    }

    public function getOrgClassandSessionById($id){
        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')
        ->select('class_id','training_catalog_id as courseId','class_name as className','class_status as classStatus','class_certificate_id as certificateId','max_seats as maxSeats','delivery_type as deliveryType','virtual_class_description as virtualClassDescription','is_active as isActive')
        ->find($id);
        if(is_null($ClassroomClasses)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class not found.'],400);
        }

        $ClassroomClassSessions = ClassroomClassSessions::where('is_active','!=','0')->where('class_id',$ClassroomClasses->class_id);
        if($ClassroomClassSessions->count()){
            $ClassroomClasses->sessions = $ClassroomClassSessions
            ->select('training_session_id as sessionId','session_date as sessionDate','hrs','minutes','start_time as startTime','timezone','instructor_id as instructorId','location','is_active as isActive')
            ->get();
        }else{
            $ClassroomClasses->sessions = Null;
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClasses],200);
    }


    public function getOrgClassandSessionById($id){
        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')
        ->select('class_id','training_catalog_id as courseId','class_name as className','max_seats as maxSeats','delivery_type as deliveryType', 'location','virtual_class_description as virtualClassDescription','is_active as isActive')
        ->find($id);
        if(is_null($ClassroomClasses)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class not found.'],400);
        }

        $ClassroomClassSessions = ClassroomClassSessions::where('is_active','!=','0')->where('class_id',$ClassroomClasses->class_id);
        if($ClassroomClassSessions->count()){
            $ClassroomClasses->sessions = $ClassroomClassSessions
            ->select('training_session_id as sessionId','session_date as sessionDate','duration_hours','duration_minutes','start_time as startTime','timezone','instructor_id as instructorId','is_active as isActive')
            ->get();
        }else{
            $ClassroomClasses->sessions = Null;
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClasses],200);
    }


    public function getOrgClassById($id){
        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')
        ->select('class_id','training_catalog_id as courseId','class_name as className','location as location','no_of_waiting as noOfWaiting','waiting_allowed as waitingAllowed','max_seats as maxSeats','delivery_type as deliveryType','virtual_class_description as virtualClassDescription','is_active as isActive')
        ->find($id);
        if(is_null($ClassroomClasses)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class not found.'],400);
        }

        $ClassroomClassSessions = ClassroomClassSessions::where('is_active','!=','0')->where('class_id',$ClassroomClasses->id);
        if($ClassroomClassSessions->count()){
            $ClassroomClasses->sessions = $ClassroomClassSessions
            ->select('id','session_date','hrs','minutes','start_time as startTime','timezone','instructor_id as instructorId','location','is_active as isActive')
            ->get();
        }else{
            $ClassroomClasses->sessions = Null;
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClasses],200);
    }

    public function getOrgClassSessionById($id){
        $ClassroomClassSessions = ClassroomClassSessions::where('is_active','!=','0')
        ->select('training_session_id','session_date','duration_hours','duration_minutes','start_time as startTime','timezone','instructor_id as instructorId','is_active as isActive')
        ->find($id);
        if(is_null($ClassroomClassSessions)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class session not found.'],400);
        }
        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClassSessions],200);
    }

    public function updateOrgClassandSessionById(Request $request,$id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'courseId' => 'required',
            'className' => 'required'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')->find($id);
        if(is_null($ClassroomClasses)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class not found.'],400);
        }
        $ClassroomClasses->training_catalog_id = $request->courseId;
        $ClassroomClasses->class_name = $request->className;
        $ClassroomClasses->max_seats = $request->maxSeats;
        $ClassroomClasses->delivery_type = $request->deliveryType;
        $ClassroomClasses->virtual_class_description = $request->virtualClassDescription;
        $ClassroomClasses->location = $request->location;
        $ClassroomClasses->waiting_allowed = $request->waitingAllowed;
        $ClassroomClasses->no_of_waiting = $request->noOfWaiting;
        $ClassroomClasses->is_active = $request->isActive == '' ? '1' : $request->isActive;
        $ClassroomClasses->org_id = $organizationId;
        $ClassroomClasses->modified_id = $authId;
        $ClassroomClasses->save();

        if(!empty($request->sessions)){
            foreach($request->sessions as $sessions){
                if(!empty($sessions['id'])){
                    $ClassroomClassSessions = ClassroomClassSessions::find($sessions['id']);
                }else{
                    $ClassroomClassSessions = new ClassroomClassSessions;
                    $ClassroomClassSessions->class_id = $ClassroomClasses->id;
                    $ClassroomClassSessions->org_id = $organizationId;
                    $ClassroomClassSessions->created_id = $authId;
                }
                $ClassroomClassSessions->session_date = $sessions['date'] ? date('Y-m-d',strtotime($sessions['date'])) : Null;
                $ClassroomClassSessions->duration_hours = $sessions['hrs'];
                $ClassroomClassSessions->duration_minutes = $sessions['minutes'];
                $ClassroomClassSessions->start_time = $sessions['startTime'];
                $ClassroomClassSessions->timezone = $sessions['timezone'];
                $ClassroomClassSessions->instructor_id = $sessions['instructorId'];
                $ClassroomClassSessions->modified_id = $authId;
                $ClassroomClassSessions->save();
            }
        }
        
        return response()->json(['status'=>true,'code'=>200,'message'=>'Class has been updated successfully.'],200);
    }

    public function updateOrgClassById(Request $request,$id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $validator = Validator::make($request->all(), [
            'className' => 'required'
        ]);

        if ($validator->fails())
        {
            return response()->json(['status'=>false,'code'=>400,'errors'=>$validator->errors()->all()], 400);
        }

        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')->find($id);
        if(is_null($ClassroomClasses)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class not found.'],400);
        }
        $ClassroomClasses->training_catalog_id = $request->courseId;
        $ClassroomClasses->class_name = $request->className;
        $ClassroomClasses->max_seats = $request->maxSeats;
        $ClassroomClasses->delivery_type = $request->deliveryType;
        $ClassroomClasses->virtual_class_description = $request->virtualClassDescription;
        $ClassroomClasses->is_active = $request->isActive == '' ? '1' : $request->isActive;
        $ClassroomClasses->org_id = $organizationId;
        $ClassroomClasses->modified_id = $authId;
        $ClassroomClasses->save();

        if(!empty($request->sessions)){
            foreach($request->sessions as $sessions){
                if(!empty($sessions['id'])){
                    $ClassroomClassSessions = ClassroomClassSessions::find($sessions['id']);
                }else{
                    $ClassroomClassSessions = new ClassroomClassSessions;
                    $ClassroomClassSessions->class_id = $ClassroomClasses->id;
                    $ClassroomClassSessions->org_id = $organizationId;
                    $ClassroomClassSessions->created_id = $authId;
                }
                $ClassroomClassSessions->session_date = $sessions['date'] ? date('Y-m-d',strtotime($sessions['date'])) : Null;
                $ClassroomClassSessions->duration_hours = $sessions['hrs'];
                $ClassroomClassSessions->duration_minutes = $sessions['minutes'];
                $ClassroomClassSessions->start_time = $sessions['startTime'];
                $ClassroomClassSessions->timezone = $sessions['timezone'];
                $ClassroomClassSessions->instructor_id = $sessions['instructorId'];
                $ClassroomClassSessions->location = $sessions['location'];
                $ClassroomClassSessions->modified_id = $authId;
                $ClassroomClassSessions->save();
            }
        }
        
        return response()->json(['status'=>true,'code'=>200,'message'=>'Class has been updated successfully.'],200);
    }

    public function updateOrgClassSessionById(Request $request,$id){
        $authId = Auth::user()->user_id;
        $organizationId = Auth::user()->org_id;

        $ClassroomClassSessions = ClassroomClassSessions::where('is_active','!=','0')->find($id);
        if(is_null($ClassroomClassSessions)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class session not found.'],400);
        }
        $ClassroomClassSessions->session_date = $request->date ? date('Y-m-d',strtotime($request->date)) : Null;
        $ClassroomClassSessions->duration_hours = $request->hrs;
        $ClassroomClassSessions->duration_minutes = $request->minutes;
        $ClassroomClassSessions->start_time = $request->startTime;
        $ClassroomClassSessions->timezone = $request->timezone;
        $ClassroomClassSessions->instructor_id = $request->instructorId;
        $ClassroomClassSessions->location = $request->location;
        $ClassroomClassSessions->modified_id = $authId;
        $ClassroomClassSessions->save();
        
        return response()->json(['status'=>true,'code'=>200,'message'=>'Class session has been updated successfully.'],200);
    }

    public function deleteOrgClassById($id){
        $authId = Auth::user()->user_id;
        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')->find($id);
        if(is_null($ClassroomClasses)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class not found.'],400);
        }
        $ClassroomClasses->is_active = 0; 
        $ClassroomClasses->modified_id = $authId;
        $ClassroomClasses->save();


        $ClassroomClassSessions = ClassroomClassSessions::where('class_id',$id);
        if($ClassroomClassSessions->count() > 0){
            $ClassroomClassSessions->update([
                'is_active' => 0,
                'modified_id' => $authId,
            ]);
        }

        return response()->json(['status'=>true,'code'=>200,'message'=>'Class has been deleted successfully.'],200); 
    }

    public function deleteOrgClassSessionById($id){
        $authId = Auth::user()->user_id;
        $ClassroomClassSessions = ClassroomClassSessions::where('is_active','!=','0')->find($id);
        if(is_null($ClassroomClassSessions)){
            return response()->json(['status'=>true,'code'=>400,'error'=>'Class session not found.'],400);
        }
        $ClassroomClassSessions->is_active = 0; 
        $ClassroomClassSessions->modified_id = $authId;
        $ClassroomClassSessions->save();

        return response()->json(['status'=>true,'code'=>200,'message'=>'Class session has been deleted successfully.'],200); 
    }

    public function getClassesAndSessionsByCourseId($id){
        $ClassroomClasses = ClassroomClasses::where('is_active','!=','0')
        ->select('class_id','training_catalog_id as courseId','class_name as className','class_status as classStatus','class_certificate_id as certificateId','location', 'max_seats as maxSeats','delivery_type as deliveryType','virtual_class_description as virtualClassDescription','is_active as isActive')
        ->where('training_catalog_id',$id)
        ->get();
        if($ClassroomClasses->count() > 0){
            foreach($ClassroomClasses as $ClassroomClass){
                $ClassroomClass->sessions = ClassroomClassSessions::where('is_active','!=','0')->where('class_id',$ClassroomClass->id)->select('training_session_id','session_date','duration_hours','duration_minutes','start_time as startTime','timezone','instructor_id as instructorId','is_active as isActive')
                ->get();
            }
        }

        return response()->json(['status'=>true,'code'=>200,'data'=>$ClassroomClasses],200);
    }
}
