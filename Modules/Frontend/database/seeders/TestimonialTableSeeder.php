<?php

namespace Modules\Frontend\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Modules\Authentication\Models\Institute;
use Modules\Frontend\Models\Testimonial;

class TestimonialTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $institute = Institute::first();
        if (! $institute) {
            $this->command->info('No institute found! Please seed the institutes table first.');

            return;
        }

        Testimonial::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'user_id' => 1,
            'description' => 'I love learning here! The teachers are supportive, and the activities are fun.',
            'status' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        Testimonial::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'user_id' => 2,
            'description' => 'A great place to teach! The school values both students and educators.',
            'status' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        Testimonial::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'user_id' => 3,
            'description' => 'The best decision for my child! Excellent education and communication.',
            'status' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);
    }
}
