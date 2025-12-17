<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountingCategory;

class AccountingCategoryTableSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            [
                'id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Cash & Cash Equivalence',
                'type' => 'Assets',
                'nature' => 'debit',
            ],
            [
                'id' => 2,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Current Liabilities',
                'type' => 'Liabilities',
                'nature' => 'credit',
            ],
            [
                'id' => 3,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Non-Current Liabilities',
                'type' => 'Liabilities',
                'nature' => 'credit',
            ],
            [
                'id' => 4,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Owner’s Equity',
                'type' => 'Liabilities',
                'nature' => 'credit',
            ],
            [
                'id' => 5,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Fees Related Income',
                'type' => 'Income',
                'nature' => 'credit',
            ],
            [
                'id' => 6,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Others Income',
                'type' => 'Income',
                'nature' => 'credit',
            ],
            [
                'id' => 7,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'General Expenses',
                'type' => 'Expense',
                'nature' => 'debit',
            ],
        ];

        AccountingCategory::insert($data);
    }
}
