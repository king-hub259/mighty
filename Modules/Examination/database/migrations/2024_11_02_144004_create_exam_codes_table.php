<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Academic\Models\ClassModel;
use Modules\Examination\Models\ShortCode;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('exam_codes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignIdFor(ClassModel::class)->constrained();
            $table->foreignIdFor(ShortCode::class)->constrained();
            $table->string('short_code_title')->nullable();
            $table->string('short_code_note')->nullable();
            $table->integer('default_id')->nullable();
            $table->decimal('total_mark', 5, 2)->nullable();
            $table->decimal('accept_percent', 5, 2)->nullable();
            $table->decimal('pass_mark', 5, 2)->nullable();
            $table->unsignedBigInteger('session_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('exam_codes');
    }
};
