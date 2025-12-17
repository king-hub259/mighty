<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class Hostel extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'hostel_name',
        'type',
        'address',
        'note',
    ];
}
