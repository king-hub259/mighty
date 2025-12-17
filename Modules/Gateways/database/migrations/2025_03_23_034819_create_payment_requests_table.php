<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Branch;
use Modules\Authentication\Models\Institute;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('payment_requests', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Branch::class)->constrained('branches')->cascadeOnDelete();
            $table->string('payer_id', 64)->nullable();
            $table->string('receiver_id', 64)->nullable();
            $table->decimal('payment_amount', 24, 2)->default(0.00);
            $table->string('gateway_callback_url', 191)->nullable();
            $table->string('success_hook', 100)->nullable();
            $table->string('failure_hook', 100)->nullable();
            $table->string('transaction_id', 100)->nullable();
            $table->string('currency_code', 20)->default('USD');
            $table->string('payment_method', 50)->nullable();
            $table->string('payment_type', 50)->nullable();
            $table->string('name', 50)->nullable();
            $table->string('phone', 25)->nullable();
            $table->string('email', 50)->nullable();
            $table->unsignedBigInteger('plan_id')->nullable();
            $table->string('notes', 50)->nullable();
            $table->json('additional_data')->nullable();
            $table->boolean('is_paid')->default(0);
            $table->json('payer_information')->nullable();
            $table->string('external_redirect_link', 255)->nullable();
            $table->json('receiver_information')->nullable();
            $table->string('attribute_id', 64)->nullable();
            $table->string('attribute', 255)->nullable();
            $table->string('payment_platform', 255)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_requests');
    }
};
