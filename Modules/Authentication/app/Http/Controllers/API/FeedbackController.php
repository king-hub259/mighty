<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\RequestSanitizerTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Authentication\Models\Feedback;
use Modules\Authentication\Repositories\FeedbackRepository;

class FeedbackController extends Controller
{
    use RequestSanitizerTrait;

    public function __construct(private FeedbackRepository $testimonial) {}

    public function getFeedbacks(Request $request): JsonResponse
    {
        $perPage = $request->get('per_page', 10);

        $getFeedbacks = Feedback::with('user')->paginate($perPage);

        return $this->responseSuccess($getFeedbacks, 'Feedbacks fetched successfully.');
    }

    public function index(): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->testimonial->getAll(request()->all()),
                'Testimonial has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->testimonial->create($request->all()),
                'Testimonial has been created successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function show(int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->testimonial->getById($id),
                'Testimonial has been fetched successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function update(Request $request, int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->testimonial->update($id, $this->getUpdateRequest($request)),
                'Testimonial has been updated successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function destroy(int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->testimonial->delete($id),
                'Testimonial has been deleted successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }
}
