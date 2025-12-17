<?php

namespace Modules\Frontend\Http\Requests\AboutUs;

use Illuminate\Foundation\Http\FormRequest;

class AboutUsUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'title' => 'required|string|max:191',
            'heading' => 'nullable|string|max:191',
            'description' => 'nullable|string|max:255',
            'position' => 'nullable|string|max:191',
            'image' => 'required|image',
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
