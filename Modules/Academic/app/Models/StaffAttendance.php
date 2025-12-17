<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class StaffAttendance extends Model
{
    protected $fillable = ['institute_id', 'branch_id', 'user_id', 'date', 'start_time', 'end_time', 'attendance', 'type'];
}
