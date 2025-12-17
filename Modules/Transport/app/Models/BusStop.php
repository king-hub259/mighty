<?php

namespace Modules\Transport\Models;

use Illuminate\Database\Eloquent\Model;

class BusStop extends Model
{
    protected $table = 'bus_stops';

    public const TABLE_NAME = 'bus_stops';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'route_id',
        'stop_name',
        'latitude',
        'longitude',
        'stop_order',
    ];

    public function route()
    {
        return $this->belongsTo(BusRoute::class);
    }
}
