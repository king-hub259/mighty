<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Http\Requests\StudentCategoryCreateRequest;
use Modules\Academic\Services\StudentCategoriesService;

class APIStudentCategoriesController extends Controller
{
    public function __construct(private readonly StudentCategoriesService $studentCategoryService) {}

    public function index(Request $request): JsonResponse
    {
        $perPage = $request->get('per_page', 100);
        $studentCategories = $this->studentCategoryService->getStudentCategories([], $perPage);

        return $this->responseSuccess($studentCategories, 'Student Categories fetch successfully.');
    }

    public function store(StudentCategoryCreateRequest $request): JsonResponse
    {
        $studentCategory = $this->studentCategoryService->createStudentCategory($request->validated());

        if (! $studentCategory) {
            return $this->responseError([], _lang('Something went wrong. Student Category can not be submitted.'));
        }

        return $this->responseSuccess([], _lang('Student Category has been submitted.'));
    }

    public function show(int $id): JsonResponse
    {
        $studentCategory = $this->studentCategoryService->findStudentCategoryById($id);

        if (! $studentCategory) {
            return $this->responseError([], _lang('Something went wrong. Student Category can not be found.'), 404);
        }

        return $this->responseSuccess($studentCategory, _lang('Student Category has been fetch.'));
    }

    public function update(StudentCategoryCreateRequest $request, int $id)
    {
        $studentCategory = $this->studentCategoryService->findStudentCategoryById($id);

        if (! $studentCategory) {
            return $this->responseError([], _lang('Something went wrong. Student Category can not be found.'), 404);
        }

        $this->studentCategoryService->updateStudentCategory($request->validated(), $id);

        return $this->responseSuccess([], _lang('Student Category has been update.'));
    }

    public function destroy(int $id): JsonResponse
    {
        $studentCategory = $this->studentCategoryService->deleteStudentCategoryById($id);

        if (! $studentCategory) {
            return $this->responseError([], _lang('Something went wrong. Student Category can not be delete.'));
        }

        return $this->responseSuccess([], _lang('Student Category has been deleted.'));
    }
}
