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
        Schema::create('plans', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->integer('student_limit')->default(0);
            $table->integer('branch_limit')->default(0);
            $table->decimal('price', 8, 2)->default(0.00);
            $table->integer('duration_days')->nullable(); // null = custom
            $table->boolean('is_custom')->default(false);
            $table->boolean('is_free')->default(false);
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plans');
    }
};
