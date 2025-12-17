<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\MobileAppSection;

class MobileAppSectionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        MobileAppSection::create([
            'institute_id' => 1,
            'branch_id' => 1,
            'title' => 'Stay Connected Anywhere, Anytime!',
            'heading' => 'Mobile App',
            'description' => 'With our official Fudevs School Mobile App, parents and students can:',
            'image' => 'mobile_app.png',
            'feature_one' => 'Check schedules & notifications',
            'feature_two' => 'Receive instant updates',
            'feature_three' => 'Track student progress',
            'play_store_link' => 'https://play.google.com/store/apps/details?id=com.example.app',
            'app_store_link' => 'https://apps.apple.com/us/app/example-app/id123456789',
        ]);
    }
}
