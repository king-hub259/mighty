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
        Schema::create('sms_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('receiver', 20);
            $table->enum('user_type', ['Admin', 'Teacher', 'Staff', 'Accountant', 'Librarian', 'Employee', 'Student'])->default('Teacher');
            $table->text('message');
            $table->unsignedBigInteger('sender_id')->index();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('staff_id')->nullable();
            $table->unsignedBigInteger('teacher_id')->nullable();
            $table->unsignedBigInteger('student_id')->nullable();
            $table->tinyInteger('status')->default(0); // e.g., 0 = pending, 1 = sent, etc.
            $table->timestamps();
            $table->softDeletes(); // for soft deletion capability

            // Foreign Key Constraints (if applicable)
            $table->foreign('sender_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
            $table->foreign('staff_id')->references('id')->on('users')->onDelete('set null');
            $table->foreign('teacher_id')->references('id')->on('users')->onDelete('set null');
            $table->foreign('student_id')->references('id')->on('students')->onDelete('set null');

            // Indexes
            $table->index(['receiver', 'user_type', 'status']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sms_logs');
    }
};
