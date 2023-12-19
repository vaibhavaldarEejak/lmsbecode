<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserTrainingAssignment extends Model 
{
    use HasFactory;

    protected $primaryKey = 'user_training_assignment_id';

    protected $table = 'user_training_assignments';

    const CREATED_AT = 'created_date';
    const UPDATED_AT = 'updated_date';
}
