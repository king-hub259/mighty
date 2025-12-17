<?php

namespace Modules\Authentication\Http\Requests\Institute;

use Illuminate\Foundation\Http\FormRequest;

class InstituteUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'owner_id' => ['nullable', 'exists:users,id'],
            'name' => ['nullable', 'string', 'max:100'],
            'email' => [
                'nullable',
                'string',
                'email:rfc,dns',
                'max:100',
            ],
            'phone' => [
                'nullable',
                'string',
            ],
            'institute_type' => ['nullable', 'string', 'max:100'],
            'domain' => ['nullable', 'string', 'max:100'],
            'address' => ['nullable', 'string', 'max:191'],
            'logo' => ['nullable', 'image', 'mimes:jpeg,png,jpg,gif', 'max:2048'],
            'platform' => ['nullable', 'string', 'in:web,mobile,desktop'],
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
