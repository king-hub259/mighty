<?php

namespace Modules\Academic\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StudentCreateRequest extends FormRequest
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
            'first_name' => 'required|string|max:50',
            'last_name' => 'nullable|string|max:50',
            'father_name' => 'nullable|string|max:50',
            'mother_name' => 'nullable|string|max:50',
            'class_id' => 'required|exists:classes,id',
            'section_id' => 'required|exists:sections,id',
            'group' => 'required|exists:student_groups,id',
            'register_no' => 'nullable|numeric',
            'roll' => 'required|numeric',
            'blood_group' => 'nullable|string|max:4',
            'religion' => 'nullable|string|max:20',
            'gender' => 'nullable|string|max:10',
            'address' => 'nullable|string',
            'email' => 'required|string|email|max:50|unique:users,email',
            'phone' => 'required|string|max:25|unique:users,phone',
            'password' => 'required|string|min:6|confirmed',
            'image' => 'nullable|image|max:5120',
            'birthday' => 'nullable|date',
            'state' => 'nullable|string|max:50',
            'country' => 'nullable|string|max:100',
            'activities' => 'nullable|string|max:50',
            'remarks' => 'nullable|string|max:50',
            'information_sent_to_name' => 'nullable|string|max:30',
            'information_sent_to_relation' => 'nullable|string|max:30',
            'information_sent_to_phone' => 'nullable|string|max:30',
            'information_sent_to_address' => 'nullable|string|max:100',
        ];
    }
}
