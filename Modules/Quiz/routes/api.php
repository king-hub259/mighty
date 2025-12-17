<?php

use Illuminate\Support\Facades\Route;
use Modules\Quiz\Http\Controllers\API\AllReportController;
use Modules\Quiz\Http\Controllers\API\AnswersController;
use Modules\Quiz\Http\Controllers\API\QuestionsController;
use Modules\Quiz\Http\Controllers\API\TopicController;

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::apiResource('topics', TopicController::class);
    Route::delete('delete/sheet/quiz/{id}', [TopicController::class, 'deleteperquizsheet']);
    Route::apiResource('questions', QuestionsController::class);
    Route::get('questions-import_questions/{topic_id}', [QuestionsController::class, 'importExcelToDB1']);
    Route::post('questions/import_questions', [QuestionsController::class, 'importExcelToDB']);
    Route::apiResource('answers', AnswersController::class);
    Route::apiResource('all-reports', AllReportController::class);
});
