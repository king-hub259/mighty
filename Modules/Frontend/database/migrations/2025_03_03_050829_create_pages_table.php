<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('title');
            $table->string('slug');
            $table->string('type');
            $table->text('content')->nullable();
            $table->string('meta_data')->nullable();
            $table->text('seo_meta_keywords')->nullable();
            $table->text('seo_meta_description')->nullable();
            $table->string('page_status')->default('draft');
            $table->string('page_template')->default('default');
            $table->unsignedBigInteger('author_id')->index();
            $table->timestamps();

            // Combine unique constraint
            $table->unique(['institute_id', 'branch_id', 'slug'], 'unique_combination');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pages');
    }
};
