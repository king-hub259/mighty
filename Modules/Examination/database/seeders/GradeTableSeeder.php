<?php

namespace Modules\Examination\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Examination\Models\Grade;

class GradeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $grades = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'A+',
                'grade_number' => 80.0,
                'grade_point' => 5.0,
                'grade_range' => '80-100',
                'number_high' => 100.0,
                'number_low' => 80.0,
                'point_high' => 5.0,
                'point_low' => 5.0,
                'priority' => 1,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'A',
                'grade_number' => 70.0,
                'grade_point' => 4.0,
                'grade_range' => '70-79',
                'number_high' => 79.99,
                'number_low' => 70.0,
                'point_high' => 4.99,
                'point_low' => 4.0,
                'priority' => 2,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'A-',
                'grade_number' => 60.0,
                'grade_point' => 3.5,
                'grade_range' => '60-69',
                'number_high' => 69.99,
                'number_low' => 60.0,
                'point_high' => 3.99,
                'point_low' => 3.5,
                'priority' => 3,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'B',
                'grade_number' => 50.0,
                'grade_point' => 3.0,
                'grade_range' => '50-59',
                'number_high' => 59.99,
                'number_low' => 50.0,
                'point_high' => 3.49,
                'point_low' => 3.0,
                'priority' => 4,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'C',
                'grade_number' => 40.0,
                'grade_point' => 2.0,
                'grade_range' => '40-49',
                'number_high' => 49.99,
                'number_low' => 40.0,
                'point_high' => 2.99,
                'point_low' => 2.0,
                'priority' => 5,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'D',
                'grade_number' => 33.0,
                'grade_point' => 1.0,
                'grade_range' => '33-39',
                'number_high' => 39.99,
                'number_low' => 33.0,
                'point_high' => 1.99,
                'point_low' => 1.0,
                'priority' => 6,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'grade_name' => 'F',
                'grade_number' => 0.0,
                'grade_point' => 0.0,
                'grade_range' => '00-32',
                'number_high' => 32.99,
                'number_low' => 0.0,
                'point_high' => 0.0,
                'point_low' => 0.0,
                'priority' => 7,
            ],
        ];

        // Insert data into the database
        foreach ($grades as $grade) {
            Grade::create($grade);
        }
    }
}
