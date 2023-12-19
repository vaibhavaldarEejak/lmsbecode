<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrganizationLearningPlanGroups extends Model
{
    use HasFactory;

    protected $primaryKey = 'learning_plan_group_id';

    protected $table = 'lms_learning_plan_groups';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
