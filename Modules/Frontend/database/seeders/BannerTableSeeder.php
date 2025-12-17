<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\Banner;

class BannerTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Banner::insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Fuedevs School - Excellence in Education, Brighter Futures Ahead!',
                'description' => 'A place where students learn, grow, and succeed.',
                'button_name' => 'Enroll Now',
                'button_link' => '#',
                'image' => 'https://i.ibb.co.com/Hf5zNcmQ/image-1.png',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
