<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Hostel\Models\HostelBill;

class HostelBillController extends Controller
{
    public function index($class = ''): JsonResponse
    {
        $mealEntries = HostelBill::orderBy('id', 'DESC')->get();

        return $this->responseSuccess($mealEntries, 'Meal Entries fetch successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'hostel_fee' => 'required|numeric',
            'meal_fee' => 'required|numeric',
            'total_amount' => 'required|numeric',
            'due_date' => 'required|date',
        ]);

        $mealEntry = new HostelBill;
        $mealEntry->institute_id = get_institute_id();
        $mealEntry->branch_id = get_branch_id();
        $mealEntry->student_id = $request->student_id;
        $mealEntry->hostel_fee = $request->hostel_fee;
        $mealEntry->meal_fee = $request->meal_fee;
        $mealEntry->total_amount = $request->total_amount;
        $mealEntry->due_date = $request->due_date;
        $mealEntry->save();

        return $this->responseSuccess($mealEntry, 'Meal Entry fetch successfully.');
    }

    public function show(int $id): JsonResponse
    {
        $mealEntry = HostelBill::where('id', $id)->first();

        return $this->responseSuccess($mealEntry, 'Meal Entry fetch successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'student_id' => 'nullable|exists:students,id',
            'hostel_fee' => 'required|numeric',
            'meal_fee' => 'required|numeric',
            'total_amount' => 'required|numeric',
            'due_date' => 'required|date',
        ]);

        $mealEntry = HostelBill::find($id);
        if (! $mealEntry) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        if ($request->student_id) {
            $mealEntry->student_id = $request->student_id;
        }
        $mealEntry->hostel_fee = $request->hostel_fee;
        $mealEntry->meal_fee = $request->meal_fee;
        $mealEntry->total_amount = $request->total_amount;
        $mealEntry->due_date = $request->due_date;
        $mealEntry->save();

        return $this->responseSuccess($mealEntry, 'Meal Entry fetch successfully.');
    }

    public function destroy($id): JsonResponse
    {
        $mealEntry = HostelBill::find($id);
        if (! $mealEntry) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        $mealEntry->delete();

        return $this->responseSuccess([], 'Meal Entry fetch successfully.');
    }
}
