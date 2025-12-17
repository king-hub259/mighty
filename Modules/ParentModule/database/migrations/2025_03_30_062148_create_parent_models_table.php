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
        Schema::create('parent_models', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('student_id')->nullable()->constrained('students')->onDelete('cascade');
            $table->string('parent_name', 50);
            $table->string('parent_profession', 100)->nullable();
            $table->string('parent_phone', 25)->nullable();
            $table->longText('present_address')->nullable();
            $table->longText('permanent_address')->nullable();
            $table->string('access_key', 25)->nullable();
            $table->enum('status', [0, 1])->default(1);
            $table->timestamps();
            $table->softDeletes();

            $table->index(['user_id', 'parent_phone']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parent_models');
    }
};
