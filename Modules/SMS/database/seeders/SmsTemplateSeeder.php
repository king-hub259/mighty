<?php

namespace Modules\SMS\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Modules\SMS\Models\SmsBalance;

class SmsTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Default Sliders
        DB::table('sms_templates')->insert([
            [
                'id' => 1,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Admission',
                'description' => 'Congratulations!🎓 You`ve been accepted into DEMO. 📚 Get ready for an exciting academic journey ahead. 🌟 Orientation  details will be sent shortly. Welcome to the DEMO family!',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'id' => 2,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Exam Notice',
                'description' => 'Annual exam will be held on pls collect your admit card',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'id' => 3,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Headmaster',
                'description' => 'Dear Parents, This is to inform you that school will be closed tomorrow.',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'id' => 4,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Holiday Notice',
                'description' => 'Kindly note that the school will remain closed on 14th & 15th April 16 for the Occasion of Pohela Boishakh',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'id' => 5,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Urgent Meeting',
                'description' => 'Dear Teacher, An Urgent Meeting will held on Today at 5.30pm. Please Attend on Just Time. Principal',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'id' => 6,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Guardian Assembly',
                'description' => 'Respected Parents Dear Sir, On 01/01/2025 school has organized a parent meeting, I would like to request your presence in the said meeting.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 7,
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Present',
                'description' => 'Your child did not attend today.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        DB::table('phone_book_categories')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Student',
                'description' => 'Student',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Teacher',
                'description' => 'Teacher',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Family',
                'description' => 'Family',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'VIP',
                'description' => 'VIP',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Director',
                'description' => 'Director',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Shareholder',
                'description' => 'Shareholder',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Other School Teacher',
                'description' => 'Other School Teacher',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Chairman',
                'description' => 'Chairman',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        SmsBalance::create([
            'institute_id' => 1,
            'branch_id' => 1,
            'masking_balance' => 0,
            'non_masking_balance' => 0,
        ]);
    }
}
