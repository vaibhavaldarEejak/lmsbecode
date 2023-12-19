<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserClassroomProgress extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_classroom_progress_id';

    protected $table = 'lms_user_classroom_progress';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
