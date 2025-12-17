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
        Schema::create('assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->integer('session_id');
            $table->string('title', 100);
            $table->longText('description')->nullable();
            $table->date('deadline');
            $table->integer('class_id');
            $table->integer('section_id');
            $table->integer('subject_id');
            $table->string('file', 100);
            $table->string('file_2', 100)->nullable();
            $table->string('file_3', 100)->nullable();
            $table->string('file_4', 100)->nullable();
            $table->timestamps();

            $table->index(['class_id', 'section_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('assignments');
    }
};
