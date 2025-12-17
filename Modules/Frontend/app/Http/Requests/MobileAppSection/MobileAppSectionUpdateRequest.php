<?php

namespace Modules\Frontend\Http\Requests\MobileAppSection;

use Illuminate\Foundation\Http\FormRequest;

class MobileAppSectionUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'title' => 'required|string|max:191',
            'description' => 'required|string|max:255',
            'heading' => 'nullable|image',
            'image' => 'nullable|image',
            'feature_one' => 'nullable|image',
            'feature_two' => 'nullable|image',
            'feature_three' => 'nullable|image',
            'play_store_link' => 'nullable|image',
            'app_store_link' => 'nullable|image',
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
