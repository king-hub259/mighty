<?php

namespace Modules\Authentication\Http\Requests\Settings;

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
            'site_name' => 'nullable|string|max:255',
            'site_title' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:255',
            'office_phone' => 'nullable|string|max:255',
            'email' => 'nullable|string|max:255',
            'language' => 'nullable|string|max:255',
            'google_map' => 'nullable|string|max:255',
            'address' => 'nullable|string|max:255',
            'on_google_map' => 'nullable|string|max:255',
            'currency_symbol' => 'nullable|string|max:255',
            'logo' => 'nullable|string|max:255',
            'disabled_website' => 'nullable|string|max:255',
            'copyright_text' => 'nullable|string|max:255',
            'facebook_link' => 'nullable|string|max:255',
            'google_plus_link' => 'nullable|string|max:255',
            'youtube_link' => 'nullable|string|max:255',
            'whats_app_link' => 'nullable|string|max:255',
            'twitter_link' => 'nullable|string|max:255',
            'header_notice' => 'nullable|string|max:255',
            'app_version' => 'nullable|string|max:255',
            'app_url' => 'nullable|string|max:255',
            'bkash' => 'nullable|string|max:255',
            'paystack' => 'nullable|string|max:255',
            'razor_pay' => 'nullable|string|max:255',
            'stripe' => 'nullable|string|max:255',
            'ssl_commerz' => 'nullable|string|max:255',
            'pvit' => 'nullable|string|max:255',
            'paypal' => 'nullable|string|max:255',
            'paymob_accept' => 'nullable|string|max:255',
            'flutterwave' => 'nullable|string|max:255',
            'senang_pay' => 'nullable|string|max:255',
            'paytm' => 'nullable|string|max:255',
            'school_name' => 'nullable|string|max:255',
        ];
    }

    public function message(): array
    {
        return [
            //
        ];
    }
}
