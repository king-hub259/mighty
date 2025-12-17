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
        Schema::create('user_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->comment('Which User do this action');
            $table->string('ip_address')->nullable();
            $table->enum('action', ['create', 'update', 'view', 'delete', 'fee_collect', 'payment', 'receipt'])->default('create');
            $table->string('detail')->nullable();
            $table->string('previous_detail')->nullable();
            $table->string('model')->nullable();
            $table->unsignedBigInteger('model_id')->nullable();
            $table->string('url')->nullable();
            $table->timestamps();

            $table->index(['user_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_logs');
    }
};
