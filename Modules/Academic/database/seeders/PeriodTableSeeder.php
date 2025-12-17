<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PeriodTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $periods = [
            ['serial_no' => '1', 'period' => 'Attendance'],
            ['serial_no' => '2', 'period' => 'Quiz'],
            ['serial_no' => '3', 'period' => 'Lab'],
        ];

        $branches = [1]; // Branch 1 and Branch 2
        $data = [];
        foreach ($branches as $branch_id) {
            foreach ($periods as $period) {
                $data[] = [
                    'institute_id' => 1,
                    'branch_id' => $branch_id,
                    'serial_no' => $period['serial_no'],
                    'period' => $period['period'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        // Insert all data at once
        DB::table('periods')->insert($data);
    }
}
