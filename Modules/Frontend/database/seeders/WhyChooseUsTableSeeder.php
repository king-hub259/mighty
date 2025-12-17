<?php

namespace Modules\Frontend\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Modules\Authentication\Models\Institute;
use Modules\Frontend\Models\WhyChooseUs;

class WhyChooseUsTableSeeder extends Seeder
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

        WhyChooseUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'Personalized Education',
            'description' => 'We tailor the learning experience to suit each student`s strengths and needs.',
            'icon' => 'https://i.ibb.co.com/hx9JgrTq/fi-2097062.png',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        WhyChooseUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'Experienced Faculty',
            'description' => 'Our team of highly qualified teachers is dedicated to nurturing your child`s potential .',
            'icon' => 'https://i.ibb.co.com/TqwD1x5h/fi-2097104.png',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        WhyChooseUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'State-of-the-Art Facilities',
            'description' => 'From smart classrooms to recreational areas, we offer the best resources for students to thrive.',
            'icon' => 'https://i.ibb.co.com/4RVcT1w1/fi-2097055.png',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        WhyChooseUs::create([
            'institute_id' => $institute->id,
            'branch_id' => 1,
            'title' => 'Holistic Development',
            'description' => 'Beyond academics, we focus on sports, arts, and personal growth to prepare students for the future.',
            'icon' => 'https://i.ibb.co.com/Pv8GhnbM/fi-2097052.png',
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);
    }
}
