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
        Schema::create('class_lessons', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('title', 255);
            $table->integer('session_id');
            $table->string('date', 255);
            $table->integer('class_id');
            $table->integer('section_id');
            $table->integer('subject_id')->nullable();
            $table->string('note', 255);
            $table->string('file', 255)->nullable();
            $table->string('file_2', 255)->nullable();
            $table->string('file_3', 255)->nullable();
            $table->string('file_4', 255)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('class_lessons');
    }
};
