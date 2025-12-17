<?php

namespace Modules\Gateways\Models;

use App\Traits\HasUuid;
use Illuminate\Database\Eloquent\Model;

class PaymentRequest extends Model
{
    use HasUuid;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'receiver_id',
        'payment_amount',
        'gateway_callback_url',
        'success_hook',
        'failure_hook',
        'transaction_id',
        'currency_code',
        'payment_method',
        'payment_type',
        'additional_data',
        'is_paid',
        'payer_information',
        'external_redirect_link',
        'receiver_information',
        'attribute_id',
        'plan_id',
        'notes',
        'attribute',
        'payment_platform',
    ];

    protected $casts = [
        'payer_information' => 'array',
    ];
}
