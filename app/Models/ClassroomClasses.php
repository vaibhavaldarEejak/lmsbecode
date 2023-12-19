<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClassroomClasses extends Model
{
    use HasFactory;

    protected $primaryKey = 'class_id';

    protected $table = 'lms_org_training_classes';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
