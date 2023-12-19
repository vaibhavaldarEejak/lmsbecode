<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserElearningProgress extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_elearning_progress_id';

    protected $table = 'lms_user_elearning_progress';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'on_update_date_modified';
}
