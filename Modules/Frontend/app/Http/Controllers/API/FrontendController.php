<?php

namespace Modules\Frontend\Http\Controllers\API;

use App\Helpers\InstituteHelper;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Event;
use Modules\Academic\Models\Notice;
use Modules\Academic\Models\Teacher;
use Modules\Frontend\Http\Requests\Contact\ContactStoreRequest;
use Modules\Frontend\Http\Requests\Onboarding\OnboardingStoreRequest;
use Modules\Frontend\Models\AboutUs;
use Modules\Frontend\Models\Banner;
use Modules\Frontend\Models\Contact;
use Modules\Frontend\Models\FaqQuestion;
use Modules\Frontend\Models\MobileAppSection;
use Modules\Frontend\Models\Onboarding;
use Modules\Frontend\Models\OurHistory;
use Modules\Frontend\Models\Policy;
use Modules\Frontend\Models\ReadyToJoinUs;
use Modules\Frontend\Models\Testimonial;
use Modules\Frontend\Models\WhyChooseUs;

class FrontendController extends Controller
{
    public function banners(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Banner::where('institute_id', $instituteId)->get();

            return $this->responseSuccess(
                $data,
                'Banners has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function aboutUs(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = AboutUs::where('institute_id', $instituteId)->where('status', 1)->first();

            return $this->responseSuccess(
                $data,
                'AboutUs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function whyChooseUs(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = WhyChooseUs::select(
                'id',
                'institute_id',
                'branch_id',
                'title',
                'description',
                'icon',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'WhyChooseUs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function readyToJoinUs(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = ReadyToJoinUs::select(
                'id',
                'institute_id',
                'branch_id',
                'title',
                'description',
                'icon',
                'button_name',
                'button_link',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'ReadyToJoinUs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function teachers(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Teacher::with('user')->select(
                'id',
                'institute_id',
                'branch_id',
                'user_id',
                'department_id',
                'name',
                'designation',
                'sl',
                'status',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'Teachers has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function events(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Event::select(
                'id',
                'institute_id',
                'branch_id',
                'start_date',
                'end_date',
                'name',
                'image',
                'details',
                'location',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'Events has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function notices(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Notice::select('id', 'title', 'notice', 'date', 'image', 'created_by')->with('userType')
                ->where('institute_id', $instituteId)
                ->limit(5)
                ->get();

            return $this->responseSuccess(
                $data,
                'Notices has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function faq(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = FaqQuestion::where('institute_id', $instituteId)
                ->select('id', 'institute_id', 'question', 'answer')
                ->get();

            return $this->responseSuccess(
                $data,
                'Faqs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function privacyPolicy(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Policy::where('institute_id', $instituteId)->select('id', 'institute_id', 'type', 'description')->whereType(1)->first();

            return $this->responseSuccess(
                $data,
                'Privacy Policy has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function cookiePolicy(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Policy::where('institute_id', $instituteId)->select('id', 'institute_id', 'type', 'description')->whereType(2)->first();

            return $this->responseSuccess(
                $data,
                'Cookie Policy has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function termConditions(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Policy::where('institute_id', $instituteId)->select('id', 'institute_id', 'type', 'description')->whereType(3)->first();

            return $this->responseSuccess(
                $data,
                'Terms & Conditions has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function ourHistory(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = OurHistory::where('institute_id', $instituteId)
                ->select(
                    'institute_id',
                    'year',
                    'title',
                    'descriptions',
                    'status',
                    'created_by',
                )->first();

            return $this->responseSuccess(
                $data,
                'Our History has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function testimonials(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Testimonial::select(
                'id',
                'institute_id',
                'branch_id',
                'user_id',
                'description',
                'status',
            )
                ->with('user')
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'Testimonials has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function mobileAppSections(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = MobileAppSection::select(
                'id',
                'institute_id',
                'branch_id',
                'title',
                'heading',
                'description',
                'image',
                'feature_one',
                'feature_two',
                'feature_three',
                'play_store_link',
                'app_store_link',
            )
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'MobileAppSections has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function settings(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $settings = DB::table('settings')
                ->where('institute_id', $instituteId)
                ->pluck('value', 'name');

            return $this->responseSuccess(
                $settings,
                'Settings have been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    private function getInstituteIdFromHeader(Request $request): mixed
    {
        $domain = $request->header('X-Domain'); // Custom header key (Change if needed)
        if (! $domain) {
            return $this->responseError([], 'Domain header is missing.', 400);
        }

        $instituteResponse = InstituteHelper::getInstituteIdByDomain($domain);
        if (! $instituteResponse['status']) {
            return $this->responseError([], $instituteResponse['error'], 404);
        }

        return $instituteResponse['institute_id'];
    }

    public function contactUs(ContactStoreRequest $request): JsonResponse
    {
        try {
            $instituteId = $this->getInstituteIdFromHeader($request);
            if ($instituteId instanceof JsonResponse) {
                return $instituteId;
            }

            // Store Contact
            $contact = Contact::create([
                'email' => $request->email,
                'institute_id' => $instituteId,
            ]);

            return $this->responseSuccess(
                $contact,
                'Contact form submitted successfully.'
            );
        } catch (QueryException $e) {
            return $this->responseError([], 'Duplicate entry for email or phone.');
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function onboarding(OnboardingStoreRequest $request): JsonResponse
    {
        // Define fields to check for duplicates inside the JSON column
        $fieldsToCheck = [
            'institute_name' => 'Institute Name',
            'institute_email' => 'Institute Email',
            'institute_phone' => 'Institute Phone',
            'institute_domain' => 'Institute Domain',
            'user_email' => 'User Email',
            'user_phone' => 'User Phone',
        ];

        // Step 1: Loop through fields and check for duplicates in the collected_data JSON column
        foreach ($fieldsToCheck as $field => $label) {
            $value = $request->$field;
            // Use JSON_EXTRACT and JSON_UNQUOTE for cross-compatibility
            $exists = Onboarding::whereRaw("JSON_UNQUOTE(JSON_EXTRACT(collected_data, '$.{$field}')) = ?", [$value])->exists();

            if ($exists) {
                return $this->responseError([], "Duplicate entry for {$label}.", 422);
            }
        }

        // Step 2: Handle other validation logic and file uploads
        $validated = $request->validated();

        // Handle the institute_logo file upload if it exists
        $instituteLogoPath = null;
        if ($request->hasFile('institute_logo')) {
            $instituteLogoPath = fileUploader('institutes/', 'png', $request->file('institute_logo'));
        }

        // Handle the user_avatar file upload if it exists
        $userAvatarPath = null;
        if ($request->hasFile('user_avatar')) {
            $userAvatarPath = fileUploader('user_avatars/', 'png', $request->file('user_avatar'));
        }

        // Step 3: Save onboarding data
        $onboarding = Onboarding::create([
            'collected_data' => [
                'institute_name' => $validated['institute_name'],
                'institute_email' => $validated['institute_email'],
                'institute_phone' => $validated['institute_phone'],
                'institute_domain' => $validated['institute_domain'],
                'institute_type' => $validated['institute_type'],
                'user_name' => $validated['user_name'],
                'user_email' => $validated['user_email'],
                'user_phone' => $validated['user_phone'],
                'password' => $validated['password'],
            ],
            'institute_logo' => $instituteLogoPath,
            'user_avatar' => $userAvatarPath,
            'status' => 'pending',
        ]);

        // Return success response
        return $this->responseSuccess(
            $onboarding,
            'Onboarding request submitted successfully.'
        );
    }
}
