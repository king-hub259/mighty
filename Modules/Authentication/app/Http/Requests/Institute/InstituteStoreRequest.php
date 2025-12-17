<?php

namespace Modules\Authentication\Http\Requests\Institute;

use Illuminate\Foundation\Http\FormRequest;

class InstituteStoreRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'owner_id' => ['required', 'exists:users,id'],
            'name' => ['required', 'string', 'max:100'],
            'email' => [
                'nullable',
                'string',
                'email:rfc,dns',
                'max:100',
                'unique:institutes,email', // Ensure unique email for new institutes
            ],
            'phone' => [
                'required',
                'string',
                'unique:institutes,phone', // Ensure unique phone for new institutes
            ],
            'institute_type' => ['required', 'string', 'max:100'],
            'domain' => ['required', 'string', 'max:100'],
            'address' => ['required', 'string', 'max:191'],
            'logo' => ['nullable', 'image', 'mimes:jpeg,png,jpg,gif', 'max:2048'],
            'platform' => ['nullable', 'string', 'in:WEB,APP,DESKTOP'],
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
