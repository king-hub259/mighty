<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('staff_attendances', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->date('date');
            $table->enum('type', ['Admin', 'Teacher', 'Staff', 'Accountant', 'Librarian', 'Employee'])->default('Teacher');
            $table->unsignedTinyInteger('attendance')->default(2); // 0, 1, or 2; default is 2
            $table->time('start_time')->nullable();
            $table->time('end_time')->nullable();
            $table->timestamps();
            $table->softDeletes();

            // Unique constraint to prevent duplicate attendance entries for the same user on the same date
            $table->unique(['user_id', 'date'], 'unique_user_attendance_date');

            // Combined index on user_id and date for improved query performance
            $table->index(['user_id', 'date']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('staff_attendances');
    }
};
