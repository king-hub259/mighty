<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PicklistSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $picklists = [
            // Religion
            ['type' => 'Religion', 'value' => 'Islam'],
            ['type' => 'Religion', 'value' => 'Christianity'],
            ['type' => 'Religion', 'value' => 'Hinduism'],
            ['type' => 'Religion', 'value' => 'Buddhism'],
            ['type' => 'Religion', 'value' => 'Others'],

            // Designation
            ['type' => 'Designation', 'value' => 'Department Head'],
            ['type' => 'Designation', 'value' => 'Lecturer'],
            ['type' => 'Designation', 'value' => 'Associate Professor'],
            ['type' => 'Designation', 'value' => 'Professor'],
            ['type' => 'Designation', 'value' => 'Principal'],
            ['type' => 'Designation', 'value' => 'Director of administration and student guidance'],

            // Staff Designation
            ['type' => 'Staff Designation', 'value' => 'Accounts Office'],
            ['type' => 'Staff Designation', 'value' => 'Exam Office'],
            ['type' => 'Staff Designation', 'value' => 'IT Office'],
            ['type' => 'Staff Designation', 'value' => 'Library'],
            ['type' => 'Staff Designation', 'value' => 'Storekeeper'],
            ['type' => 'Staff Designation', 'value' => 'Lab Assistant'],
            ['type' => 'Staff Designation', 'value' => 'Maintenance'],
            ['type' => 'Staff Designation', 'value' => 'Holy Cross Fathers Work Program'],
            ['type' => 'Staff Designation', 'value' => 'Academic Office'],
        ];

        $branches = [1]; // Branch 1 and Branch 2
        $data = [];
        $id = 1;

        foreach ($branches as $branch_id) {
            foreach ($picklists as $picklist) {
                $data[] = [
                    'id' => $id++,
                    'institute_id' => 1,
                    'branch_id' => $branch_id,
                    'type' => $picklist['type'],
                    'value' => $picklist['value'],
                    'slug' => strtolower(str_replace(' ', '-', $picklist['value'])),
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        // Insert all data at once
        DB::table('picklists')->insert($data);
    }
}
