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
        Schema::create('staffs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('department_id')->nullable()->constrained('departments');
            $table->string('name', 50);
            $table->string('designation')->nullable();
            $table->date('birthday')->nullable();
            $table->string('gender', 20)->nullable();
            $table->string('religion', 20)->nullable();
            $table->string('phone', 25);
            $table->string('blood', 5)->nullable();
            $table->integer('sl')->nullable();
            $table->text('address')->nullable();
            $table->date('joining_date')->nullable();
            $table->enum('status', [0, 1])->default(1);
            $table->enum('is_administrator', [0, 1])->default(0);
            $table->string('access_key', 25)->nullable();
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
        Schema::dropIfExists('staffs');
    }
};
