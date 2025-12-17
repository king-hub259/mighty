<?php

namespace Modules\Library\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Library\Models\BookCategory;
use Modules\Library\Services\BookCategoryService;

class BookCategoriesController extends Controller
{
    public function __construct(private readonly BookCategoryService $bookCategoryService) {}

    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $categories = BookCategory::orderBy('id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $categories,
                _lang('Book Categories has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function store(Request $request): JsonResponse
    {
        $validatedData = $request->validate([
            'category_name' => 'required|string|max:20',
        ]);

        $accountingCategory = $this->bookCategoryService->createBookCategory($validatedData);

        if (! $accountingCategory) {
            return $this->responseError([], _lang('Something went wrong. Book Category can not be create.'));
        }

        return $this->responseSuccess([], _lang('Book Category has been create.'));
    }

    public function show(int $id): JsonResponse
    {
        $accountingCategory = $this->bookCategoryService->findBookCategoryById($id);

        if (! $accountingCategory) {
            return $this->responseError([], _lang('Something went wrong. Book Category can not be show.'));
        }

        return $this->responseSuccess($accountingCategory, _lang('Book Category has been show.'));
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $validatedData = $request->validate([
            'category_name' => 'required|string|max:20',
        ]);

        $accountingCategory = $this->bookCategoryService->findBookCategoryById($id);

        if (! $accountingCategory) {
            return $this->responseError([], _lang('Something went wrong. Book Category can not be update.'));
        }

        $this->bookCategoryService->updateBookCategory($validatedData, $id);

        return $this->responseSuccess([], _lang('Book Category has been updated successfully.'));
    }

    public function destroy(int $id): JsonResponse
    {
        $accountingCategory = $this->bookCategoryService->findBookCategoryById($id);

        if (! $accountingCategory) {
            return $this->responseError([], _lang('Something went wrong. Book Category can not be delete.'));
        }

        return $this->responseSuccess([], _lang('Book Category has been delete.'));
    }
}
