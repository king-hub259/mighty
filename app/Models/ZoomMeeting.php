<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ZoomMeeting extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'meeting_id',
        'topic',
        'agenda',
        'start_time',
        'duration',
        'password',
        'join_url',
        'start_url',
        'created_by',
        'created_at',
        'updated_at',
        'deleted_at',
    ];
}
