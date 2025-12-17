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
        Schema::create('short_codes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('short_code_title'); // Short code title (e.g., "SC-1")
            $table->string('short_code_note'); // Short code note (e.g., "Short Code -1")
            $table->integer('default_id'); // Default ID (e.g., 1)
            $table->decimal('total_mark', 5, 2); // Total mark (e.g., 100.0)
            $table->decimal('accept_percent', 5, 2); // Accept percent (e.g., 1.0)
            $table->decimal('pass_mark', 5, 2); // Pass mark (e.g., 0.0)
            $table->unsignedBigInteger('session_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('short_codes');
    }
};
