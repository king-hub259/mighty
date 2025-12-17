<?php

namespace Modules\Library\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BookCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $branchIds = [1]; // List of branch IDs you want to insert records for
        $bookCategories = [
            'General',
            'Fiction',
            'Science Fiction',
            'Mystery',
            'Non-Fiction',
            'Fantasy',
            'Others',
        ];

        foreach ($branchIds as $branchId) {
            $categoryData = array_map(function ($category) use ($branchId) {
                return [
                    'institute_id' => 1,
                    'branch_id' => $branchId,
                    'category_name' => $category,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }, $bookCategories);

            DB::table('book_categories')->insert($categoryData);
        }
    }
}
