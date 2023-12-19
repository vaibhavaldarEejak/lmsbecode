<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrainingCatalog extends Model
{
    use HasFactory;

    protected $primaryKey = 'training_catalog_id'; 
    protected $table = 'lms_training_catalog';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';

}
