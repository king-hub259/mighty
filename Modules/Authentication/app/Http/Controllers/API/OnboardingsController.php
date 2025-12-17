<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\Authenticatable;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Modules\Authentication\Models\Branch;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\Plan;
use Modules\Authentication\Models\Subscription;
use Modules\Authentication\Models\SubscriptionItem;
use Modules\Authentication\Models\SubscriptionUpgradeRequest;
use Modules\Authentication\Models\User;
use Modules\Frontend\Models\Onboarding;
use Spatie\Permission\Models\Role;

class OnboardingsController extends Controller
{
    use Authenticatable;

    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $onboardings = Onboarding::whereNull('approved_at')->orderBy('id', 'desc')->paginate($perPage);
        if (! $onboardings) {
            return $this->responseError([], 'No Data Found!');
        }

        return $this->responseSuccess($onboardings, 'Onboardings fetch successfully');
    }

    public function approve(int $onboardingId): JsonResponse
    {
        // Start a transaction to ensure atomicity
        DB::beginTransaction();

        try {
            // Fetch the data to approve
            $onboarding = Onboarding::where('id', $onboardingId)->first();
            if (! $onboarding) {
                return $this->responseError([], 'No Data Found!', 404);
            }

            // Update the approval status and details
            $onboarding->status = 'approved';
            $onboarding->approved_by = $this->getCurrentUserId(); // Assuming the admin is logged in
            $onboarding->approved_at = Carbon::now();
            $onboarding->save();

            // Create the new institute
            $institute = Institute::create([
                'name' => $onboarding->collected_data['institute_name'],
                'type' => $onboarding->collected_data['institute_type'],
                'email' => $onboarding->collected_data['institute_email'],
                'phone' => $onboarding->collected_data['institute_phone'],
                'domain' => $onboarding->collected_data['institute_domain'],
                'logo' => $onboarding->institute_logo,
            ]);

            $branch = new Branch;
            $branch->name = 'Main Branch';
            $branch->institute_id = $institute->id;
            $branch->save();

            // Create the associated user
            $user = User::create([
                'institute_id' => $institute->id,
                'branch_id' => $branch->id,
                'name' => $onboarding->collected_data['user_name'],
                'email' => $onboarding->collected_data['user_email'],
                'phone' => $onboarding->collected_data['user_phone'],
                'password' => Hash::make($onboarding->collected_data['password']),
                'avatar' => $onboarding->user_avatar,
                'role_id' => 2,
                'user_type' => 'Admin',
            ]);

            if ($user) {
                $role = Role::where('id', 2)->first();
                $user->assignRole($role);
            }

            // Default Settings
            DB::table('settings')->insert([
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'school_name', 'value' => 'Demo Collage'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'site_title', 'value' => 'Demo Title'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'phone', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'email', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'language', 'value' => 'en'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'google_map', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'address', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'on_google_map', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'institute_code', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'timezone', 'value' => 'Asia/Dhaka'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'academic_year', 'value' => '1'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'currency_symbol', 'value' => '$'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'mail_type', 'value' => 'mail'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'logo', 'value' => 'logo.png'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'disabled_website', 'value' => 'no'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'copyright_text', 'value' => '&copy; Copyright 2025. All Rights Reserved by FueDevs LTD'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'exam_result_phone', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'tuition_fee_phone', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'facebook_link', 'value' => 'https://www.facebook.com/'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'google_plus_link', 'value' => 'https://www.google.com/'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'youtube_link', 'value' => 'https://www.youtube.com/'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'whats_app_link', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twitter_link', 'value' => 'https://www.twitter.com'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'eiin_code', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'sms_gateway', 'value' => 'twilio'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'bulk_sms_api_key', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'bulk_sms_sender_id', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twilio_sid', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twilio_token', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twilio_from_number', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'zoom_account_id', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'zoom_client_key', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'zoom_client_secret', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'header_notice', 'value' => ''],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'exam_result_status', 'value' => 'no'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'admission_display_status', 'value' => 'no'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'tc_amount', 'value' => 00],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'app_version', 'value' => '1.0.0'],
                ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'app_url', 'value' => 'drive-link'],
            ]);

            // Create a subscription for institute_id = 1
            $subscription = Subscription::create([
                'institute_id' => 1,
                'plan_id' => 1,
                'start_date' => Carbon::now(),
                'end_date' => Carbon::now()->addDays($plan->duration_days ?? 30),
                'status' => 'active',
                'invoice_details' => json_encode([
                    'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                    'issued_at' => now()->toDateString(),
                    'notes' => 'Trail Package',
                    'amount' => 0,
                ]),
            ]);

            // Create a related subscription item
            SubscriptionItem::create([
                'subscription_id' => $subscription->id,
                'reference_no' => 'PAY-'.strtoupper(Str::random(8)),
                'amount_paid' => 0,
                'payment_method' => 'Manual',
            ]);

            // Commit the transaction
            DB::commit();

            // Respond with a success message
            return $this->responseSuccess([
                'institute' => $institute,
                'user' => $user,
            ], 'Institute approved and created with credentials successfully.');
        } catch (Exception $e) {
            // Rollback in case of any failure
            DB::rollBack();

            return $this->responseError([], 'An error occurred: '.$e->getMessage());
        }
    }

    public function upgrade(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'institute_id' => 'required|exists:institutes,id',
            'plan_id' => 'required|exists:plans,id',
            'extra_days' => 'nullable|integer|min:0',
            'payment_method' => 'required|string',
            'amount_paid' => 'required|numeric|min:0',
            'notes' => 'nullable|string',
        ]);

        $instituteId = $validated['institute_id'];
        $plan = Plan::findOrFail($validated['plan_id']);
        $extraDays = $validated['extra_days'] ?? 0;

        $startDate = Carbon::now();
        $endDate = $startDate->copy()->addDays($plan->duration_days + $extraDays);

        // Fetch or create subscription for the institute
        $subscription = Subscription::where('institute_id', $instituteId)->first();
        if ($subscription) {
            // Update existing subscription
            $subscription->update([
                'plan_id' => $plan->id,
                'start_date' => $startDate,
                'end_date' => $endDate,
                'status' => 'active',
                'invoice_details' => json_encode([
                    'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                    'issued_at' => now()->toDateString(),
                    'notes' => $validated['notes'] ?? 'Upgraded Package',
                    'amount' => $validated['amount_paid'],
                ]),
            ]);
        } else {
            // Fallback (shouldn’t happen unless subscription was deleted)
            $subscription = Subscription::create([
                'institute_id' => $instituteId,
                'plan_id' => $plan->id,
                'start_date' => $startDate,
                'end_date' => $endDate,
                'status' => 'active',
                'invoice_details' => json_encode([
                    'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                    'issued_at' => now()->toDateString(),
                    'notes' => $validated['notes'] ?? 'Initial Subscription',
                    'amount' => $validated['amount_paid'],
                ]),
            ]);
        }

        // Create new subscription item
        SubscriptionItem::create([
            'subscription_id' => $subscription->id,
            'reference_no' => 'PAY-'.strtoupper(Str::random(8)),
            'amount_paid' => $validated['amount_paid'],
            'payment_method' => $validated['payment_method'],
        ]);

        // Respond with a success message
        return $this->responseSuccess([], 'Subscription updated successfully.');
    }

    public function requestUpgradeList(Request $request): JsonResponse
    {
        $perPage = $request->input('per_page', 15);
        $search = $request->input('search');

        $query = SubscriptionUpgradeRequest::where('status', 'pending')
            ->with(['institute', 'plan'])
            ->when($search, function ($q) use ($search) {
                $q->whereHas('institute', function ($q2) use ($search) {
                    $q2->where('name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%")
                        ->orWhere('phone', 'like', "%{$search}%");
                });
            })
            ->orderBy('id', 'desc');

        $upgradeRequests = $query->paginate($perPage);
        if ($upgradeRequests->isEmpty()) {
            return $this->responseError([], 'No upgrade requests found.');
        }

        return $this->responseSuccess($upgradeRequests, 'Upgrade requests fetched successfully.');
    }

    public function requestUpgrade(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'plan_id' => 'required|exists:plans,id',
            'notes' => 'nullable|string',
        ]);

        $instituteId = $this->getCurrentInstituteId(); // assume this gets the current user's institute ID
        $plan = Plan::findOrFail($validated['plan_id']);

        // Check for existing pending upgrade request for the same institute & plan
        $existingPending = SubscriptionUpgradeRequest::where('institute_id', $instituteId)
            // ->where('plan_id', $plan->id)
            ->where('status', 'pending')
            ->first();

        if ($existingPending) {
            // Update the existing pending request
            $existingPending->update([
                'extra_days' => (int) $plan->duration_days,
                'payment_method' => 'online', // or from config
                'amount_paid' => $plan->price,
                'notes' => $validated['notes'] ?? null,
            ]);

            $upgradeRequest = $existingPending;
        } else {
            // Create a new upgrade request
            $upgradeRequest = SubscriptionUpgradeRequest::create([
                'institute_id' => $instituteId,
                'plan_id' => $plan->id,
                'extra_days' => (int) $plan->duration_days,
                'payment_method' => 'online',
                'amount_paid' => $plan->price,
                'notes' => $validated['notes'] ?? null,
                'status' => 'pending',
            ]);
        }

        return $this->responseSuccess($upgradeRequest, 'Upgrade request submitted successfully.');
    }

    public function approveRequest(int $requestId): JsonResponse
    {
        DB::beginTransaction();
        try {
            $subscriptionRequest = SubscriptionUpgradeRequest::where('id', $requestId)->where('status', 'pending')->first();

            if (! $subscriptionRequest) {
                return $this->responseError([], 'No pending request found.', 404);
            }

            $plan = Plan::findOrFail($subscriptionRequest->plan_id);
            $extraDays = $subscriptionRequest->extra_days ?? 0;

            $startDate = Carbon::now();
            $endDate = $startDate->copy()->addDays($plan->duration_days + $extraDays);

            // Update or create subscription
            $subscription = Subscription::where('institute_id', $subscriptionRequest->institute_id)->first();

            if ($subscription) {
                $subscription->update([
                    'plan_id' => $plan->id,
                    'start_date' => $startDate,
                    'end_date' => $endDate,
                    'status' => 'active',
                    'invoice_details' => json_encode([
                        'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                        'issued_at' => now()->toDateString(),
                        'notes' => $subscriptionRequest->notes,
                        'amount' => $subscriptionRequest->amount_paid,
                    ]),
                ]);
            } else {
                $subscription = Subscription::create([
                    'institute_id' => $subscriptionRequest->institute_id,
                    'plan_id' => $plan->id,
                    'start_date' => $startDate,
                    'end_date' => $endDate,
                    'status' => 'active',
                    'invoice_details' => json_encode([
                        'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                        'issued_at' => now()->toDateString(),
                        'notes' => $subscriptionRequest->notes,
                        'amount' => $subscriptionRequest->amount_paid,
                    ]),
                ]);
            }

            SubscriptionItem::create([
                'subscription_id' => $subscription->id,
                'reference_no' => 'PAY-'.strtoupper(Str::random(8)),
                'amount_paid' => $subscriptionRequest->amount_paid,
                'payment_method' => $subscriptionRequest->payment_method,
            ]);

            $subscriptionRequest->update([
                'status' => 'approved',
                'approved_by' => auth()->id(),
                'approved_at' => now(),
            ]);

            DB::commit();

            return $this->responseSuccess($subscription, 'Subscription request approved successfully.');
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], 'Error: '.$e->getMessage());
        }
    }

    public function paymentSubscriptions(Request $request): JsonResponse
    {
        $request->validate([
            'institute_id' => 'required|exists:institutes,id',
            'plan_id' => 'required|exists:plans,id',
            'upgrade_request_id' => 'nullable|exists:subscription_upgrade_requests,id',
            'payment_method' => 'nullable|string',
            'notes' => 'nullable|string',
            'amount_paid' => 'nullable|numeric',
            'extra_days' => 'nullable|integer',
        ]);

        DB::beginTransaction();

        try {
            $plan = Plan::findOrFail((int) $request->plan_id);
            $startDate = Carbon::now();
            $extraDays = $request->input('extra_days', 0);
            $endDate = $startDate->copy()->addDays($plan->duration_days + $extraDays);

            $subscription = Subscription::where('institute_id', (int) $request->institute_id)->first();
            $invoiceData = [
                'invoice_no' => 'INV-'.strtoupper(Str::random(6)),
                'issued_at' => now()->toDateString(),
                'notes' => $request->input('notes', 'Payment for upgrade'),
                'amount' => $request->input('amount_paid', $plan->price),
            ];

            if ($subscription) {
                $subscription->update([
                    'plan_id' => $plan->id,
                    'start_date' => $startDate,
                    'end_date' => $endDate,
                    'status' => 'active',
                    'invoice_details' => $invoiceData,
                ]);
            } else {
                $subscription = Subscription::create([
                    'institute_id' => (int) $request->institute_id,
                    'plan_id' => $plan->id,
                    'start_date' => $startDate,
                    'end_date' => $endDate,
                    'status' => 'active',
                    'invoice_details' => $invoiceData,
                ]);
            }

            SubscriptionItem::create([
                'subscription_id' => $subscription->id,
                'reference_no' => 'PAY-'.strtoupper(Str::random(8)),
                'amount_paid' => $invoiceData['amount'],
                'payment_method' => $request->input('payment_method', 'online'),
            ]);

            // If upgrading through a pending request, mark it as approved
            if ($request->filled('upgrade_request_id')) {
                $upgradeRequest = SubscriptionUpgradeRequest::where('id', $request->upgrade_request_id)
                    ->where('status', 'pending')
                    ->first();

                if (! $upgradeRequest) {
                    return $this->responseError([], 'No pending upgrade request found.', 404);
                }

                $upgradeRequest->update([
                    'status' => 'approved',
                    'approved_by' => auth()->id(),
                    'approved_at' => now(),
                ]);
            }

            DB::commit();

            return $this->responseSuccess($subscription, 'Subscription payment processed successfully.');
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], 'Error: '.$e->getMessage());
        }
    }
}
