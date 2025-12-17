<?php

namespace App\Http\Middleware;

use Closure;

class CheckInstallation
{
    public function handle($request, Closure $next)
    {
        if (empty(config('database.connections.mysql.database') && file_exists(storage_path('mightySchool')))) {
            return redirect('/install');
        }

        return $next($request);
    }
}
