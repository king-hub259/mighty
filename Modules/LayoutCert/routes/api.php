<?php

use Illuminate\Support\Facades\Route;
use Modules\LayoutCert\Http\Controllers\API\LayoutCertController;

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::get('layout-certificates', [LayoutCertController::class, 'index']);
});
