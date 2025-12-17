<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'hostel_category_id',
        'room_number',
        'capacity',
    ];
}
