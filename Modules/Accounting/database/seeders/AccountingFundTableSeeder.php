<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountingFund;

class AccountingFundTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $funds = [
            'General Fund',
            // 'Donation Fund',
        ];

        foreach ($funds as $key => $fund) {
            AccountingFund::create(
                [
                    'institute_id' => 1,
                    'branch_id' => 1,
                    'name' => $fund,
                    'serial' => $key + 1,
                ]
            );
        }
    }
}
