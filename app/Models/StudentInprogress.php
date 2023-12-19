<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudentInprogress extends Model
{
    use HasFactory;

    //public $timestamps = false;

    protected $primaryKey = 'user_training_id'; 

    protected $table = 'lms_user_training_progress';


    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'on_update_date_modified';
}
