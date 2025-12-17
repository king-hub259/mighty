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
        Schema::create('attendance_fines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('student_id');
            $table->decimal('fine_amount', 8, 2)->default(0.0);
            $table->decimal('waiver', 8, 2)->default(0.0);
            $table->enum('type', ['attendance_absent_fine', 'attendance_quiz_fine', 'attendance_lab_fine'])->default('attendance_absent_fine');
            $table->timestamps();

            $table->index(['student_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance_fines');
    }
};
