<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrganizationLearningPlanUsers extends Model
{
    use HasFactory;

    protected $primaryKey = 'learning_plan_users_id';

    protected $table = 'lms_learning_plan_users';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
