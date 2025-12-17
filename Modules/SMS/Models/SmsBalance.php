<?php

namespace Modules\SMS\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SmsBalance extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'masking_balance',
        'non_masking_balance',
    ];
}
