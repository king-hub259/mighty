<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LeaveTypeSeeder extends Seeder
{
    public function run(): void
    {
        $leaveTypes = [
            'Medical Leave',
            'Vacation Leave',
            'Emergency Leave',
            'Maternity/Paternity Leave',
            'Study Leave',
            'Sick Leave',
            'Family Leave',
            'Special Leave',
            'Educational Leave',
            'Bereavement Leave',
            'Religious Leave',
            'Extracurricular Leave',
        ];

        $branches = [1]; // Branch 1 and Branch 2
        foreach ($branches as $branch_id) {
            foreach ($leaveTypes as $leaveType) {
                DB::table('leave_types')->insert([
                    'institute_id' => 1,
                    'branch_id' => $branch_id,
                    'name' => $leaveType,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
