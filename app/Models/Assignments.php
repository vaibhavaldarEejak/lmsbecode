<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Assignments extends Model
{
    use HasFactory;

    protected $primaryKey = 'assignment_id';

    protected $table = 'lms_org_assignment_user_course';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
