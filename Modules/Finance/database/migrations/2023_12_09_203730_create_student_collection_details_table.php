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
        Schema::create('student_collection_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('student_id');
            $table->unsignedBigInteger('session_id')->comment('Academic year');
            $table->unsignedBigInteger('student_collection_id');
            $table->unsignedBigInteger('fee_head_id');
            $table->unsignedBigInteger('ledger_id')->nullable();
            $table->decimal('total_due', 8, 2)->default(0);
            $table->decimal('total_payable', 8, 2)->default(0);
            $table->decimal('total_paid', 8, 2)->default(0);
            $table->decimal('waiver', 8, 2)->default(0);
            $table->decimal('fine_payable', 8, 2)->default(0);
            $table->decimal('fee_payable', 8, 2)->default(0);
            $table->decimal('fee_and_fine_payable', 8, 2)->default(0);
            $table->decimal('fee_and_fine_paid', 8, 2)->default(0);
            $table->decimal('previous_due_payable', 8, 2)->default(0);
            $table->decimal('previous_due_paid', 8, 2)->default(0);
            $table->timestamps();

            $table->index(['student_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('student_collection_details');
    }
};
