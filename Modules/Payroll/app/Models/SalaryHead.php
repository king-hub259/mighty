<?php

namespace Modules\Payroll\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalaryHead extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'name',
        'type',
    ];
}
