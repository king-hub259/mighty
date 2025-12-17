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
        Schema::create('student_migrations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('type');
            $table->unsignedBigInteger('student_id');
            $table->unsignedBigInteger('class_id')->nullable();
            $table->unsignedBigInteger('section_id')->nullable();
            $table->unsignedBigInteger('group_id')->nullable();
            $table->unsignedBigInteger('prev_class_id')->nullable();
            $table->unsignedBigInteger('prev_section_id')->nullable();
            $table->unsignedBigInteger('prev_group_id')->nullable();
            $table->unsignedBigInteger('prev_roll')->nullable();
            $table->unsignedBigInteger('new_roll')->nullable();
            $table->unsignedBigInteger('academic_year');
            $table->timestamps();

            $table->index(['class_id', 'section_id', 'group_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('student_migrations');
    }
};
