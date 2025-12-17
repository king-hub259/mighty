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
        Schema::create('grades', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('grade_name'); // Grade name (e.g., "A+")
            $table->decimal('grade_number', 5, 2); // Grade number (e.g., 80.0)
            $table->decimal('grade_point', 5, 2); // Grade point (e.g., 5.0)
            $table->string('grade_range'); // Grade range (e.g., "80-100")
            $table->decimal('number_high', 5, 2); // High number (e.g., 100.0)
            $table->decimal('number_low', 5, 2); // Low number (e.g., 80.0)
            $table->decimal('point_high', 5, 2); // High point (e.g., 5.0)
            $table->decimal('point_low', 5, 2); // Low point (e.g., 5.0)
            $table->string('priority'); // Default ID (e.g., "1")
            $table->unsignedBigInteger('session_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('grades');
    }
};
