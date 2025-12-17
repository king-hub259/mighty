<?php

namespace Modules\Academic\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StaffCreateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:50',
            'phone' => 'required|string|max:25|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'designation' => 'nullable|string|max:50',
            'birthday' => 'nullable',
            'gender' => 'nullable|string|max:50',
            'religion' => 'nullable|string|max:50',
            'sl' => 'nullable|integer',
            'blood' => 'nullable|string',
            'address' => 'nullable',
            'email' => 'nullable|string|email|max:50|unique:users',
            'image' => 'nullable|image|mimes:jpg,jpeg,png,gif|max:5120',
        ];
    }
}
