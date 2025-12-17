<?php

namespace Modules\Transport\Models;

use Illuminate\Database\Eloquent\Model;

class BusRoute extends Model
{
    protected $table = 'bus_routes';

    public const TABLE_NAME = 'bus_routes';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'route_name',
        'start_location',
        'end_location',
        'total_distance',
        'estimated_time',
        'status',
    ];

    public function stops()
    {
        return $this->hasMany(BusStop::class);
    }
}
