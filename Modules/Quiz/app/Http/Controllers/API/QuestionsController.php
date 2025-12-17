<?php

namespace Modules\Quiz\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Excel;
use Modules\Quiz\Models\Question;
use Modules\Quiz\Models\Topic;

class QuestionsController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $questions = Question::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->orderBy('id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $questions,
                _lang('Quiz Topics has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function importExcelToDB1(int $id): JsonResponse
    {
        $topic = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();

        return $this->responseSuccess(
            $topic,
            _lang('Quiz Topics has been fetched successfully.')
        );
    }

    public function importExcelToDB(Request $request): JsonResponse
    {
        $request->validate([
            'question_file' => 'required|mimes:xlsx',
        ]);
        if ($request->hasFile('question_file')) {
            $path = $request->file('question_file')->getRealPath();
            $data = Excel::load($path)->get();

            if ($data->count()) {
                foreach ($data as $key => $value) {
                    $arr[] = [
                        'institute_id' => get_institute_id(),
                        'branch_id' => get_branch_id(),
                        'topic_id' => $request->topic_id,
                        'question' => $value->question,
                        'a' => $value->a,
                        'b' => $value->b,
                        'c' => $value->c,
                        'd' => $value->d,
                        'answer' => $value->answer,
                        'code_snippet' => $value->code_snippet != '' ? $value->code_snippet : '-',
                        'answer_exp' => $value->answer_exp != '' ? $value->answer_exp : '-',
                    ];
                }
                if (! empty($arr)) {
                    DB::table('questions')->insert($arr);

                    return $this->responseSuccess([], 'Question Imported Successfully.');
                }

                return $this->responseError([], 'Your excel file is empty or its headers are not matched to question table fields');
            }
        }

        return $this->responseSuccess([], 'Request data does not have any files to import.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'topic_id' => 'required',
            'question' => 'required',
            'a' => 'required',
            'b' => 'required',
            'c' => 'required',
            'd' => 'required',
            'answer' => 'required',
            'question_img' => 'image',
        ]);

        $input = $request->all();

        if ($file = $request->file('question_img')) {

            $name = 'question_'.time().$file->getClientOriginalName();
            $file->move('images/questions/', $name);
            $input['question_img'] = $name;
        }

        $input['institute_id'] = get_institute_id();
        $input['branch_id'] = get_branch_id();

        Question::create($input);

        return $this->responseSuccess(
            [],
            _lang('Question has been create successfully.')
        );
    }

    public function show(int $id): JsonResponse
    {
        $topic = Topic::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();
        $questions = Question::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('topic_id', $topic->id)->get();

        $data = [];
        $data['topic'] = $topic;
        $data['questions'] = $questions;

        return $this->responseSuccess(
            $data,
            _lang('Question has been create successfully.')
        );
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $question = Question::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();
        $request->validate([
            'topic_id' => 'required',
            'question' => 'required',
            'a' => 'required',
            'b' => 'required',
            'c' => 'required',
            'd' => 'required',
            'answer' => 'required',
        ]);

        $input = $request->all();

        if ($file = $request->file('question_img')) {

            $name = 'question_'.time().$file->getClientOriginalName();

            if ($question->question_img != null) {
                unlink(public_path().'/images/questions/'.$question->question_img);
            }

            $file->move('images/questions/', $name);
            $input['question_img'] = $name;
        }

        $question->update($input);

        return $this->responseSuccess(
            [],
            _lang('Question has been update successfully.')
        );
    }

    public function destroy(int $id): JsonResponse
    {
        $question = Question::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('id', $id)->first();

        if ($question->question_img != null) {
            unlink(public_path().'/images/questions/'.$question->question_img);
        }

        $question->delete();

        return $this->responseSuccess(
            [],
            _lang('Question has been deleted successfully.')
        );
    }
}
