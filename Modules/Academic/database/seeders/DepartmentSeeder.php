<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DepartmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Common department names with their slugs
        $departments = [
            ['Bangla', 'bangla'],
            ['English', 'english'],
            ['ICT', 'ict'],
            ['Math', 'math'],
            ['Physics', 'physics'],
            ['Chemistry', 'chemistry'],
            ['Biology', 'biology'],
            ['Humanities', 'humanities'],
            ['Business Studies', 'business-studies'],
            ['Administration', 'administration'],
            ['Principal Office', 'principal-office'],
            ['Academic/Main Office', 'academic-main-office'],
            ['Exam', 'exam'],
            ['Account', 'account'],
            ['Guidance', 'guidance'],
            ['Information & Technology', 'information-&-technology'],
            ['Laboratories', 'laboratories'],
            ['Library', 'library'],
            ['Store Room', 'store-room'],
            ['Maintenance', 'maintenance'],
            ['Bookstore', 'bookstore'],
            ['Student Work Program', 'student-work-program'],
        ];

        $branches = [1];

        $data = [];
        foreach ($branches as $branch) {
            foreach ($departments as $key => [$name, $slug]) {
                $data[] = [
                    'institute_id' => 1,
                    'branch_id' => $branch,
                    'department_name' => $name,
                    'slug' => $slug,
                    'priority' => $key + 1,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        // Insert into database
        DB::table('departments')->insert($data);
    }
}
