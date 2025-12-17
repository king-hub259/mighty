<?php

namespace Modules\Quiz\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Modules\Authentication\Models\User;
use Modules\Quiz\Models\Answer;
use Modules\Quiz\Models\Question;
use Modules\Quiz\Models\Topic;

class AllReportController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;

        try {
            // Fetch topics with question count
            $data = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->withCount('questions')
                ->orderBy('id', 'DESC')
                ->paginate($perPage);

            return $this->responseSuccess(
                $data,
                _lang('All Reports have been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function show(int $id): JsonResponse
    {
        try {
            // Fetch the topic
            $topic = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->findOrFail($id);

            // Fetch answers related to the topic
            $answers = Answer::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('topic_id', $topic->id)->get();

            // Fetch all users except the authenticated user
            $students = User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', '!=', Auth::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->id())->get();

            // Count the questions related to the topic
            $c_que = Question::where('topic_id', $id)->count();

            // Filter students who have answers
            $filtStudents = $students->filter(function ($student) use ($answers) {
                return $answers->contains('user_id', $student->id);
            })->unique('id')->values();

            // Format the response data
            $data = [
                'topic' => $topic,
                'answers' => $answers,
                'total_questions' => $c_que,
                'students' => $filtStudents,
            ];

            return $this->responseSuccess($data, _lang('Report fetched successfully.'));
        } catch (Exception $e) {
            return $this->responseError([], _lang('Topic not found.'), 404);
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function delete($topicid, $userid)
    {
        Answer::where('user_id', $userid)->where('topic_id', $topicid)->delete();

        return $this->responseSuccess([], _lang('Response Reset Successfully !.'));
    }
}
