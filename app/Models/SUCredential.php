<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SUCredential extends Model
{
    use HasFactory;

    protected $primaryKey = 'credential_id';

    protected $table = 'lms_credentials';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
