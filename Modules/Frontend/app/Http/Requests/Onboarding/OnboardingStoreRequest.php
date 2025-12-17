<?php

namespace Modules\Frontend\Http\Requests\Onboarding;

use Illuminate\Foundation\Http\FormRequest;

class OnboardingStoreRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'institute_name' => 'required|string|max:100',
            'institute_email' => 'required|email|max:255',
            'institute_phone' => 'required|string|max:15',
            'institute_domain' => 'nullable|string|max:100',
            'institute_type' => 'nullable|string|max:100',
            'institute_address' => 'nullable|string|max:100',
            'institute_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'user_name' => 'required|string|max:100',
            'user_email' => 'required|email|max:255',
            'user_phone' => 'required|string|max:50',
            'password' => 'required|string|min:6',
            'user_avatar' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ];
    }

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }
}
