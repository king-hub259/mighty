<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountingGroup;

class AccountingGroupTableSeeder extends Seeder
{
    public function run(): void
    {
        $groups = [
            // 1. Cash &amp; Cash Equivalence
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 1,
                'accounting_category_id' => 1,
                'name' => 'Cash',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 2,
                'accounting_category_id' => 1,
                'name' => 'Digital Payment',
            ],

            // 2. Current Liabilities
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 3,
                'accounting_category_id' => 2,
                'name' => 'Accounts Payable',
            ],

            // 3. Non-Current Liabilities
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 4,
                'accounting_category_id' => 3,
                'name' => 'Long Term Loan',
            ],

            // 4. Owner’s Equity
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 5,
                'accounting_category_id' => 4,
                'name' => 'Opening Balance Equity',
            ],

            // 5. Fees Related Income
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 6,
                'accounting_category_id' => 5,
                'name' => 'Income From Fees',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 7,
                'accounting_category_id' => 5,
                'name' => 'Income From Fine',
            ],

            // 6. Others Income
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 8,
                'accounting_category_id' => 6,
                'name' => 'Rental Income',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 9,
                'accounting_category_id' => 6,
                'name' => 'Old Things Sells Income',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 10,
                'accounting_category_id' => 6,
                'name' => 'Others Miscellaneous Income',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 11,
                'accounting_category_id' => 6,
                'name' => 'Donation',
            ],

            // 7. General Expenses
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 12,
                'accounting_category_id' => 7,
                'name' => 'Advertising / Promotional',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 13,
                'accounting_category_id' => 7,
                'name' => 'Occasional Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 14,
                'accounting_category_id' => 7,
                'name' => 'Bank Charge',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 15,
                'accounting_category_id' => 7,
                'name' => 'Others Miscellaneous Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 16,
                'accounting_category_id' => 7,
                'name' => 'Convenience Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 17,
                'accounting_category_id' => 7,
                'name' => 'Utilities Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 18,
                'accounting_category_id' => 7,
                'name' => 'Meals &amp; Entertainment',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 19,
                'accounting_category_id' => 7,
                'name' => 'Exam Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 20,
                'accounting_category_id' => 7,
                'name' => 'Rental Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 21,
                'accounting_category_id' => 7,
                'name' => 'Software Charge',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 22,
                'accounting_category_id' => 7,
                'name' => 'Stationary Expenses',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 23,
                'accounting_category_id' => 7,
                'name' => 'Repair & Maintenance',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'id' => 24,
                'accounting_category_id' => 7,
                'name' => 'Payroll Expenses',
            ],
        ];

        AccountingGroup::insert($groups);
    }
}
