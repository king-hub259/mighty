<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Hostel\Models\Meal;

class MealController extends Controller
{
    public function index(): JsonResponse
    {
        $meals = Meal::orderBy('id', 'DESC')->get();

        return $this->responseSuccess($meals, 'Meal fetched successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'meal_name' => 'required',
            'meal_type' => 'required',
        ]);

        $meal = new Meal;
        $meal->institute_id = get_institute_id();
        $meal->branch_id = get_branch_id();
        $meal->meal_name = $request->meal_name;
        $meal->meal_type = $request->meal_type;
        $meal->save();

        return $this->responseSuccess($meal, 'Meal create successfully.');
    }

    public function show(int $id): JsonResponse
    {
        $meal = Meal::find($id);
        if (! $meal) {
            return $this->responseError([], _lang('Something went wrong. Meal can not be found.'));
        }

        return $this->responseSuccess($meal, 'Meal create successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'meal_name' => 'required',
            'meal_type' => 'required',
        ]);

        $meal = Meal::find($id);
        $meal->meal_name = $request->meal_name;
        $meal->meal_type = $request->meal_type;
        $meal->save();

        return $this->responseSuccess($meal, 'Meal update successfully.');
    }

    public function destroy($id): JsonResponse
    {
        $meal = Meal::find($id);
        if (! $meal) {
            return $this->responseError([], _lang('Something went wrong. Meal can not be found.'));
        }

        $meal->delete();

        return $this->responseSuccess([], 'Meal delete successfully.');
    }
}
