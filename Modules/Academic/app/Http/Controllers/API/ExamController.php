<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Exam;

class ExamController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $exams = Exam::orderBy('id', 'desc')->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);

        return $this->responseSuccess($exams, 'Exams fetch successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'name' => 'required|max:255',
            'exam_code' => 'nullable|numeric',
        ]);

        DB::beginTransaction();
        try {
            $exam = new Exam;
            $exam->institute_id = get_institute_id();
            $exam->branch_id = get_branch_id();
            $exam->name = $request->name;
            $exam->exam_code = $request->exam_code;
            $exam->save();
            DB::commit();

            return $this->responseSuccess([], 'Exam has been create successfully.');
        } catch (\Exception $e) {
            DB::rollback();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function show(int $id): JsonResponse
    {
        $exam = Exam::where('id', $id)->first();

        return $this->responseSuccess($exam, 'Exam has been fetch successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'name' => 'required|max:255',
            'exam_code' => 'nullable|numeric',
        ]);

        $exam = Exam::where('id', $id)->first();

        DB::beginTransaction();
        try {
            $exam->name = $request->name;
            $exam->exam_code = $request->exam_code;
            $exam->update();
            DB::commit();

            return $this->responseSuccess([], 'Exam has been update successfully.');
        } catch (\Exception $e) {
            DB::rollback();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function destroy(int $id): JsonResponse
    {
        $exam = Exam::where('id', $id)->first();
        if (! empty($exam)) {
            $exam->delete();

            return $this->responseSuccess([], 'Exam has been delete successfully.');
        } else {
            return $this->responseError([], _lang('Something went wrong. Exam can not be delete.'));
        }
    }
}
