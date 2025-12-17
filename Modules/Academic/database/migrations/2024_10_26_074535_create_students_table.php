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
        Schema::create('students', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users');
            $table->string('group', 10)->nullable();
            $table->unsignedBigInteger('student_category_id')->default(1);
            $table->string('first_name', 50);
            $table->string('last_name', 20)->nullable();
            $table->string('phone', 25)->index();
            $table->unsignedBigInteger('register_no')->nullable();
            $table->unsignedBigInteger('roll_no')->nullable();
            $table->string('father_name', 50)->nullable();
            $table->string('mother_name', 50)->nullable();
            $table->date('birthday')->nullable();
            $table->string('gender', 20)->nullable();
            $table->string('blood_group', 5)->nullable();
            $table->string('religion', 20)->nullable();
            $table->longText('address')->nullable();
            $table->enum('status', [0, 1])->default(1);
            $table->unsignedBigInteger('parent_id')->nullable();

            // Information sent to whom.
            $table->string('information_sent_to_name')->nullable();
            $table->string('information_sent_to_relation')->nullable();
            $table->string('information_sent_to_phone', 15)->nullable();
            $table->string('information_sent_to_address')->nullable();

            // Additional Information
            $table->string('state', 30)->nullable();
            $table->string('country', 40)->nullable();
            $table->string('activities')->nullable();
            $table->string('access_key')->nullable();
            $table->longText('remarks')->nullable();
            $table->string('nationality')->nullable()->default('Bangladeshi');
            $table->string('birth_certificate_no', 100)->nullable();
            $table->string('nid_no', 100)->nullable();
            $table->string('ethnic')->nullable();
            $table->date('date_of_admission')->nullable();
            $table->string('application_number', 20)->nullable();
            $table->string('admission_place')->nullable();
            $table->string('tc_date')->nullable();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['user_id', 'phone', 'group']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('students');
    }
};
