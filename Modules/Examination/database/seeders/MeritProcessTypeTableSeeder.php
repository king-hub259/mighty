<?php

namespace Modules\Examination\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MeritProcessTypeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Sample data for seeder
        $data = [
            [
                'type' => 'Total Mark(Sequential)',
            ],
            [
                'type' => 'Grade Point(Sequential)',
            ],
        ];

        // Insert data into the merit_process_types table
        foreach ($data as $entry) {
            DB::table('merit_process_types')->insert([
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => $entry['type'],
            ]);
        }
    }
}
