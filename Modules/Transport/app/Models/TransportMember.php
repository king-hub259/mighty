<?php

namespace Modules\Transport\Models;

use Illuminate\Database\Eloquent\Model;

class TransportMember extends Model
{
    protected $table = 'transport_members';

    public const TABLE_NAME = 'transport_members';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'student_id',
        'assigned_route_id',
        'assigned_stop_id',
        'fare_amount',
        'status',
    ];

    public function route()
    {
        return $this->belongsTo(BusRoute::class, 'assigned_route_id');
    }

    public function stop()
    {
        return $this->belongsTo(BusStop::class, 'assigned_stop_id');
    }
}
