<?php

namespace Modules\Finance\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AttendanceFine extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'student_id',
        'month_id',
        'fine_amount',
        'type',
    ];
}
