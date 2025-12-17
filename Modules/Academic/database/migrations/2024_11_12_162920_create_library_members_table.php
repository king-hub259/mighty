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
        Schema::create('library_members', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users');
            $table->unsignedBigInteger('library_id');
            $table->string('member_type', 20);
            $table->foreignId('teacher_id')->nullable()->constrained('teachers');
            $table->foreignId('student_id')->nullable()->constrained('students');
            $table->foreignId('staff_id')->nullable()->constrained('staffs');
            $table->timestamps();

            $table->index(['user_id', 'library_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('library_members');
    }
};
