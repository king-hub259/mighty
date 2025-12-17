<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\FaqQuestion;

class FaqQuestionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        FaqQuestion::insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'question' => '',
                'answer' => '',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
