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
        Schema::create('exam_marks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('session_id');
            $table->foreignId('student_id')->constrained('students')->onDelete('cascade');
            $table->foreignId('class_id')->constrained('classes')->onDelete('cascade');
            $table->foreignId('group_id')->constrained('student_groups')->onDelete('cascade');
            $table->foreignId('subject_id')->constrained('subjects')->onDelete('cascade');
            $table->foreignId('exam_id')->constrained('exams')->onDelete('cascade');

            // 6 columns for marks, with each being nullable
            $table->decimal('mark1', 5, 2)->default(0);
            $table->decimal('mark2', 5, 2)->default(0);
            $table->decimal('mark3', 5, 2)->default(0);
            $table->decimal('mark4', 5, 2)->default(0);
            $table->decimal('mark5', 5, 2)->default(0);
            $table->decimal('mark6', 5, 2)->default(0);

            // Columns for total marks and grade
            $table->decimal('total_marks', 5, 2)->default(0); // High number (e.g., 100.0)
            $table->decimal('grade_point', 5, 2)->default(0); // Grade point (e.g., 5.0)
            $table->string('grade'); // Grade name (e.g., "A+")
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('exam_marks');
    }
};
