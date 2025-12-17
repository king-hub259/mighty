<?php

namespace Modules\Examination\Database\Seeders;

use Illuminate\Database\Seeder;

class ExaminationDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call([
            // Exam Module
            ShortCodeTableSeeder::class,
            GradeTableSeeder::class,
            RemarkConfigTableSeeder::class,
            MeritProcessTypeTableSeeder::class,
        ]);
    }
}
