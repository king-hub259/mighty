<?php

namespace Modules\Frontend\Http\Requests\Testimonial;

use Illuminate\Foundation\Http\FormRequest;

class TestimonialUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:100',
            'university' => 'nullable|string|max:100',
            'rank' => 'nullable|numeric|digit:100000',
            'description' => 'nullable|string|max:500',
            'video_url' => 'nullable|string|max:255',
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
