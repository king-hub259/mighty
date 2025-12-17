<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('subjects', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->string('subject_name', 40);
            $table->string('subject_code', 20);
            $table->string('subject_short_form')->nullable();
            $table->string('subject_type', 30)->nullable();
            $table->string('subject_type_form', 30)->nullable();
            $table->foreignId('class_id')->constrained('classes');
            $table->unsignedBigInteger('sl_no')->default(20)->nullable();
            $table->foreignId('group_id')->nullable();
            $table->unsignedInteger('objective')->nullable()->default('0');
            $table->unsignedInteger('written')->nullable()->default('0');
            $table->unsignedInteger('practical')->nullable()->default('0');
            $table->unsignedInteger('full_mark')->nullable()->default('0');
            $table->unsignedInteger('pass_mark')->nullable()->default('0');
            $table->softDeletes();
            $table->timestamps();

            $table->index(['id', 'class_id', 'group_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('subjects');
    }
};
