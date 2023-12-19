<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Jobs extends Model
{
    use HasFactory;

    protected $primaryKey = 'lms_job_id';

    protected $table = 'lms_jobs';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
