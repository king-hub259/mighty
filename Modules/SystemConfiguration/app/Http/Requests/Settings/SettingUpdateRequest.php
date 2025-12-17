<?php

namespace Modules\SystemConfiguration\Http\Requests\Settings;

use Illuminate\Foundation\Http\FormRequest;

class SettingUpdateRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'school_name' => 'nullable|string|max:255',
            'site_title' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:255',
            'email' => 'nullable|string|max:255',
            'language' => 'nullable|string|max:255',
            'google_map' => 'nullable|string|max:255',
            'address' => 'nullable|string|max:255',
            'on_google_map' => 'nullable|string|max:255',
            'institute_code' => 'nullable|string|max:255',
            'timezone' => 'nullable|string|max:255',
            'academic_year' => 'nullable|string|max:255',
            'currency_symbol' => 'nullable|string|max:255',
            'mail_type' => 'nullable|string|max:255',
            'logo' => 'nullable|string|max:255',
            'disabled_website' => 'nullable|string|max:255',
            'copyright_text' => 'nullable|string|max:255',
            'exam_result_phone' => 'nullable|string|max:255',
            'tuition_fee_phone' => 'nullable|string|max:255',
            'facebook_link' => 'nullable|string|max:255',
            'google_plus_link' => 'nullable|string|max:255',
            'youtube_link' => 'nullable|string|max:255',
            'whats_app_link' => 'nullable|string|max:255',
            'twitter_link' => 'nullable|string|max:255',
            'eiin_code' => 'nullable|string|max:255',
            'sms_gateway' => 'nullable|string|max:255',
            'bulk_sms_api_key' => 'nullable|string|max:255',
            'bulk_sms_sender_id' => 'nullable|string|max:255',
            'twilio_sid' => 'nullable|string|max:255',
            'twilio_token' => 'nullable|string|max:255',
            'twilio_from_number' => 'nullable|string|max:255',
            'zoom_account_id' => 'nullable|string|max:255',
            'zoom_client_key' => 'nullable|string|max:255',
            'zoom_client_secret' => 'nullable|string|max:255',
            'stripe_payment_gateway' => 'nullable|string|max:255',
            'stripe_public_key' => 'nullable|string|max:255',
            'stripe_secret_key' => 'nullable|string|max:255',
            'razorpay_payment_gateway' => 'nullable|string|max:255',
            'razorpay_public_key' => 'nullable|string|max:255',
            'razorpay_secret_key' => 'nullable|string|max:255',
            'header_notice' => 'nullable|string|max:255',
            'exam_result_status' => 'nullable|string|max:255',
            'admission_display_status' => 'nullable|string|max:255',
            'tc_amount' => 'nullable|string|max:255',
            'app_version' => 'nullable|string|max:255',
            'sidebar_color' => 'nullable|string|max:255',
            'sidebar_text_color' => 'nullable|string|max:255',
            'sidebar_border_color' => 'nullable|string|max:255',
            'active_sidebar_background' => 'nullable|string|max:255',
            'app_url' => 'nullable|string|max:255',
        ];
    }

    public function message(): array
    {
        return [
            //
        ];
    }
}
