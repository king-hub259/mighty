<?php

namespace Modules\Accounting\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AccountTransactionDetail extends Model
{
    protected $fillable = ['institute_id', 'branch_id', 'account_transactions_id', 'ledger_id', 'debit', 'credit', 'fund_id', 'fund_to_id', 'transaction_date'];

    public function accountTransaction(): BelongsTo
    {
        return $this->belongsTo(AccountTransaction::class, 'id');
    }

    public function accountingLedger(): BelongsTo
    {
        return $this->belongsTo(AccountingLedger::class, 'ledger_id');
    }
}
