<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\ClassRoutine;
use Modules\Academic\Models\Exam;
use Modules\Academic\Models\ExamSchedule;
use Modules\Academic\Models\Subject;

class APIClassRoutineController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $classId = (int) $request->class_id;
        $sectionId = (int) $request->section_id;
        $routine_list = ClassRoutine::getRoutineView($classId, $sectionId);

        return $this->responseSuccess($routine_list, _lang('Routine has been fetch.'));
    }

    public function store(Request $request): JsonResponse
    {
        // Validate the incoming request data
        $request->validate([
            'routine' => 'required|array',
            'routine.*.section_id' => 'required|exists:sections,id',
            'routine.*.subject_id' => 'required|exists:subjects,id',
            'routine.*.day' => 'required|string',
            'routine.*.start_time' => 'required|string',
            'routine.*.end_time' => 'required|string',
            'routine.*.teacher_id' => 'required|exists:teachers,id',
        ]);

        // Start a database transaction
        DB::beginTransaction();
        try {
            $dataToInsert = [];
            $dataToUpdate = [];

            foreach ($request->routine as $routineData) {
                // Check if the start time is empty
                if (empty($routineData['start_time'])) {
                    continue; // Skip if start time is empty
                }

                // Check if routine exists
                $existingRoutine = ClassRoutine::where('subject_id', $routineData['subject_id'])
                    ->where('section_id', $routineData['section_id'])
                    ->where('day', $routineData['day'])
                    ->where('institute_id', get_institute_id())
                    ->where('branch_id', get_branch_id())
                    ->first();

                if ($existingRoutine) {
                    // If exists, prepare for update
                    $routineData['updated_at'] = Carbon::now();
                    $routineData['id'] = $existingRoutine->id; // Capture the ID for the update
                    $dataToUpdate[] = $routineData;
                } else {
                    // If does not exist, prepare for insert
                    $routineData['institute_id'] = get_institute_id();
                    $routineData['branch_id'] = get_branch_id();
                    $routineData['created_at'] = Carbon::now();
                    $routineData['updated_at'] = Carbon::now();
                    $dataToInsert[] = $routineData;
                }
            }

            // Insert new records
            if (! empty($dataToInsert)) {
                ClassRoutine::insert($dataToInsert);
            }

            // Update existing records
            foreach ($dataToUpdate as $data) {
                ClassRoutine::where('id', $data['id'])->update($data);
            }

            // Commit the transaction
            DB::commit();

            return $this->responseSuccess([], _lang('Class routines saved successfully.'));
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function exam_schedule(Request $request): JsonResponse
    {
        // Retrieve input data from the request
        $examId = (int) $request->exam_id;
        $classId = (int) $request->class_id;

        // Fetch all exams (not currently used in the data fetch, but you can use it in the view)
        $exams = Exam::all();

        // Fetch subjects and join with exam schedules based on the selected exam ID
        $subjects = Subject::select('subjects.subject_name', 'subjects.subject_code', 'subjects.subject_type', 'subjects.class_id', 'subjects.group_id', 'exam_schedules.*', 'exam_schedules.id as schedules_id', 'subjects.id as subject_id')
            ->leftJoin('exam_schedules', function ($join) use ($examId) {
                $join->on('subjects.id', '=', 'exam_schedules.subject_id');
                $join->where('exam_schedules.exam_id', $examId);
            })
            ->where('subjects.class_id', $classId)
            ->get();

        // Merge the exams and subjects (if needed, you can customize this part)
        $mergedData = $subjects->map(function ($subject) use ($exams) {
            // Add exam data to each subject (you could customize this as needed)
            $subject->exam = $exams->where('id', $subject->exam_id)->first(); // Assuming `exam_id` exists in the subject or schedules

            return $subject;
        });

        // Return the combined data with a success message
        return $this->responseSuccess($mergedData, _lang('Data have been fetched.'));
    }

    public function storeExamSchedule(Request $request): JsonResponse
    {
        // Start a database transaction
        DB::beginTransaction();

        try {
            // Validate input
            $request->validate([
                'exam_id' => 'required|numeric|exists:exams,id',
                'class_id' => 'required|numeric|exists:classes,id',
            ]);

            $exam = intval($request->exam_id);
            $class = intval($request->class_id);
            $examSchedules = [];

            // Loop through subjects and collect valid data for insertion
            foreach ($request->subject_ids as $mark_config_data) {
                if (empty($mark_config_data['date']) || empty($mark_config_data['start_time']) || empty($mark_config_data['end_time']) || empty($mark_config_data['room'])) {
                    continue;
                }

                $subjectId = $mark_config_data['subject_id'];
                $date = $mark_config_data['date'];
                $start_time = $mark_config_data['start_time'];
                $end_time = $mark_config_data['end_time'];
                $room = $mark_config_data['room'];

                // Collect the schedule data
                $examSchedules[] = [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'session_id' => intval(get_option('academic_year')),
                    'exam_id' => $exam,
                    'class_id' => $class,
                    'subject_id' => $subjectId,
                    'date' => $date,
                    'start_time' => $start_time,
                    'end_time' => $end_time,
                    'room' => $room,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];
            }

            // Insert or update the exam schedule
            foreach ($examSchedules as $examSchedule) {
                ExamSchedule::updateOrInsert(
                    [
                        'exam_id' => $examSchedule['exam_id'],
                        'class_id' => $examSchedule['class_id'],
                        'subject_id' => $examSchedule['subject_id'],
                    ],
                    $examSchedule
                );
            }

            // Commit the transaction
            DB::commit();

            return $this->responseSuccess([], _lang('Exam schedule saved successfully.'));
        } catch (\Exception $e) {
            // Rollback the transaction in case of error
            DB::rollBack();

            return $this->responseError([], $e->getMessage());
        }
    }
}
