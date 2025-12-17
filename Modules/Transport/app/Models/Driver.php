<?php

namespace Modules\Transport\Models;

use Illuminate\Database\Eloquent\Model;

class Driver extends Model
{
    protected $table = 'drivers';

    public const TABLE_NAME = 'drivers';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'name',
        'phone_number',
        'license_number',
        'assigned_bus_id',
        'status',
    ];

    public function bus()
    {
        return $this->belongsTo(Bus::class, 'assigned_bus_id');
    }
}
