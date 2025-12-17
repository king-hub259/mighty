<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Payroll\Services\SalaryHeadService;

class AcademicDatabaseSeeder extends Seeder
{
    public function __construct(
        private readonly SalaryHeadService $salaryHead
    ) {}

    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call([
            ShiftTableSeeder::class,
            StudentGroupSeeder::class,
            PeriodTableSeeder::class,
            PicklistSeeder::class,
            DepartmentSeeder::class,
            StudentCategoryTableSeeder::class,
            LeaveTypeSeeder::class,
        ]);
    }
}
