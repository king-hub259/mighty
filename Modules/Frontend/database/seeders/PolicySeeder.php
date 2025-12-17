<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PolicySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('policies')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 1,
                'description' => 'This Privacy Policy explains how we collect, use, and protect your personal data when you use our Learning Management System (LMS). We prioritize your privacy and comply with data protection laws.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 2,
                'description' => 'Our Cookie Policy explains how we use cookies to improve your experience on our LMS platform. By using our site, you agree to our use of cookies for analytics, personalization, and security.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'type' => 3,
                'description' => 'These Terms & Conditions outline the rules and regulations for using our LMS. By accessing our platform, you agree to abide by our terms, including content usage, user conduct, and dispute resolution.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
