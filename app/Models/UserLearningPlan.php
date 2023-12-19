<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserLearningPlan extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_learning_plan_id';

    protected $table = 'user_learning_plan';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
