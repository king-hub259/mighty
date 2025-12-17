<?php

use App\Http\Middleware\CheckInstallation;
use App\Http\Middleware\CheckInstallationStatus;
use App\Http\Middleware\CheckSubscription;
use App\Http\Middleware\ParentModelClass;
use App\Http\Middleware\Student;
use App\Http\Middleware\Teacher;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Middleware\HandleCors;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {

        $middleware->alias([
            'parent' => ParentModelClass::class,
            'teacher' => Teacher::class,
            'student' => Student::class,
            'checkInstallation' => CheckInstallation::class,
            'checkInstallationStatus' => CheckInstallationStatus::class,
            'check.subscription' => CheckSubscription::class,
        ]);

        $middleware->append([
            HandleCors::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
