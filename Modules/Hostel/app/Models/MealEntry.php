<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class MealEntry extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'student_id',
        'meal_id',
        'meal_price',
        'date',
    ];
}
