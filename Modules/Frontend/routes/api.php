<?php

use Illuminate\Support\Facades\Route;
use Modules\Frontend\Http\Controllers\API\AboutUsController;
use Modules\Frontend\Http\Controllers\API\BannerController;
use Modules\Frontend\Http\Controllers\API\FaqQuestionController;
use Modules\Frontend\Http\Controllers\API\FrontendController;
use Modules\Frontend\Http\Controllers\API\PolicyController;
use Modules\Frontend\Http\Controllers\API\TestimonialsController;

// FrontendController Api Routes Start
Route::prefix('/frontend')->controller(FrontendController::class)->group(function () {
    Route::get('banners', 'banners');
    Route::get('about-us', 'aboutUs');
    Route::get('why-choose-us', 'whyChooseUs');
    Route::get('ready-to-join-us', 'readyToJoinUs');
    Route::get('teachers', 'teachers');
    Route::get('events', 'events');
    Route::get('notices', 'notices');
    Route::get('faq', 'faq');
    Route::get('terms-conditions', 'termConditions');
    Route::get('privacy-policy', 'privacyPolicy');
    Route::get('cookie-policy', 'cookiePolicy');
    Route::get('testimonials', 'testimonials');
    Route::get('mobile-app-sections', 'mobileAppSections');
    Route::get('settings', 'settings');
    Route::post('contact-us', 'contactUs');
    Route::post('onboarding', 'onboarding');
});

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::prefix('v1')->group(function () {
        Route::apiResource('banners', BannerController::class);
        Route::apiResource('faqs', FaqQuestionController::class);
        Route::apiResource('about-us', AboutUsController::class);
        Route::apiResource('policies', PolicyController::class);
        Route::apiResource('testimonials', TestimonialsController::class);
    });
});
