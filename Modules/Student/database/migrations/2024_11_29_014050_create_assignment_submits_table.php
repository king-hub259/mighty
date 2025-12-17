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
        Schema::create('assignment_submits', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->integer('session_id');
            $table->foreignId('assignment_id');
            $table->foreignId('student_id');
            $table->string('file', 100);
            $table->string('file_2', 100)->nullable();
            $table->string('file_3', 100)->nullable();
            $table->string('file_4', 100)->nullable();
            $table->float('result')->default(0);
            $table->unsignedBigInteger('reviewed_by')->nullable();
            $table->text('review_description')->nullable();
            $table->foreign('reviewed_by')->references('id')->on('users');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('assignment_submits');
    }
};
