<?php

namespace Modules\Finance\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WaiverTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('waivers')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Class Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Girl Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Merit Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Poor Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Scout Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'BNCC Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Special Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Govt. Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Invention Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Creative Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'waiver' => 'Other Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
