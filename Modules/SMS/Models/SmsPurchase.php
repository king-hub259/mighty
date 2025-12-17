<?php

namespace Modules\SMS\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SmsPurchase extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'sms_gateway',
        'transaction_date',
        'no_of_sms',
        'amount',
        'masking_type',
    ];
}
