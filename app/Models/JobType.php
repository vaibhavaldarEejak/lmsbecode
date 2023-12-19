<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JobType extends Model
{
    use HasFactory;

    protected $primaryKey = 'job_type_id';

    protected $table = 'lms_job_type';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
