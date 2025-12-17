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
        Schema::create('mark_config_exam_codes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('subject_id')->nullable();
            $table->string('title');
            $table->decimal('total_marks', 5, 2)->default(100);
            $table->decimal('pass_mark', 5, 2)->default(33);
            $table->decimal('acceptance', 5, 2)->default(1.00);
            $table->unsignedBigInteger('session_id')->nullable();
            $table->timestamps();
            $table->foreign('subject_id')->references('id')->on('subjects')->onDelete('cascade');
            $table->unique(['title', 'subject_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mark_config_exam_codes');
    }
};
