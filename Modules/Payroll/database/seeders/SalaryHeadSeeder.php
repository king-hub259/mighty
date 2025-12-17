<?php

namespace Modules\Payroll\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Staff;
use Modules\Payroll\Models\SalaryHead;
use Modules\Payroll\Models\SalaryHeadUserPayroll;
use Modules\Payroll\Models\UserPayroll;

class SalaryHeadSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Default salary_heads
        DB::table('salary_heads')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Basic',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Allowance',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Early Leave Fine',
                'type' => 'Deduction',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Festival Allowance',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Welfare Fund',
                'type' => 'Deduction',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Professional Tax',
                'type' => 'Deduction',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Conveyance',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Exam Hall Duty',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Incentive',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Medical',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        // Fetch all staff data
        $staffData = Staff::get();
        foreach ($staffData as $staff) {
            if ($staff) {
                // Create a new UserPayroll for the staff
                $userPayroll = new UserPayroll([
                    'institute_id' => 1,
                    'branch_id' => 1,
                    'user_id' => $staff->user_id,
                    'net_salary' => 00,
                    'current_due' => 00,
                    'current_advance' => 0,
                ]);
                $userPayroll->save();

                // Fetch salary heads
                $salaryHeads = SalaryHead::get();

                // Link salary heads to the user payroll
                foreach ($salaryHeads as $salaryHead) {
                    $salaryHeadUserPayroll = new SalaryHeadUserPayroll([
                        'institute_id' => 1,
                        'branch_id' => 1,
                        'user_payroll_id' => $userPayroll->id,
                        'salary_head_id' => $salaryHead->id,
                        'amount' => 0,
                    ]);
                    $salaryHeadUserPayroll->save();
                }
            }
        }
    }
}
