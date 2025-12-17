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
        Schema::create('exam_attendances', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->integer('exam_id');
            $table->integer('subject_id');
            $table->integer('student_id');
            $table->integer('class_id');
            $table->integer('section_id');
            $table->date('date');
            $table->integer('attendance')->default(2);
            $table->unsignedBigInteger('session_id')->nullable();
            $table->timestamps();

            $table->index(['class_id', 'section_id', 'exam_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('exam_attendances');
    }
};
