<?php

namespace Modules\Quiz\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Quiz\Models\Answer;
use Modules\Quiz\Models\Topic;

class TopicController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $topics = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->orderBy('id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $topics,
                _lang('Quiz Topics has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function store(Request $request): JsonResponse
    {
        $input = $request->all();

        $request->validate([
            'title' => 'required|string',
            'per_q_mark' => 'required',
        ]);

        if (isset($request->quiz_price)) {
            $request->validate([
                'amount' => 'required',
            ]);
        }

        if (isset($request->quiz_price)) {
            $input['amount'] = $request->amount;
        } else {
            $input['amount'] = null;
        }

        if (isset($request->show_ans)) {
            $input['show_ans'] = 1;
        } else {
            $input['show_ans'] = 0;
        }

        $input['institute_id'] = get_institute_id();
        $input['branch_id'] = get_branch_id();

        $quiz = Topic::create($input);

        return $this->responseSuccess(
            $quiz,
            _lang('Quiz Topic has been create successfully.')
        );
    }

    public function show(int $id): JsonResponse
    {
        $topic = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();

        if (! $topic) {
            return $this->responseError([], _lang('Something went wrong. Quiz Topic can not be found.'), 404);
        }

        return $this->responseSuccess(
            $topic,
            _lang('Quiz Topic has been show successfully.')
        );
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([

            'title' => 'required|string',
            'per_q_mark' => 'required',

        ]);

        if (isset($request->pricechk)) {
            $request->validate([
                'amount' => 'required',
            ]);
        }

        $topic = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();
        if (! $topic) {
            return $this->responseError([], _lang('Something went wrong. Quiz Topic can not be found.'), 404);
        }

        $topic->title = $request->title;
        $topic->description = $request->description;
        $topic->per_q_mark = $request->per_q_mark;
        $topic->timer = $request->timer;

        if (isset($request->show_ans)) {
            $topic->show_ans = 1;
        } else {
            $topic->show_ans = 0;
        }

        if (isset($request->pricechk)) {
            $topic->amount = $request->amount;
        } else {
            $topic->amount = null;
        }

        $topic->save();

        return $this->responseSuccess(
            $topic,
            _lang('Quiz Topic has been update successfully.')
        );
    }

    public function destroy(int $id): JsonResponse
    {
        $topic = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();

        if (! $topic) {
            return $this->responseError([], _lang('Something went wrong. Quiz Topic can not be found.'), 404);
        }

        $topic->delete();

        return $this->responseSuccess(
            [],
            _lang('Quiz Topic has been delete successfully.')
        );
    }

    public function deleteperquizsheet(int $id): JsonResponse
    {
        $findanswersheet = Answer::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('topic_id', '=', $id)->get();

        if ($findanswersheet->count() > 0) {
            foreach ($findanswersheet as $value) {
                $value->delete();
            }

            return $this->responseSuccess(
                [],
                _lang('Answer Sheet Deleted For This Quiz !')
            );
        } else {
            return $this->responseSuccess(
                [],
                _lang('No Answer Sheet Found For This Quiz !')
            );
        }
    }
}
