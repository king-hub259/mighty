<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class RoomMember extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'room_id',
        'student_id',
    ];
}
