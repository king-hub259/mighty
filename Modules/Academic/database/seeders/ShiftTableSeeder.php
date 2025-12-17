<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ShiftTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $shifts = [
            ['name' => 'Morning Shift'],
            ['name' => 'Day Shift'],
        ];

        $branches = [1]; // Branch IDs 1 and 2
        $data = [];
        foreach ($branches as $branch_id) {
            foreach ($shifts as $shift) {
                $data[] = [
                    'institute_id' => 1,
                    'branch_id' => $branch_id,
                    'name' => $shift['name'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        DB::table('shifts')->insert($data);
    }
}
