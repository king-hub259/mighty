<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class StudentGroupSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $groups = [
            'N/A',
            'General',
            'Science',
            'Business Studies',
            'Humanities',
            'Computer Science',
            'Civil',
            'Electric',
            'Economics',
            'Mechanical',
            'Food Processing',
            'Medical',
            'Islamic History and Culture',
        ];

        $data = [];
        $branches = [1]; // Adding data for both branches
        foreach ($branches as $branch_id) {
            foreach ($groups as $group) {
                $data[] = [
                    'institute_id' => 1,
                    'branch_id' => $branch_id,
                    'group_name' => $group,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        DB::table('student_groups')->insert($data);
    }
}
