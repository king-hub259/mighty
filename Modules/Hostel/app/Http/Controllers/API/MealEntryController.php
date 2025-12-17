<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Hostel\Models\MealEntry;

class MealEntryController extends Controller
{
    public function index($class = ''): JsonResponse
    {
        $mealEntries = MealEntry::orderBy('id', 'DESC')->get();

        return $this->responseSuccess($mealEntries, 'Meal Entries fetch successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'meal_id' => 'required|exists:meals,id',
            'date' => 'required|date',
            'meal_price' => 'required|numeric',
        ]);

        $mealEntry = new MealEntry;
        $mealEntry->institute_id = get_institute_id();
        $mealEntry->branch_id = get_branch_id();
        $mealEntry->student_id = $request->student_id;
        $mealEntry->meal_id = $request->meal_id;
        $mealEntry->date = $request->date;
        $mealEntry->meal_price = $request->meal_price;
        $mealEntry->save();

        return $this->responseSuccess($mealEntry, 'Meal Entry fetch successfully.');
    }

    public function show(int $id): JsonResponse
    {
        $mealEntry = MealEntry::where('id', $id)->first();

        return $this->responseSuccess($mealEntry, 'Meal Entry fetch successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'student_id' => 'nullable|exists:students,id',
            'meal_id' => 'required|exists:meals,id',
            'date' => 'required|date',
            'meal_price' => 'required|numeric',
        ]);

        $mealEntry = MealEntry::find($id);
        if (! $mealEntry) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        if ($request->student_id) {
            $mealEntry->student_id = $request->student_id;
        }
        $mealEntry->meal_id = $request->meal_id;
        $mealEntry->date = $request->date;
        $mealEntry->meal_price = $request->meal_price;
        $mealEntry->save();

        return $this->responseSuccess($mealEntry, 'Meal Entry fetch successfully.');
    }

    public function destroy($id): JsonResponse
    {
        $mealEntry = MealEntry::find($id);
        if (! $mealEntry) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        $mealEntry->delete();

        return $this->responseSuccess([], 'Meal Entry fetch successfully.');
    }
}
