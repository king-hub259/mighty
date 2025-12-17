<?php

namespace Modules\Transport\Models;

use Illuminate\Database\Eloquent\Model;

class Bus extends Model
{
    protected $table = 'buses';

    public const TABLE_NAME = 'buses';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'bus_number',
        'model',
        'capacity',
        'status',
    ];

    public function driver()
    {
        return $this->hasOne(Driver::class, 'assigned_bus_id');
    }
}
