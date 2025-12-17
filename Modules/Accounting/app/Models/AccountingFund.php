<?php

namespace Modules\Accounting\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class AccountingFund extends Model
{
    protected $fillable = ['institute_id', 'branch_id', 'serial', 'name', 'cash_in', 'cash_out', 'balance'];

    public function accountingFundsTransactions(): HasMany
    {
        return $this->hasMany(AccountTransactionDetail::class, 'fund_id');
    }
}
