<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AssignNotificationOrg extends Model
{
    use HasFactory;

    protected $primaryKey = 'org_assign_notification_id';

    protected $table = 'lms_org_assign_notification';

    const CREATED_AT = 'date_created';
    const UPDATED_AT = 'date_modified';
}
