<?php

namespace Modules\Transport\Http\Requests\BusStop;

use Illuminate\Foundation\Http\FormRequest;

class BusStopUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'route_id' => 'required|string|max:191',
            'stop_name' => 'required|string|max:191',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|string',
            'stop_order' => 'nullable|string',
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
