<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class HostelCategory extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'hostel_id',
        'standard',
        'hostel_fee',
        'note',
    ];
}
