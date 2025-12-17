<?php

namespace Modules\Finance\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FeeHeadTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $fee_heads = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Admission Fees',
                'serial' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Admission Form Fees',
                'serial' => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Session Charge',
                'serial' => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Online Apply Fees',
                'serial' => 4,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Tuition Fees',
                'serial' => 5,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'College Examination Fees',
                'serial' => 6,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Model Test Fees',
                'serial' => 7,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Re-Take Exam Fees',
                'serial' => 8,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Form Fill Up/Registration',
                'serial' => 9,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'TC/Admission Cancel',
                'serial' => 10,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Testimonial Fees',
                'serial' => 11,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Study Materials',
                'serial' => 12,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        DB::table('fee_heads')->insert($fee_heads);
    }
}
