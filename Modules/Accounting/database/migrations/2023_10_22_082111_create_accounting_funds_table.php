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
        Schema::create('accounting_funds', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('serial')->nullable();
            $table->string('name');
            $table->decimal('cash_in', 10, 2)->default(0.0);
            $table->decimal('cash_out', 10, 2)->default(0.0);
            $table->decimal('balance', 10, 2)->default(0.0);
            $table->timestamps();

            // Combine unique constraint
            $table->unique(['institute_id', 'branch_id', 'name'], 'unique_combination');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('accounting_funds');
    }
};
