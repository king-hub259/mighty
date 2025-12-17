<?php

namespace App\Http\Middleware;

use App\Traits\ResponseTrait;
use Closure;

class CheckSubscription
{
    use ResponseTrait;

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $institute = auth()->user()->institute ?? null;

        if (! $institute || ! $institute->activeSubscription()) {
            return $this->responseError([], _lang('No active subscription.'), 403);
        }

        $subscription = $institute->activeSubscription();
        $plan = $subscription->plan;

        if (! $subscription->isActive()) {
            return $this->responseError([], _lang('Subscription expired.'), 403);
        }

        if ($institute->students()->count() >= $plan->student_limit) {
            return $this->responseError([], _lang('Student limit reached.'), 403);
        }

        if ($institute->branches()->count() >= $plan->branch_limit) {
            return $this->responseError([], _lang('Branch limit reached.'), 403);
        }

        return $next($request);
    }
}
