<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AssignCertificateOrg extends Model
{
    use HasFactory;

    protected $primaryKey = 'org_certificate_assign_id';

    protected $table = 'lms_org_assign_certificate';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
