<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrganizationLearningPlanJobTitles extends Model
{
    use HasFactory;

    protected $primaryKey = 'learning_plan_jobtitle_id';

    protected $table = 'lms_learning_plan_jobtitles';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
