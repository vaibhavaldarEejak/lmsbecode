<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Assessment extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $primaryKey = 'assessment_id';

    protected $table = 'lms_assessment';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';

}
