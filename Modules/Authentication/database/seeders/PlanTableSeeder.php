<?php

namespace Modules\Authentication\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Authentication\Models\Plan;

class PlanTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Plan::create([
            'name' => 'Trail',
            'student_limit' => 50,
            'branch_limit' => 2,
            'price' => 0.00,
            'duration_days' => 7,
            'is_free' => true,
        ]);

        Plan::create([
            'name' => 'Standard',
            'student_limit' => 500,
            'branch_limit' => 2,
            'price' => 99.00,
            'duration_days' => 365,
        ]);

        Plan::create([
            'name' => 'Professional',
            'student_limit' => 9999,
            'branch_limit' => 5,
            'price' => 299.00,
            'is_custom' => true,
        ]);
    }
}
