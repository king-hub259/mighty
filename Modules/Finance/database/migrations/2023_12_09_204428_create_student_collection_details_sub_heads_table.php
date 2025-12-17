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
        Schema::create('student_collection_details_sub_heads', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('student_id');
            $table->unsignedBigInteger('session_id')->comment('Academic year');
            $table->unsignedBigInteger('student_collection_id');
            $table->unsignedBigInteger('student_collection_details_id');
            $table->unsignedBigInteger('fee_head_id');
            $table->unsignedBigInteger('sub_head_id');
            $table->timestamps();

            $table->index(['student_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('student_collection_details_sub_heads');
    }
};
