<?php

namespace Modules\Frontend\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Onboarding extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'collected_data',
        'institute_logo',
        'user_avatar',
        'status',
        'approved_by',
        'approved_at',
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    protected $casts = [
        'collected_data' => 'array',
    ];
}
