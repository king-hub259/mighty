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
        Schema::create('student_sessions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('session_id')->constrained('academic_years');
            $table->foreignId('student_id')->constrained('students');
            $table->foreignId('class_id')->constrained('classes');
            $table->foreignId('section_id')->constrained('sections');
            $table->string('roll', 15)->index();
            $table->string('qr_code', 32)->nullable()->index();
            $table->integer('optional_subject')->nullable();
            $table->timestamps();
            $table->softDeletes();

            // Combine unique constraint
            $table->unique(['session_id', 'student_id', 'class_id', 'section_id', 'roll'], 'unique_combination');
            $table->index(['session_id', 'student_id', 'class_id', 'section_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('student_sessions');
    }
};
