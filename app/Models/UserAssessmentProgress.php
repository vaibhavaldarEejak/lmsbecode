<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserAssessmentProgress extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_assessment_progress_id';

    protected $table = 'lms_user_assessment_progress';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
