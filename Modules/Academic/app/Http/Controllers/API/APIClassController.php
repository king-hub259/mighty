<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Http\Requests\ClassCreateRequest;
use Modules\Academic\Models\ClassModel;
use Modules\Academic\Models\Section;
use Modules\Academic\Services\ClassService;

class APIClassController extends Controller
{
    public function __construct(private readonly ClassService $classService) {}

    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $classes = ClassModel::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);

        return $this->responseSuccess($classes, 'Classes fetch successfully.');
    }

    public function store(ClassCreateRequest $request): JsonResponse
    {
        $class = $this->classService->createClass($request->validated());

        if (! $class) {
            return $this->responseError([], _lang('Something went wrong. Class can not be submitted.'));
        }

        return $this->responseSuccess([], _lang('Class has been submitted.'));
    }

    public function show(int $id): JsonResponse
    {
        $class = $this->classService->findClassById($id);

        if (! $class) {
            return $this->responseError([], _lang('Something went wrong. Class can not be found.'), 404);
        }

        return $this->responseSuccess($class, _lang('Class has been submitted.'));
    }

    public function update(ClassCreateRequest $request, int $id): JsonResponse
    {
        $class = $this->classService->findClassById($id);

        if (! $class) {
            return $this->responseError([], _lang('Something went wrong. Class can not be found.'), 404);
        }

        $this->classService->updateClass($request->validated(), $id);

        return $this->responseSuccess([], _lang('Class has been submitted.'));
    }

    public function destroy(int $id): JsonResponse
    {
        $section = Section::where('class_id', $id)->first();
        if ($section) {
            return $this->responseError([], _lang('Class cannot be deleted because it has assigned sessions.'));
        }

        $class = $this->classService->deleteClassById($id);
        if (! $class) {
            return $this->responseError([], _lang('Something went wrong. Class can not be delete.'));
        }

        return $this->responseSuccess([], _lang('Class has been deleted.'));
    }
}
