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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->nullable();
            $table->foreignId('branch_id')->nullable();
            $table->string('name', 40);
            $table->string('username', 192)->nullable();
            $table->string('email', 40)->nullable();
            $table->string('password');
            $table->string('phone', 25)->unique()->index();
            $table->string('image', 192)->default('profile.png');
            $table->integer('role_id')->default(1);
            $table->timestamp('email_verified_at')->nullable();
            $table->integer('status')->default(1);
            $table->string('user_type', 20);
            $table->string('facebook', 192)->nullable();
            $table->string('twitter', 192)->nullable();
            $table->string('linkedin', 192)->nullable();
            $table->string('google_plus', 192)->nullable();
            $table->enum('user_status', [0, 1])->default('1');
            $table->string('nid')->nullable();
            $table->enum('platform', ['APP', 'WEB'])->nullable();
            $table->longText('device_info')->nullable();
            $table->timestamp('last_active_time')->nullable();
            $table->rememberToken();
            $table->softDeletes();
            $table->timestamps();
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
};
