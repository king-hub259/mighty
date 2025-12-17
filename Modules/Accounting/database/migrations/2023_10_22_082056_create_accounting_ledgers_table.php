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
        Schema::create('accounting_ledgers', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('ledger_name');
            $table->unsignedBigInteger('accounting_category_id')->nullable();
            $table->unsignedBigInteger('accounting_group_id')->nullable();
            $table->decimal('balance', 10, 2)->default(0.0);
            $table->enum('type', ['payment', 'default'])->default('default');
            $table->timestamps();

            // Combine unique constraint
            $table->unique(['institute_id', 'branch_id', 'ledger_name'], 'unique_combination');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('accounting_ledgers');
    }
};
