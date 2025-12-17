<?php

namespace Modules\SystemConfiguration\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\SystemConfiguration\Models\UserLog;
use Modules\SystemConfiguration\Services\UserLogService;

class UserLogsController extends Controller
{
    public function __construct(private readonly UserLogService $userLogService) {}

    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $classes = UserLog::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->with('user')->paginate($perPage);

        return $this->responseSuccess($classes, 'User activities fetch successfully.');
    }

    public function destroy(int $id): JsonResponse
    {
        $userLogs = $this->userLogService->deleteUserLogById($id);

        if (! $userLogs) {
            return $this->responseError([], _lang('Failed to delete records unsuccessfully'));
        }

        return $this->responseSuccess(
            [],
            _lang('User activities delete successfully.')
        );
    }
}
