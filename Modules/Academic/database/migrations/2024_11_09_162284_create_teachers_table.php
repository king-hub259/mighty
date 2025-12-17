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
        Schema::create('teachers', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('department_id')->nullable()->constrained('departments');
            $table->string('name', 30);
            $table->string('designation')->nullable();
            $table->date('birthday')->nullable();
            $table->string('gender', 20);
            $table->string('religion', 20)->nullable();
            $table->string('phone', 25);
            $table->string('blood', 5)->nullable();
            $table->integer('sl')->nullable();
            $table->string('marital_status', 20)->nullable();
            $table->string('father_name', 30)->nullable();
            $table->string('mother_name', 40)->nullable();
            $table->string('nationality', 20)->nullable();
            $table->string('national_id', 20)->nullable();
            $table->string('spouse_name', 20)->nullable();
            $table->string('passport_no', 20)->nullable();
            $table->string('tin_no', 20)->nullable();
            $table->longText('address')->nullable();
            $table->date('joining_date')->nullable();
            $table->longText('permanent_address')->nullable();
            $table->string('access_key', 25)->nullable();
            $table->string('attachment')->nullable();
            $table->string('training_attachment')->nullable();
            $table->enum('is_administrator', [0, 1])->default(0);
            $table->enum('is_visible_website', [0, 1])->default(1);
            $table->enum('status', [0, 1])->default(1);
            $table->timestamps();
            $table->softDeletes();

            $table->index(['user_id', 'department_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('teachers');
    }
};
