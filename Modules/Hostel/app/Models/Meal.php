<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class Meal extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'meal_name',
        'meal_type',
    ];
}
