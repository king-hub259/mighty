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
        Schema::create('class_routines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('section_id')->constrained('sections');
            $table->foreignId('subject_id')->constrained('subjects');
            $table->string('day', 20);
            $table->time('start_time')->nullable();
            $table->time('end_time')->nullable();
            $table->integer('teacher_id')->nullable();
            $table->timestamps();

            $table->index(['section_id', 'subject_id', 'teacher_id']);
            $table->unique(['day', 'start_time', 'end_time', 'teacher_id'], 'start_end_teacher_unique');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('class_routines');
    }
};
