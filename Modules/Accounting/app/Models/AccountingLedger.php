<?php

namespace Modules\Accounting\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AccountingLedger extends Model
{
    protected $fillable = ['institute_id', 'branch_id', 'ledger_name', 'accounting_category_id', 'accounting_group_id', 'type', 'balance'];

    public function accountingCategory(): BelongsTo
    {
        return $this->belongsTo(AccountingCategory::class, 'accounting_category_id', 'id');
    }

    public function accountingGroup(): BelongsTo
    {
        return $this->belongsTo(AccountingGroup::class, 'accounting_group_id', 'id');
    }
}
