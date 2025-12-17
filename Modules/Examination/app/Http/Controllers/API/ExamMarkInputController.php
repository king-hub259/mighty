<?php

namespace Modules\Examination\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Subject;
use Modules\Academic\Services\StudentService;
use Modules\Examination\Http\Requests\ExamAssignRequest;
use Modules\Examination\Models\ClassExam;
use Modules\Examination\Models\ExamCode;
use Modules\Examination\Models\ExamMark;
use Modules\Examination\Models\Grade;
use Modules\Examination\Models\GrandFinalClassExam;
use Modules\Examination\Models\MarkConfig;
use Modules\Examination\Models\MarkConfigExamCode;

class ExamMarkInputController extends Controller
{
    public function __construct(
        private readonly StudentService $studentService
    ) {}

    public function markConfig(Request $request): JsonResponse
    {
        $classId = (int) $request->class_id;
        $groupId = (int) $request->group_id;
        $data = [];

        // Initialize variables for subjects and class exams
        $subjects = collect();
        $classExams = collect();
        $examCodes = collect();
        $markConfig = collect();

        // If classId is provided, fetch subjects and class exams
        if ($classId) {
            $subjects = Subject::where('class_id', $classId)->where('group_id', $groupId)->orWhere('group_id', null)->select('id', 'class_id', 'subject_name')->get();
            $classExams = ClassExam::where('class_id', $classId)->with('exam', 'class', 'meritType')->get();
            $examCodes = ExamCode::where('class_model_id', $classId)->with('class', 'shortCode')->get();
            // Fetch MarkConfig based on class_id and group_id
            if ($request->type == 'mark_config_view') {
                $examId = (int) $request->exam_id;
                $markConfig = MarkConfig::with(['class', 'group', 'subject', 'exam', 'mark_config_exam_codes'])
                    ->where('class_id', $classId)
                    ->where('group_id', $groupId)
                    ->where('exam_id', $examId)
                    ->get();
            }
        }

        $data['classId'] = $classId;
        $data['groupId'] = $groupId;
        $data['subjects'] = $subjects;
        $data['classExams'] = $classExams;
        $data['examCodes'] = $examCodes;
        $data['markConfig'] = $markConfig;

        return $this->responseSuccess(
            $data,
            'Exam codes updated successfully.'
        );
    }

    public function generalExamStore(Request $request): JsonResponse
    {
        // Validate request data
        $request->validate([
            'class_id' => 'required|exists:classes,id',
            'group_id' => 'required|exists:student_groups,id',
            'selected_subjects' => 'required|array|min:1',
            'exam_codes' => 'required|array|min:1',
            'selected_exams' => 'required|array|min:1',
        ]);

        DB::beginTransaction();
        try {
            $classId = (int) $request->class_id;
            $groupId = (int) $request->group_id;
            $selectedSubjects = $request->selected_subjects;
            $examCodes = $request->exam_codes;
            $selectedExams = $request->selected_exams;

            foreach ($selectedSubjects as $subjectId) {
                foreach ($selectedExams as $examId) {
                    foreach ($examCodes as $code) {
                        // Ensure 'title' exists before updating/creating
                        if (! isset($code['title']) || empty($code['title'])) {
                            return $this->responseError([], 'Exam code title is required.', 422);
                        }

                        // Validate total_marks & pass_mark
                        if (! isset($code['total_marks']) || ! isset($code['pass_mark'])) {
                            return $this->responseError([], 'Total marks and pass mark are required.', 422);
                        }

                        // Ensure unique title + subject_id combination
                        $examCode = MarkConfigExamCode::firstOrCreate(
                            [
                                'institute_id' => get_institute_id(),
                                'branch_id' => get_branch_id(),
                                'session_id' => get_option('academic_year'),
                                'title' => $code['title'],
                                'subject_id' => $subjectId,
                            ],
                            [
                                'total_marks' => $code['total_marks'],
                                'pass_mark' => $code['pass_mark'],
                                'acceptance' => $code['acceptance'] ?? 0, // Default 0 if not provided
                            ]
                        );

                        if (! $examCode) {
                            return $this->responseError([], 'Failed to create exam code.', 422);
                        }

                        // Ensure MarkConfig entry does not exist before creating
                        $existingMarkConfig = MarkConfig::where([
                            'institute_id' => get_institute_id(),
                            'branch_id' => get_branch_id(),
                            'session_id' => get_option('academic_year'),
                            'class_id' => $classId,
                            'group_id' => $groupId,
                            'subject_id' => $subjectId,
                            'exam_id' => $examId,
                            'mark_config_exam_code_id' => $examCode->id,
                        ])->first();

                        if (! $existingMarkConfig) {
                            MarkConfig::create([
                                'institute_id' => get_institute_id(),
                                'branch_id' => get_branch_id(),
                                'session_id' => get_option('academic_year'),
                                'class_id' => $classId,
                                'group_id' => $groupId,
                                'subject_id' => $subjectId,
                                'exam_id' => $examId,
                                'mark_config_exam_code_id' => $examCode->id,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                        }
                    }
                }
            }

            DB::commit();

            return $this->responseSuccess(
                [],
                _lang('Mark Config updated successfully.')
            );
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], $e->getMessage(), 500);
        }
    }

    public function grandFinalExamStore(Request $request): JsonResponse
    {
        $request->validate([
            'class_id' => 'required|exists:classes,id',
            'percentages' => 'required|array',
            'serial_no' => 'required|array',
        ]);

        foreach ($request->percentages as $exam) {
            $examId = $exam['exam_id'];
            $percentage = $exam['percentage'];
            $serialNo = collect($request->serial_no)->where('exam_id', $examId)->first()['serial_no'];

            GrandFinalClassExam::updateOrCreate(
                [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'session_id' => get_option('academic_year'),
                    'class_id' => intval($request->class_id),
                    'exam_id' => intval($examId),
                ],
                [
                    'percentage' => floatval($percentage),
                    'serial_no' => intval($serialNo),
                ]
            );
        }

        return $this->responseSuccess(
            [],
            _lang('Grand Final Percentage Created successfully.')
        );
    }

    public function markInputSectionWiseClass(Request $request, int $classId): JsonResponse
    {
        $examId = (int) $request->exam_id ?? null;
        $groupId = (int) $request->group_id ?? null;
        $subjectId = (int) $request->subject_id ?? null;
        $sectionId = (int) $request->subject_id ?? null;
        $markConfig = collect();
        $students = collect();

        $data = [];
        if ($examId && $groupId && $subjectId) {
            $examId = (int) $request->exam_id;
            $markConfig = MarkConfig::with(['class', 'group', 'subject', 'exam', 'mark_config_exam_code'])
                ->where('class_id', $classId)
                ->where('group_id', $groupId)
                ->where('exam_id', $examId)
                ->where('subject_id', $subjectId)
                ->get();

            $students = $this->studentService->getStudentsByClassSectionGroup($classId, $sectionId, $groupId, 5);
        }

        $data['markConfig'] = $markConfig;
        $data['students'] = $students;

        return $this->responseSuccess(
            $data,
            'Mark Input Section wise students get successfully.'
        );
    }

    public function markStoreSectionWise(Request $request): JsonResponse
    {
        // Collect the basic details
        $classId = (int) $request->class_id;
        $groupId = (int) $request->group_id;
        $subjectId = (int) $request->subject_id;
        $examId = (int) $request->exam_id;

        try {
            // Start a database transaction
            DB::beginTransaction();

            // Loop through each student's marks
            foreach ($request->marks as $studentId => $studentMarks) {
                $marksData = [];
                $totalMarks = 0;

                // Loop through each mark for the student and add to total
                foreach ($studentMarks as $questionId => $mark) {
                    $marksData["mark{$questionId}"] = $mark ?? 0;
                    $totalMarks += $mark ?? 0;
                }

                // Determine the grade based on total marks from the grades table
                $grade = Grade::where('number_low', '<=', $totalMarks)
                    ->where('number_high', '>=', $totalMarks)
                    ->first();

                $gradeLetter = $grade->grade_name ?? 'F'; // Default to 'F' if no matching grade is found
                $gradePoint = $grade->grade_point; // Default to 0 if no matching grade is found

                // Define the identifying columns for the record
                $identifiers = [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'session_id' => get_option('academic_year'),
                    'student_id' => $studentId,
                    'class_id' => $classId,
                    'group_id' => $groupId,
                    'subject_id' => $subjectId,
                    'exam_id' => $examId,
                ];

                // Merge identifiers and marks data, and add total marks, grade, and grade point
                $data = array_merge($marksData, [
                    'total_marks' => $totalMarks,
                    'grade' => $gradeLetter,
                    'grade_point' => $gradePoint,
                ]);

                // Use updateOrCreate to insert or update the record
                ExamMark::updateOrCreate($identifiers, $data);
            }

            // Commit the transaction
            DB::commit();

            return $this->responseSuccess(
                $data,
                'Mark Input section wise store successfully.'
            );
        } catch (Exception $e) {
            // Roll back the transaction in case of any errors
            DB::rollBack();

            return $this->responseError([], $e->getMessage(), $e->getCode());
        }
    }

    public function examResult(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;

        // Initialize the query
        $query = ExamMark::with('student', 'class', 'group', 'subject', 'exam')->orderBy('id', 'ASC');

        // Apply optional filters if provided
        if ($request->has('class_id') && $request->class_id) {
            $query->where('class_id', $request->class_id);
        }
        if ($request->has('group_id') && $request->group_id) {
            $query->where('group_id', $request->group_id);
        }
        if ($request->has('subject_id') && $request->subject_id) {
            $query->where('subject_id', $request->subject_id);
        }
        if ($request->has('student_id') && $request->student_id) {
            $query->where('student_id', $request->student_id);
        }

        try {
            // Paginate the results with the applied filters
            $results = $query->paginate($perPage);

            return $this->responseSuccess(
                $results,
                'Results have been fetched successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function examAssignStore(ExamAssignRequest $request): JsonResponse
    {
        DB::beginTransaction();

        try {
            $classId = (int) $request->class_id;
            $meritProcessTypeId = (int) $request->merit_process_type_id;

            // Check for existing assignments in a single query
            $existingExams = ClassExam::where('class_id', $classId)
                ->where('merit_process_type_id', $meritProcessTypeId)
                ->whereIn('exam_id', $request->exam_ids)
                ->pluck('exam_id')
                ->toArray();

            // Filter out existing exams
            $newExams = array_diff($request->exam_ids, $existingExams);
            if (empty($newExams)) {
                return $this->responseError([], _lang('All selected exams for this class and merit process type already exist.'), 422);
            }

            // Prepare bulk insert data
            $insertData = [];
            foreach ($newExams as $examId) {
                $insertData[] = [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'class_id' => $classId,
                    'exam_id' => $examId,
                    'merit_process_type_id' => $meritProcessTypeId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            // Insert all new records in one query
            ClassExam::insert($insertData);

            DB::commit();

            return $this->responseSuccess(
                [],
                _lang('Exam merit assignments created successfully.')
            );
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], $e->getMessage(), 500);
        }
    }
}
