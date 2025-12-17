<?php

namespace Modules\Frontend\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Modules\Authentication\Models\Institute;
use Modules\Frontend\Models\ReadyToJoinUs;

class ReadyToJoinUsSeeder extends Seeder
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

        ReadyToJoinUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'Inquiry & Campus Visit',
            'description' => 'Get in touch or schedule a campus tour to see our facilities and learn more about what we offer.',
            'icon' => 'https://i.ibb.co.com/PZrX6pDQ/Group-2.png',
            'button_name' => 'Contact Us',
            'button_link' => '#',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        ReadyToJoinUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'Submit Your Application',
            'description' => 'Complete the online application form to start the admission process.',
            'icon' => 'https://i.ibb.co.com/35nLXwLR/Group-1.png',
            'button_name' => 'Apply Now',
            'button_link' => '#',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        ReadyToJoinUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'Admission Confirmation',
            'description' => 'Once accepted, complete your enrollment and confirm your place for the upcoming academic year.',
            'icon' => 'https://i.ibb.co.com/yns7RVZN/Group.png',
            'button_name' => 'Download Admission Form',
            'button_link' => '#',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);
    }
}
