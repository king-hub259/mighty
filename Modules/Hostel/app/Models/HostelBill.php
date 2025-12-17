<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;

class HostelBill extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'student_id',
        'hostel_fee',
        'meal_fee',
        'total_amount',
        'status',
        'due_date',
    ];
}
