<?php

use Illuminate\Support\Facades\Route;
use Modules\Student\Http\Controllers\API\AssignmentController;
use Modules\Student\Http\Controllers\API\StudentDashboardController;
use Modules\Student\Http\Controllers\API\StudentQuizController;

Route::middleware(['student', 'auth:api'])->group(function () {
    Route::get('student/my-profile', [StudentDashboardController::class, 'my_profile']);
    Route::post('student/profile-update', [StudentDashboardController::class, 'profileUpdate']);
    Route::get('student/my-subjects', [StudentDashboardController::class, 'my_subjects']);
    Route::get('student/class-routine', [StudentDashboardController::class, 'class_routine']);
    Route::match(['get', 'post'], 'student/exam_routine/{view?}', [StudentDashboardController::class, 'exam_routine']);
    Route::get('student/library-history', [StudentDashboardController::class, 'library_history']);
    Route::get('student/my-assignment', [StudentDashboardController::class, 'my_assignment']);
    Route::get('student/view-assignment/{id?}', [StudentDashboardController::class, 'view_assignment']);

    Route::apiResource('student/assignments-submit', AssignmentController::class);
    Route::delete('student/assignments-submit/{id}', [AssignmentController::class, 'destroy']);

    Route::get('student/my-syllabus', [StudentDashboardController::class, 'my_syllabus']);
    Route::get('student/view-syllabus/{id?}', [StudentDashboardController::class, 'view_syllabus']);
    Route::get('student/attendance-fine-report', [StudentDashboardController::class, 'studentAttendanceFineReport']);
    Route::get('student/quiz-fine-report', [StudentDashboardController::class, 'studentQuizFineReport']);
    Route::get('student/lab-fine-report', [StudentDashboardController::class, 'studentLabFineReport']);
    Route::get('student/payment-fee-info', [StudentDashboardController::class, 'getPaymentInfoStudent']);
    Route::get('student/unpaid-info', [StudentDashboardController::class, 'getUnpaidFeeInfoStudent']);

    // Quiz Functionality
    Route::get('student/quiz', [StudentQuizController::class, 'quizPage']);
    Route::get('student/start_quiz/{id}', [StudentQuizController::class, 'quizStart']);
    Route::get('student/start_quiz/{id}/finish', [StudentQuizController::class, 'quizFinish']);

    // Core Setting
    Route::get('student/notices', [StudentDashboardController::class, 'studentNoticeGet']);
    Route::get('student/events', [StudentDashboardController::class, 'studentEventGet']);

    Route::get('student/behaviors', [StudentDashboardController::class, 'studentBehaviorGet']);
    Route::get('student/classlessons', [StudentDashboardController::class, 'studentClassLessonGet']);
    Route::get('student/prayers', [StudentDashboardController::class, 'studentPrayerGet']);
    Route::get('student/gamifications', [StudentDashboardController::class, 'studentGamificationGet']);
    Route::get('student/resources', [StudentDashboardController::class, 'studentResourcesGet']);
});
