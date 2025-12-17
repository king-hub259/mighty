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
        Schema::create('account_transaction_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->unsignedBigInteger('account_transactions_id');
            $table->unsignedBigInteger('fund_id')->nullable();
            $table->unsignedBigInteger('fund_to_id')->nullable();
            $table->unsignedBigInteger('ledger_id')->nullable();
            $table->unsignedBigInteger('payment_method_id')->nullable();
            $table->unsignedBigInteger('payment_method_to_id')->nullable();
            $table->date('transaction_date');
            $table->decimal('debit', 10, 2)->default(0.0);
            $table->decimal('credit', 10, 2)->default(0.0);
            $table->timestamps();

            $table->index(['account_transactions_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('account_transaction_details');
    }
};
