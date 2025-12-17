<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class MealPlan extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'student_id',
        'meal_id',
        'date',
    ];
}
