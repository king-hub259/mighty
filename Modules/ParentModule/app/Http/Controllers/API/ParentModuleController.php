<?php

namespace Modules\ParentModule\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\StudentCollectionTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\AbsentFine;
use Modules\Academic\Models\Assignment;
use Modules\Academic\Models\ClassModel;
use Modules\Academic\Models\ClassRoutine;
use Modules\Academic\Models\Event;
use Modules\Academic\Models\LibraryMember;
use Modules\Academic\Models\Notice;
use Modules\Academic\Models\Section;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentSession;
use Modules\Academic\Models\Subject;
use Modules\Examination\Models\ExamMark;
use Modules\Finance\Models\Fee;
use Modules\Finance\Models\StudentCollectionDetailsSubHead;
use Modules\Library\Models\BookIssue;
use Modules\ParentModule\Models\ParentModel;
use Modules\Student\Models\AssignmentSubmit;
use Modules\Teacher\Models\Behavior;
use Modules\Teacher\Models\Gamification;
use Modules\Teacher\Models\Prayer;

class ParentModuleController extends Controller
{
    use StudentCollectionTrait;

    public function myProfile(): JsonResponse
    {
        $parent = ParentModel::where('parent_models.id', get_parent_id())->with('user', 'student')->first();

        return $this->responseSuccess($parent, 'Profile fetch successfully.');
    }

    public function defaultChildGet(): JsonResponse
    {
        $parent = ParentModel::where('parent_models.id', get_parent_id())->with('student')->first();
        if (! $parent) {
            return $this->responseError([], _lang('Something went wrong. Parent not found.'), 404);
        }

        return $this->responseSuccess($parent->student, 'Default Child fetch successfully.');
    }

    public function myChildrenList(): JsonResponse
    {
        $childrenList = Student::where('students.parent_id', get_parent_id())
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->select('students.*', 'classes.class_name', 'sections.section_name')
            ->get();

        return $this->responseSuccess($childrenList, 'Children List fetch successfully.');
    }

    public function defaultChildAssign(Request $request): JsonResponse
    {
        $studentId = (int) $request->student_id;
        $parent = ParentModel::where('parent_models.id', get_parent_id())->first();
        if (! $parent) {
            return $this->responseError([], _lang('Something went wrong. Parent not found.'), 404);
        }

        $parent->student_id = $studentId;
        $parent->save();

        return $this->responseSuccess($parent, 'Default Child Assign successfully.');
    }

    public function myChildrenProfile(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $student = Student::join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->join('parent_models', 'parent_models.id', '=', 'students.parent_id')
            // ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('students.parent_id', get_parent_id())
            ->where('students.id', $studentId)->first();

        return $this->responseSuccess($student, 'Children Profile fetch successfully.');
    }

    public function childrenAttendance(Request $request): JsonResponse
    {
        $request->validate([
            'month' => 'required|regex:/^\d{2}\/\d{4}$/', // Format must be MM/YYYY
        ]);

        $studentId = (int) get_authenticated_parent_student_id();
        [$monthPart, $yearPart] = explode('/', $request->month);

        $num_of_days = cal_days_in_month(CAL_GREGORIAN, (int) $monthPart, (int) $yearPart);

        $attendances = DB::table('student_attendances')
            ->select('student_attendances.*')
            ->join('students', 'student_attendances.student_id', '=', 'students.id')
            ->where('student_attendances.student_id', $studentId)
            ->where('students.parent_id', get_parent_id())
            ->whereMonth('date', $monthPart)
            ->whereYear('date', $yearPart)
            ->orderBy('date', 'asc')
            ->get();

        $report_data = [];
        $attendance_value = [
            '0' => '',
            '1' => _lang('Present'),
            '2' => _lang('Absent'),
            '3' => _lang('Late'),
        ];

        for ($day = 1; $day <= $num_of_days; $day++) {
            $date = sprintf('%04d-%02d-%02d', $yearPart, $monthPart, $day);
            $report_data[$date] = $attendance_value[0]; // default empty

            foreach ($attendances as $attendance) {
                if ($date === $attendance->date) {
                    $report_data[$date] = $attendance_value[$attendance->attendance] ?? $attendance_value[0];
                    break;
                }
            }
        }

        return response()->json([
            'month' => $request->month,
            'attendance' => $report_data,
        ]);
    }

    public function mySubjects(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $student = StudentSession::where('student_id', $studentId)->first();
        if (! $student) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        // Fetch compulsory subjects with group_id as null
        $compulsorySubjects = Subject::select('subjects.id AS id', 'subjects.subject_name', 'subjects.subject_code', 'subjects.subject_type', 'subjects.class_id', 'subjects.group_id')
            ->join('classes', 'classes.id', '=', 'subjects.class_id')
            ->where('subjects.class_id', $student->class_id)
            ->whereNull('subjects.group_id')
            ->get();

        // Fetch subjects based on the student's class and group
        $studentSubjects = Subject::select('*', 'subjects.id AS id')
            ->join('classes', 'classes.id', '=', 'subjects.class_id')
            ->where('subjects.class_id', $student->class_id)
            ->where('subjects.group_id', $student->student->group)
            ->get();

        // Merge the two subject collections
        $subjects = $compulsorySubjects->merge($studentSubjects);

        if (! $subjects) {
            return $this->responseError([], _lang('Something went wrong. Subject not found.'));
        }

        return $this->responseSuccess($subjects, 'Student Subjects fetch successfully.');
    }

    public function classRoutine(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $student = StudentSession::where('student_id', $studentId)->first();
        if (! $student) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $data = [];
        $data['class'] = ClassModel::find($student->class_id);
        $data['section'] = Section::find($student->section_id);
        $data['routine'] = ClassRoutine::getRoutineView($student->class_id, $student->section_id);

        if (! $data) {
            return $this->responseError([], _lang('Something went wrong. Class Routine not found.'));
        }

        return $this->responseSuccess($data, 'Student Class Routines fetch successfully.');
    }

    public function examRoutine(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $student = StudentSession::where('student_id', $studentId)->first();
        if (! $student) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $data = [];
        $data['class_id'] = $student->class_id;
        $data['exam_id'] = $request->exam_id;
        $exam = $request->exam_id;

        // Fetch compulsory subjects with group_id as null
        $compulsorySubjects = Subject::select('*', 'subjects.id AS id')
            ->join('classes', 'classes.id', '=', 'subjects.class_id')
            ->where('subjects.class_id', $student->class_id)
            ->whereNull('subjects.group_id')
            ->get();

        // Fetch subjects based on the student's class and group
        $studentSubjects = Subject::select('*', 'subjects.id AS id')
            ->join('classes', 'classes.id', '=', 'subjects.class_id')
            ->where('subjects.class_id', $student->class_id)
            ->where('subjects.group_id', $student->student->group)
            ->get();

        // Merge the two subject collections
        $subjects = $compulsorySubjects->merge($studentSubjects);

        $data['subjects'] = $subjects;
        if (! $data) {
            return $this->responseError([], _lang('Something went wrong. Exam Routine not found.'));
        }

        return $this->responseSuccess($data, 'Student Exam Routines fetch successfully.');
    }

    public function myAssignment(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $student = StudentSession::where('student_id', $studentId)->first();
        if (! $student) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $assignments = Assignment::select('assignments.id', 'assignments.title', 'assignments.description', 'subjects.subject_name', 'subjects.subject_code', 'subjects.subject_type', 'assignments.deadline', 'assignments.file', 'assignments.file_2', 'assignments.file_3', 'assignments.file_4')
            ->join('subjects', 'subjects.id', '=', 'assignments.class_id')
            ->where('assignments.class_id', $student->class_id)
            ->where('assignments.section_id', $student->section_id)
            ->where('assignments.session_id', get_option('academic_year'))
            ->where('assignments.institute_id', get_institute_id())
            ->where('assignments.branch_id', get_branch_id())
            ->orderBy('assignments.id', 'DESC')
            ->get();

        if (! $assignments) {
            return $this->responseError([], _lang('Something went wrong. Assignments not found.'));
        }

        return $this->responseSuccess($assignments, 'Student Assignments fetch successfully.');
    }

    public function assignmentSubmit(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $student = StudentSession::where('student_id', $studentId)->first();
        if (! $student) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $assignmentSubmits = AssignmentSubmit::select(
            'assignment_submits.*',
            'assignments.title AS assignment_title',
            'assignments.description AS assignment_description',
            'assignments.deadline AS assignment_deadline',
            'classes.class_name',
            'sections.section_name',
            'subjects.subject_name'
        )
            ->join('assignments', 'assignments.id', '=', 'assignment_submits.assignment_id') // Link to assignments
            ->join('classes', 'classes.id', '=', 'assignments.class_id') // Link to classes
            ->join('sections', 'sections.id', '=', 'assignments.section_id') // Link to sections
            ->join('subjects', 'subjects.id', '=', 'assignments.subject_id') // Link to subjects
            ->where('assignment_submits.student_id', $studentId)
            ->where('assignments.session_id', get_option('academic_year'))
            ->where('assignments.institute_id', get_institute_id())
            ->where('assignments.branch_id', get_branch_id()) // Ensure correct academic year
            ->orderBy('assignment_submits.id', 'DESC')
            ->get();

        if (! $assignmentSubmits) {
            return $this->responseError([], _lang('Something went wrong. Assignment Submit not found.'));
        }

        return $this->responseSuccess($assignmentSubmits, 'Assignment Submit fetch successfully.');
    }

    public function studentAttendanceFineReport(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $studentSession = StudentSession::where('student_id', $studentId)->first();
        if (! $studentSession) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        // $user = auth()->user();
        $class_id = $studentSession?->class_id;
        $section_id = $studentSession?->section_id;

        $attendanceAbsentFine = AbsentFine::where('period_id', 1)->first();
        if (! $attendanceAbsentFine) {
            return $this->responseError([], _lang('Attendance Fine not assign. please assign first'));
        }

        $studentAttendances = DB::table('students')
            ->join(
                'student_attendances',
                'students.id',
                '=',
                'student_attendances.student_id'
            )
            ->join('student_sessions', 'student_sessions.student_id', '=', 'students.id')
            ->leftJoin('absent_fines', function ($join) {
                $join->on('absent_fines.class_id', '=', 'student_sessions.class_id')
                    ->where('absent_fines.period_id', 5);
            })
            ->select(
                'students.id as student_id',
                'students.first_name',
                'student_sessions.roll',
                'student_sessions.section_id',
                DB::raw('MONTH(student_attendances.date) as month'),
                DB::raw('COUNT(student_attendances.id) as absent_count'),
                DB::raw('SUM(absent_fines.fee_amount) as fine_amount')
            )
            ->whereYear('student_attendances.date', current_year())
            ->where('student_attendances.student_id', $studentId)
            ->where('student_attendances.class_id', $class_id)
            ->where('student_attendances.section_id', $section_id)
            ->where('student_attendances.attendance', 2)
            ->where('student_attendances.period_id', 5)
            ->groupBy('students.id', 'students.first_name', 'student_sessions.roll', 'student_sessions.section_id', 'month') // Added section_id and roll here
            ->orderBy('student_sessions.roll', 'ASC')
            ->orderBy('month', 'ASC')
            ->get();

        $processedData = [];
        foreach ($studentAttendances as $data) {
            $sectionData = $data->section_id;
            $sectionData = Section::where('id', $sectionData)->select('id', 'section_name')->first();
            $sectionName = $sectionData->section_name;
            $studentId = $data->student_id;
            $studentName = $data->first_name;
            $roll = $data->roll;
            $month = $data->month;
            $absentCount = $data->absent_count;
            $fineAmount = $data->fine_amount;

            if (! isset($processedData[$studentId])) {
                $processedData[$studentId] = [
                    'section_name' => $sectionName,
                    'student_name' => $studentName,
                    'roll' => $roll,
                    'months' => [],
                    'total_fine_amount' => 0,
                ];
            }

            if (! isset($processedData[$studentId]['months'][$month])) {
                $processedData[$studentId]['months'][$month] = [
                    'absent_count' => 0,
                    'fine_amount' => 0,
                ];
            }

            $processedData[$studentId]['months'][$month]['absent_count'] += $absentCount;
            $processedData[$studentId]['months'][$month]['fine_amount'] += $fineAmount;
            $processedData[$studentId]['total_fine_amount'] += $fineAmount;
            $processedData[$studentId]['attendance_fine'] = $attendanceAbsentFine->fee_amount;
        }

        if (! $processedData) {
            return $this->responseError([], _lang('Something went wrong. Attendance Fine Report not found.'));
        }

        return $this->responseSuccess($processedData, 'Student Attendance Fine Report fetch successfully.');
    }

    public function getPaymentInfoStudent(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $studentSession = StudentSession::where('student_id', $studentId)->first();
        if (! $studentSession) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $student = $studentSession->student;
        // Fetch total paid amount for the current student
        $totalPaidAmount = DB::table('student_collections')
            ->where('student_id', $studentId)
            ->sum('total_paid');

        $data = [];
        $data['student'] = $student;
        $data['total_paid_amount'] = $totalPaidAmount;

        if (! $data) {
            return $this->responseError([], _lang('Something went wrong. Payment Info not found.'));
        }

        return $this->responseSuccess($data, 'Student Payment Info fetch successfully.');
    }

    public function getUnpaidFeeInfoStudent(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $studentSession = StudentSession::where('student_id', $studentId)->first();
        if (! $studentSession) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $classId = $studentSession->class_id;
        $sectionId = $studentSession->section_id;
        $feeHeads = [];

        $students = Student::query()
            ->select('users.*', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'students.id as id', 'student_groups.group_name', 'students.student_category_id')
            ->join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->leftJoin('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->leftJoin('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->leftJoin('student_groups', 'students.group', '=', 'student_groups.id')
            // ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('users.user_type', 'Student')
            ->where('student_sessions.class_id', $classId)
            ->where('student_sessions.section_id', $sectionId)
            ->orderBy('student_sessions.roll', 'ASC')
            ->get();

        $studentDatas = [];
        foreach ($students as $s_key => $student) {
            if ($student->id === $studentId) {
                $id = $student->id;
                $session = StudentSession::where('student_id', $id)->first();
                $amountConfig = Fee::where('section_id', $session->section_id)
                    ->where('class_id', $session->class_id)
                    ->with('feeHead')
                    ->get();

                $total_due_amount = 0;
                foreach ($amountConfig as $config) {
                    $feeHeads[] = $config->feeHead;
                    $feeHeads = array_unique($feeHeads);
                }

                // Check the fee subheads if already added and remove them from the feeHeads array.
                foreach ($feeHeads as $key => $feeHead) {
                    $feeSubHeads = $feeHead->feeSubHeads;
                    $updatedFeeSubHeads = [];

                    $amount = [];
                    foreach ($feeSubHeads as $skey => $feeSubHead) {
                        $studentCollectionDetailsSubHead = StudentCollectionDetailsSubHead::where('student_id', $id)
                            ->where('session_id', $session->session_id)
                            ->where('fee_head_id', $feeHead->id)
                            ->where('sub_head_id', $feeSubHead->id)
                            ->first();

                        if (! $studentCollectionDetailsSubHead || $studentCollectionDetailsSubHead->collectionDetail->total_paid === 0) {
                            array_push(
                                $updatedFeeSubHeads,
                                $feeSubHead
                            );
                            $payable_amount = $this->getCollectionAmountsByFeeHeadAndSubHeads(
                                $id,
                                $feeHead->id,
                                (array) $feeSubHead->id
                            );
                            $amount[$feeSubHead->id] = $payable_amount;
                            $total_due_amount += $payable_amount['fee_and_fine_payable'];
                        }
                    }

                    $feeHeads[$key]->feeSubHeads = $updatedFeeSubHeads;
                    $feeHeads[$key]->amount = $amount;
                }
                $studentDatas[$s_key] = $student;
                $studentDatas[$s_key]['feeHeads'] = $feeHeads;
                $studentDatas[$s_key]['total_due_amount'] = $total_due_amount;
            }
        }

        $data = [];
        $data['feeHeads'] = $feeHeads;
        $data['student_Data'] = $studentDatas;

        if (! $data) {
            return $this->responseError([], _lang('Something went wrong. Unpaid Info not found.'));
        }

        return $this->responseSuccess($data, 'Student Unpaid Info fetch successfully.');
    }

    public function studentNoticeGet(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $notices = Notice::select('id', 'title', 'notice', 'date', 'created_by')->with('userType')->paginate($perPage);

        return $this->responseSuccess($notices, 'Notices fetch successfully.');
    }

    public function studentEventGet(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $events = Event::select('id', 'start_date', 'end_date', 'name', 'details', 'location')->paginate($perPage);

        return $this->responseSuccess($events, 'Events fetch successfully.');
    }

    public function studentBehaviorGet(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();

        $perPage = (int) $request->per_page ?: 10;
        $events = Behavior::where('institute_id', get_institute_id())
            ->where('branch_id', get_branch_id())
            ->where('student_id', $studentId)
            ->paginate($perPage);

        return $this->responseSuccess($events, 'Behaviors fetch successfully.');
    }

    public function studentGamificationGet(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();

        $perPage = (int) $request->per_page ?: 10;
        $events = Gamification::where('institute_id', get_institute_id())
            ->where('branch_id', get_branch_id())
            ->where('student_id', $studentId)
            ->paginate($perPage);

        return $this->responseSuccess($events, 'Gamification fetch successfully.');
    }

    public function studentPrayerGet(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $studentSession = StudentSession::where('student_id', $studentId)->first();
        if (! $studentSession) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        $student = $studentSession->student;
        $perPage = (int) $request->per_page ?: 10;
        $events = Prayer::where('institute_id', get_institute_id())
            ->where('branch_id', get_branch_id())
            ->where('user_id', $student->user?->id)
            ->paginate($perPage);

        return $this->responseSuccess($events, 'Prayers fetch successfully.');
    }

    public function examResult(Request $request): JsonResponse
    {
        $studentId = (int) get_authenticated_parent_student_id();
        $examId = (int) $request->exam_id;
        $subjectId = (int) $request->subject_id;

        $studentSession = StudentSession::where('student_id', $studentId)->first();
        if (! $studentSession) {
            return $this->responseError([], _lang('Something went wrong. Student not found.'), 404);
        }

        // Initialize the query
        $query = ExamMark::with(['student', 'class', 'group', 'subject', 'exam'])
            ->where('student_id', $studentId);

        // Apply filters if present
        if (! empty($examId)) {
            $query->where('exam_id', $examId);
        }

        if (! empty($subjectId)) {
            $query->where('subject_id', $subjectId);
        }

        $results = $query->orderBy('id', 'DESC')->get();

        return $this->responseSuccess($results, 'Results have been fetched successfully.');
    }

    public function libraryHistory(Request $request): JsonResponse
    {
        $studentId = get_authenticated_parent_student_id();

        // Fetch the member by student ID
        $member = LibraryMember::join('users', 'users.id', '=', 'library_members.user_id')
            ->select(
                'users.id',
                'users.name',
                'users.email',
                'users.phone',
                'users.user_type',
                'users.image',
                'library_members.*'
            )
            ->where('library_members.student_id', $studentId)
            ->first();

        if (! $member) {
            return $this->responseError([], _lang('Library member not found.'));
        }

        // Fetch the book issues for the student
        $issues = BookIssue::select(
            'book_issues.id',
            'book_issues.library_id',
            'book_issues.issue_date',
            'book_issues.due_date',
            'book_issues.return_date',
            'book_issues.type',
            'books.id as book_id',
            'books.book_name',
            'books.code',
            'books.category'
        )
            ->join('books', 'books.id', '=', 'book_issues.book_id')
            ->where('book_issues.student_id', $studentId)
            ->orderByDesc('book_issues.id')
            ->get();

        // Prepare response
        $data = $member->toArray();
        $data['issues'] = $issues;

        return $this->responseSuccess($data, 'Student Library History fetched successfully.');
    }
}
