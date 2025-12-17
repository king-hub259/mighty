<?php

namespace Modules\Finance\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FeesCreateRequest extends FormRequest
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
            'class_id' => 'required|exists:classes,id',
            'session_id' => 'nullable',
            'fee_amount' => 'required',
            'group_id' => 'nullable',
            'student_category_id' => 'nullable',
            'fee_head_id' => 'nullable',
            'fine_amount' => 'nullable',
            'fund_id' => 'nullable',
        ];
    }
}
