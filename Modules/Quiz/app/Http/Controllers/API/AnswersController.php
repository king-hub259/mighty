<?php

namespace Modules\Quiz\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Quiz\Models\Answer;

class AnswersController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $topics = Answer::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->orderBy('id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $topics,
                _lang('Answer has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function destroy(int $id): JsonResponse
    {
        $answer = Answer::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();

        if (! $answer) {
            return $this->responseError([], _lang('Something went wrong. Quiz Topic can not be found.'), 404);
        }

        $answer->delete();

        return $this->responseSuccess(
            [],
            _lang('Answer has been deleted successfully.')
        );
    }
}
