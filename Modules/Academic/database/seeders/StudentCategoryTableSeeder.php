<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Academic\Models\StudentCategory;

class StudentCategoryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $student_categories = ['General', 'Special'];
        $branches = [1]; // Branch IDs 1 and 2

        foreach ($branches as $branch_id) {
            foreach ($student_categories as $student_category) {
                StudentCategory::create([
                    'institute_id' => 1,
                    'branch_id' => $branch_id,
                    'name' => $student_category,
                ]);
            }
        }
    }
}
