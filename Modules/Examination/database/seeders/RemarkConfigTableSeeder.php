<?php

namespace Modules\Examination\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RemarkConfigTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $remarks = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'A+',
                'remarks' => 'Outstanding performance. Keep up the excellent work!',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'A',
                'remarks' => 'Very good. A strong performance overall.',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'A-',
                'remarks' => 'Good job. Minor areas for improvement.',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'B',
                'remarks' => 'Above average. Keep pushing forward.',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'C',
                'remarks' => 'Average performance. Needs additional focus on key areas.',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'D',
                'remarks' => 'Weak performance. A lot of work is needed.',
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'remark_title' => 'F',
                'remarks' => 'Unsatisfactory. Failed to meet the basic requirements.',
            ],
        ];

        DB::table('remark_configs')->insert($remarks);
    }
}
