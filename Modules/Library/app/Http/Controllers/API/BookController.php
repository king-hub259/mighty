<?php

namespace Modules\Library\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Modules\Library\Models\Book;
use Modules\Library\Services\BookService;

class BookController extends Controller
{
    public function __construct(private readonly BookService $bookService) {}

    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $books = Book::orderBy('id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $books,
                _lang('Books has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'book_name' => 'required|string|max:191',
            'code' => [
                'nullable',
                'string',
                'max:50',
            ],
            'author' => 'nullable',
            'publisher' => 'nullable',
            'quantity' => 'nullable',
            'photo' => 'nullable|image|max:5120',
            'barcode' => 'nullable|image|max:5120',
            'description' => 'nullable|string',
        ]);

        $book = $this->bookService->createOrUpdateBook($validated);

        if (! $book) {
            return $this->responseError([], _lang('Something went wrong. Book can not be create.'));
        }

        return $this->responseSuccess([], _lang('Book has been create.'));
    }

    public function show(int $id): JsonResponse
    {
        $book = $this->bookService->findBookById($id);

        if (! $book) {
            return $this->responseError([], _lang('Something went wrong. Book can not be show.'));
        }

        return $this->responseSuccess($book, _lang('Book has been show.'));
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $validated = $request->validate([
            'book_name' => 'required|string|max:191',
            'code' => [
                'nullable',
                'string',
                Rule::unique('books', 'code')->ignore($id),
                'max:50',
            ],
            'author' => 'nullable',
            'publisher' => 'nullable',
            'quantity' => 'nullable',
            'photo' => 'nullable|image|max:5120',
            'barcode' => 'nullable|image|max:5120',
            'description' => 'nullable|string',
        ]);

        $book = $this->bookService->findBookById($id);

        if (! $book) {
            return $this->responseError([], _lang('Something went wrong. Book can not be update.'));
        }

        $this->bookService->createOrUpdateBook($validated, $id);

        return $this->responseSuccess([], _lang('Book has been update.'));
    }

    public function destroy(int $id): JsonResponse
    {
        $book = $this->bookService->deleteBookById($id);

        if (! $book) {
            return $this->responseError([], _lang('Something went wrong. Book can not be delete.'));
        }

        return $this->responseSuccess([], _lang('Book has been delete.'));
    }
}
