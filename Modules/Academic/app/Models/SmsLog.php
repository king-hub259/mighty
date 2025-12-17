<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Authentication\Models\User;

class SmsLog extends Model
{
    protected $guarded = ['id'];

    protected $table = 'sms_logs';

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
