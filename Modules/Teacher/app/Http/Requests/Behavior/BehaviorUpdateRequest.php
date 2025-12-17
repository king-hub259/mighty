<?php

namespace Modules\Teacher\Http\Requests\Behavior;

use Illuminate\Foundation\Http\FormRequest;

class BehaviorUpdateRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'title' => 'required|string|max:191',
            'description' => 'nullable|string',
            'deadline' => 'required|date',
            'class_id' => 'required|exists:classes,id',
            'section_id' => 'required|exists:sections,id',
            'subject_id' => 'required|exists:subjects,id',
            'file' => 'required|mimes:doc,pdf,docx,zip',
            'file_2' => 'nullable|mimes:doc,pdf,docx,zip',
            'file_3' => 'nullable|mimes:doc,pdf,docx,zip',
            'file_4' => 'nullable|mimes:doc,pdf,docx,zip',
        ];
    }

    public function message(): array
    {
        return [
            //
        ];
    }
}
