<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Hostel\Models\MealPlan;

class MealPlanController extends Controller
{
    public function index(): JsonResponse
    {
        $mealPlans = MealPlan::orderBy('id', 'DESC')->get();

        return $this->responseSuccess($mealPlans, 'MealPlan fetched successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'meal_id' => 'required|exists:students,id',
            'date' => 'required|date',
        ]);

        $mealPlan = new MealPlan;
        $mealPlan->student_id = $request->student_id;
        $mealPlan->meal_id = $request->meal_id;
        $mealPlan->date = $request->date;
        $mealPlan->save();

        return $this->responseSuccess($mealPlan, 'MealPlan create successfully.');
    }

    public function show(int $id): JsonResponse
    {
        $mealPlan = MealPlan::find($id);
        if (! $mealPlan) {
            return $this->responseError([], _lang('Something went wrong. MealPlan can not be found.'));
        }

        return $this->responseSuccess($mealPlan, 'MealPlan create successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'student_id' => 'nullable|exists:students,id',
            'meal_id' => 'required|exists:students,id',
            'date' => 'required|date',
        ]);

        $mealPlan = MealPlan::find($id);
        if ($request->student_id) {
            $mealPlan->student_id = $request->student_id;
        }
        $mealPlan->meal_id = $request->meal_id;
        $mealPlan->date = $request->date;
        $mealPlan->save();

        return $this->responseSuccess($mealPlan, 'MealPlan update successfully.');
    }

    public function destroy(int $id): JsonResponse
    {
        $mealPlan = MealPlan::find($id);
        if (! $mealPlan) {
            return $this->responseError([], _lang('Something went wrong. MealPlan can not be found.'));
        }
        $mealPlan->delete();

        return $this->responseSuccess([], 'MealPlan delete successfully.');
    }
}
