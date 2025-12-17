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
        Schema::create('library_fines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->integer('book_issue_id');
            $table->unsignedBigInteger('library_id');

            $table->decimal('fine', 8, 2)->default(0);
            $table->decimal('lost_book', 8, 2)->default(0);
            $table->decimal('total_fine', 8, 2)->default(0);
            $table->timestamps();

            $table->index(['book_issue_id', 'library_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('library_fines');
    }
};
