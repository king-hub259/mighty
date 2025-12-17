<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FrontendDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call(BannerTableSeeder::class);
        $this->call(AboutUsTableSeeder::class);
        $this->call(OurHistorySeeder::class);
        $this->call(FaqQuestionSeeder::class);
        $this->call(PolicySeeder::class);
        $this->call(TestimonialTableSeeder::class);
        $this->call(WhyChooseUsTableSeeder::class);
        $this->call(ReadyToJoinUsSeeder::class);
        $this->call(MobileAppSectionSeeder::class);

        $pages = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Home',
                'slug' => 'home',
                'type' => 'home',
                'content' => '<p>Home page content</p>',
                'meta_data' => null,
                'seo_meta_keywords' => 'home, welcome',
                'seo_meta_description' => 'This is the home page',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'About Us',
                'slug' => 'about-us',
                'type' => 'about',
                'content' => '<p>About us content</p>',
                'meta_data' => null,
                'seo_meta_keywords' => 'about, us',
                'seo_meta_description' => 'Learn more about us',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Mission',
                'slug' => 'mission',
                'type' => 'mission',
                'content' => '<p>Demo College provides quality education to students...</p>',
                'meta_data' => null,
                'seo_meta_keywords' => 'mission, education, students',
                'seo_meta_description' => 'Our mission is to provide quality education.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Vision',
                'slug' => 'vision',
                'type' => 'vision',
                'content' => '<p>Demo College inspires students to acquire genuine knowledge...</p>',
                'meta_data' => null,
                'seo_meta_keywords' => 'vision, education, knowledge',
                'seo_meta_description' => 'Our vision is to inspire students with knowledge.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Goal',
                'slug' => 'goal',
                'type' => 'goal',
                'content' => '<p>To establish Demo College as a model educational institution...</p>',
                'meta_data' => null,
                'seo_meta_keywords' => 'goal, education, institution',
                'seo_meta_description' => 'Our goal is to be a model educational institution.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Motto',
                'slug' => 'motto',
                'type' => 'motto',
                'content' => '<p>Pursue Knowledge through Human Service...</p>',
                'meta_data' => null,
                'seo_meta_keywords' => 'motto, knowledge, service',
                'seo_meta_description' => 'Our motto is to pursue knowledge through service.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Admission Information',
                'slug' => 'admission-information',
                'type' => 'admission-information',
                'content' => '<img src="https://example.com/public/page_Image/admission_information.png">',
                'meta_data' => null,
                'seo_meta_keywords' => 'admission, info, enrollment',
                'seo_meta_description' => 'Find out about our admission process.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Academic Achievements',
                'slug' => 'academic-achievement',
                'type' => 'academic-achievement',
                'content' => '<img src="https://example.com/public/page_Image/admission_information.png">',
                'meta_data' => null,
                'seo_meta_keywords' => 'admission, academic achievements, enrollment',
                'seo_meta_description' => 'Learn about the academic achievements of our institution and how we support student success.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Academic Facilities',
                'slug' => 'academic-facilities',
                'type' => 'academic-facilities',
                'content' => '<img src="https://example.com/public/page_Image/admission_information.png">',
                'meta_data' => null,
                'seo_meta_keywords' => 'admission, academic facilities, enrollment',
                'seo_meta_description' => 'Explore the academic facilities that provide a conducive environment for learning and growth.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'title' => 'Debating Club Information',
                'slug' => 'debating-club',
                'type' => 'debating-club',
                'content' => '<img src="https://example.com/public/page_Image/admission_information.png">',
                'meta_data' => null,
                'seo_meta_keywords' => 'admission, debating club, extracurricular',
                'seo_meta_description' => 'Join our debating club to enhance your critical thinking and public speaking skills.',
                'page_status' => 'publish',
                'page_template' => 'default',
                'author_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        // Insert pages
        DB::table('pages')->insert($pages);
    }
}
