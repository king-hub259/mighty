<?php

namespace Modules\Payroll\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Accounting\Models\AccountingFund;
use Modules\Accounting\Models\AccountingLedger;

class PayrollAccountingMapping extends Model
{
    use HasFactory;

    protected $fillable = ['institute_id', 'branch_id', 'ledger_id', 'fund_id'];

    public function ledger(): BelongsTo
    {
        return $this->belongsTo(AccountingLedger::class, 'ledger_id', 'id')->select('id', 'ledger_name');
    }

    public function fund(): BelongsTo
    {
        return $this->belongsTo(AccountingFund::class, 'fund_id', 'id')->select('id', 'name');
    }
}
