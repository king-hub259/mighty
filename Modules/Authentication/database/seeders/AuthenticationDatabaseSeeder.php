<?php

namespace Modules\Authentication\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;
use Modules\Authentication\Models\Plan;
use Modules\Authentication\Models\Subscription;
use Modules\Authentication\Models\SubscriptionItem;

class AuthenticationDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call(PlanTableSeeder::class);

        // Get a plan (you can specify an ID or use first())
        $plan = Plan::where('name', 'Professional')->first(); // Or Plan::find(1)
        if (! $plan) {
            $this->command->error('No plans found. Seed plans first.');

            return;
        }

        // Create a subscription for institute_id = 1
        $subscription = Subscription::create([
            'institute_id' => 1,
            'plan_id' => $plan->id,
            'start_date' => Carbon::now(),
            'end_date' => Carbon::now()->addDays($plan->duration_days ?? 365),
            'status' => 'active',
            'invoice_details' => json_encode([
                'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                'issued_at' => now()->toDateString(),
                'notes' => 'Auto-generated in seeder',
            ]),
        ]);

        // Create a related subscription item
        SubscriptionItem::create([
            'subscription_id' => $subscription->id,
            'reference_no' => 'PAY-'.strtoupper(Str::random(8)),
            'amount_paid' => 00,
            'payment_method' => 'Manual',
        ]);
    }
}
