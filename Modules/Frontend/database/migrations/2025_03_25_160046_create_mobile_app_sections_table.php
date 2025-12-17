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
        Schema::create('mobile_app_sections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('title');
            $table->string('heading');
            $table->text('description')->nullable();
            $table->string('image')->nullable();
            $table->string('feature_one')->nullable();
            $table->string('feature_two')->nullable();
            $table->string('feature_three')->nullable();
            $table->string('play_store_link')->nullable();
            $table->string('app_store_link')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mobile_app_sections');
    }
};
