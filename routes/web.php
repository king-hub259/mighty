<?php

use App\Http\Controllers\WEB\InstallController;
use App\Http\Controllers\WebsiteController;
use Illuminate\Support\Facades\Route;

Route::get('/', [WebsiteController::class, 'index'])->name('index')->middleware('checkInstallation');

// ---------------Installation Process Start---------------------------------------\\
// Route for installation
Route::get('install', [InstallController::class, 'index']);
Route::prefix('install')->middleware('checkInstallationStatus')->group(function () {
    Route::get('start', [InstallController::class, 'index']);
    Route::get('requirements', [InstallController::class, 'requirements']);
    Route::get('permissions', [InstallController::class, 'permissions']);
    Route::get('step-4', [InstallController::class, 'keyWorld']);
    Route::any('step-5', [InstallController::class, 'step5']);
    Route::any('database', [InstallController::class, 'database']);
    Route::any('installation', [InstallController::class, 'installation']);
    Route::post('validate', [InstallController::class, 'validateInput'])->name('install.validate');
});
Route::get('install/complete', [InstallController::class, 'complete']);
// -----------------------Installation Process End------------------------------------\\

// Upgrade Module
Route::get('/upgrade', [InstallController::class, 'upgradeIndex']);
Route::post('/upgrade', [InstallController::class, 'uploadStore']);
