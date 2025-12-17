<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\RequestSanitizerTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Authentication\Http\Requests\SAASSubscription\SAASSubscriptionStoreRequest;
use Modules\Authentication\Http\Requests\SAASSubscription\SAASSubscriptionUpdateRequest;
use Modules\Authentication\Models\SAASSubscription;
use Modules\Authentication\Repositories\SAASSubscriptionRepository;

class SAASSubscriptionController extends Controller
{
    use RequestSanitizerTrait;

    public function __construct(private SAASSubscriptionRepository $sAASSubscriptionRepository) {}

    public function getSAASSubscriptions(Request $request): JsonResponse
    {
        $perPage = $request->get('per_page', 10);

        $getSAASSubscriptions = SAASSubscription::paginate($perPage);

        return $this->responseSuccess($getSAASSubscriptions, 'Saas Subscriptions fetched successfully.');
    }

    public function index(): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->sAASSubscriptionRepository->getAll(request()->all()),
                'SAAS Subscription has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function store(SAASSubscriptionStoreRequest $request): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->sAASSubscriptionRepository->create($request->all()),
                'SAAS Subscription has been created successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function show(int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->sAASSubscriptionRepository->getById($id),
                'SAAS Subscription has been fetched successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function update(SAASSubscriptionUpdateRequest $request, int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->sAASSubscriptionRepository->update($id, $this->getUpdateRequest($request)),
                'SAAS Subscription has been updated successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function destroy(int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->sAASSubscriptionRepository->delete($id),
                'SAAS Subscription has been deleted successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function publicStore(SAASSubscriptionStoreRequest $request): JsonResponse
    {
        $subscriptions = SAASSubscription::create([
            'email' => $request->email,
        ]);

        return $this->responseSuccess(
            $subscriptions,
            'SAAS Subscription has been created successfully.'
        );
    }
}
