<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Modules\Authentication\Http\Controllers\API\AuthController;
use Modules\Authentication\Http\Controllers\API\BranchController;
use Modules\Authentication\Http\Controllers\API\DashboardController;
use Modules\Authentication\Http\Controllers\API\FeedbackController;
use Modules\Authentication\Http\Controllers\API\InstituteController;
use Modules\Authentication\Http\Controllers\API\OnboardingsController;
use Modules\Authentication\Http\Controllers\API\PermissionController;
use Modules\Authentication\Http\Controllers\API\PlanController;
use Modules\Authentication\Http\Controllers\API\RoleController;
use Modules\Authentication\Http\Controllers\API\SAASFaqController;
use Modules\Authentication\Http\Controllers\API\SAASSubscriptionController;
use Modules\Authentication\Http\Controllers\API\UserController;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::controller(AuthController::class)->group(function () {
    Route::post('/login', 'login');
    Route::post('/register', 'register');
});

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::controller(AuthController::class)->group(function () {
        Route::get('/profile', 'user');
        Route::post('/logout', 'logout');
        Route::post('/change-password', 'changePassword');
        Route::post('/profile-update', 'profileUpdate');
    });

    Route::get('institutes-status-update/{instituteId}', [InstituteController::class, 'statusUpdate']);
    Route::apiResource('institutes', InstituteController::class);
    Route::apiResource('branches', BranchController::class);
    Route::apiResource('permissions', PermissionController::class);
    Route::apiResource('roles', RoleController::class);
    Route::apiResource('users', UserController::class);
    Route::apiResource('plans', PlanController::class);
    Route::apiResource('saas-subscriptions', SAASSubscriptionController::class);

    Route::apiResource('feedbacks', FeedbackController::class);
    Route::apiResource('saas-faqs', SAASFaqController::class);
    Route::get('saas-dashboard-data', [DashboardController::class, 'saasDashboardData']);
    Route::get('dashboard-data', [DashboardController::class, 'index']);
    Route::get('student-attendance-summery', [DashboardController::class, 'studentAttendanceSummary']);
    Route::get('onboardings-list', [OnboardingsController::class, 'index']);
    Route::get('onboardings-approve/{onboardingId}', [OnboardingsController::class, 'approve']);
    Route::post('/subscription/upgrade', [OnboardingsController::class, 'upgrade']);

    Route::prefix('subscription')->group(function () {
        Route::get('/request-upgrade-list', [OnboardingsController::class, 'requestUpgradeList']);
        Route::post('/request-upgrade', [OnboardingsController::class, 'requestUpgrade']);
        Route::get('/approve-request/{id}', [OnboardingsController::class, 'approveRequest']);
        Route::post('/payment-upgrade', [OnboardingsController::class, 'paymentSubscriptions']);
    });

    Route::post('saas-settings-update', [DashboardController::class, 'sAASSettingsUpdate']);
    Route::post('saas-settings-upload-logo', [DashboardController::class, 'uploadLogo']);
});

Route::get('get-feedbacks', [FeedbackController::class, 'getFeedbacks']);
Route::get('get-saas-faqs', [SAASFaqController::class, 'getSaasFaqs']);
Route::get('get-packages', [PlanController::class, 'getPackages']);
Route::get('get-saas-settings', [DashboardController::class, 'getSAASSettings']);
Route::post('saas-subscriptions-email-store', [SAASSubscriptionController::class, 'publicStore']);
