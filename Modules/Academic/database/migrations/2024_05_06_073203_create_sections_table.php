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
        Schema::create('sections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('class_id')->constrained('classes');
            $table->foreignId('student_group_id')->constrained('student_groups');
            $table->string('section_name', 20);
            $table->string('room_no', 20)->nullable();
            $table->integer('class_teacher_id')->nullable();
            $table->integer('status')->default(1);
            $table->integer('rank')->nullable();
            $table->integer('capacity')->nullable();
            $table->integer('attendance_time_config_id')->nullable();
            $table->timestamps();

            $table->index(['class_id', 'student_group_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sections');
    }
};
