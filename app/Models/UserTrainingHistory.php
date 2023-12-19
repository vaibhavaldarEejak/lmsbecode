<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserTrainingHistory extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_training_history_id'; 
    protected $table = 'user_training_history';
    public $timestamps = false;

    const CREATED_AT = 'date_created';

}
