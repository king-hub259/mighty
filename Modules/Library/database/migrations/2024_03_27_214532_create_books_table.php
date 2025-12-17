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
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->date('datetime')->nullable();
            $table->string('code', 100)->nullable();
            $table->integer('book_group')->nullable();
            $table->string('book_name', 255)->nullable();
            $table->string('book_copy_no', 255)->nullable();
            $table->string('publisher', 255)->nullable();
            $table->string('publish_year', 255)->nullable();
            $table->string('provider', 255)->nullable();
            $table->string('total_page', 255)->nullable();
            $table->string('identification_page', 255)->nullable();
            $table->string('aa', 255)->nullable();
            $table->string('author', 255)->nullable();
            $table->string('edition', 255)->nullable();
            $table->text('description')->nullable();
            $table->string('category', 255)->nullable();
            $table->string('quantity')->nullable();
            $table->string('price', 255)->nullable();
            $table->string('bookself', 255)->nullable();
            $table->string('rack', 255)->nullable();
            $table->text('path')->nullable();
            $table->string('status', 100)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('books');
    }
};
