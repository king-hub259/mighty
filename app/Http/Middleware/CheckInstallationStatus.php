<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckInstallationStatus
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Check if the installation status is valid
        if (file_exists(storage_path('mightySchool'))) {
            return redirect('/install'); // Redirect if the condition is met
        }

        return $next($request); // Proceed to the next middleware or controller
    }
}
