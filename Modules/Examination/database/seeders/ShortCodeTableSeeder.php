<?php

namespace Modules\Examination\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Examination\Models\ShortCode;

class ShortCodeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $shortCodes = [
            [
                'session_id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'short_code_title' => 'SC-1',
                'short_code_note' => 'Short Code -1',
                'default_id' => 1,
                'total_mark' => 100.0,
                'accept_percent' => 1.0,
                'pass_mark' => 0.0,
            ],
            [
                'session_id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'short_code_title' => 'SC-2',
                'short_code_note' => 'Short Code -2',
                'default_id' => 2,
                'total_mark' => 100.0,
                'accept_percent' => 1.0,
                'pass_mark' => 0.0,
            ],
            [
                'session_id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'short_code_title' => 'SC-3',
                'short_code_note' => 'Short Code -3',
                'default_id' => 3,
                'total_mark' => 100.0,
                'accept_percent' => 1.0,
                'pass_mark' => 0.0,
            ],
            [
                'session_id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'short_code_title' => 'SC-4',
                'short_code_note' => 'Short Code -4',
                'default_id' => 4,
                'total_mark' => 100.0,
                'accept_percent' => 1.0,
                'pass_mark' => 0.0,
            ],
            [
                'session_id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'short_code_title' => 'SC-5',
                'short_code_note' => 'Short Code -5',
                'default_id' => 5,
                'total_mark' => 100.0,
                'accept_percent' => 1.0,
                'pass_mark' => 0.0,
            ],
            [
                'session_id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'short_code_title' => 'SC-6',
                'short_code_note' => 'Short Code -6',
                'default_id' => 6,
                'total_mark' => 100.0,
                'accept_percent' => 1.0,
                'pass_mark' => 0.0,
            ],
        ];

        // Insert data into the database
        foreach ($shortCodes as $shortCode) {
            ShortCode::create($shortCode);
        }
    }
}
