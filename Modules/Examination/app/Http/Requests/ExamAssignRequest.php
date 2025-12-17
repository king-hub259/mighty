<?php

namespace Modules\Examination\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ExamAssignRequest extends FormRequest
{
    public function authorize()
    {
        return true; // Set authorization logic if needed
    }

    public function rules()
    {
        return [
            'class_id' => 'required|integer|exists:classes,id',
            'exam_ids' => 'required|array|min:1',
            'exam_ids.*' => 'required|integer|exists:exams,id',
            'merit_process_type_id' => 'required|integer|exists:merit_process_types,id',
        ];
    }

    public function messages()
    {
        //
    }
}
