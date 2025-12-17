<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\AboutUs;

class AboutUsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        AboutUs::insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Welcome to Fudevs School',
                'description' => 'We provide a nurturing environment, a challenging curriculum, and a dedicated faculty to ensure student success.',
                'image' => 'https://i.ibb.co.com/jkr9s80Q/image.png',
                'status' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
