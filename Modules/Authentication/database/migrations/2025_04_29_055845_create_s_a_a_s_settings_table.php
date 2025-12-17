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
        Schema::create('s_a_a_s_settings', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
            $table->longText('value')->nullable();
            $table->longText('payment_info')->nullable();
            $table->longText('sms_info')->nullable();
            $table->string('type')->nullable()->default('general');
            $table->string('mode')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('s_a_a_s_settings');
    }
};
