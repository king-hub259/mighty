<?php

namespace Modules\Finance\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\AbsentFine;
use Modules\Academic\Models\Student;
use Modules\Finance\Models\AttendanceWaiver;
use Modules\Finance\Models\StudentWaiverConfig;

class WaiverConfigController extends Controller
{
    public function index(): JsonResponse
    {
        $sectionId = (int) request()->section_id;
        $groupId = (int) request()->group;
        $studentCategoryId = (int) request()->student_category_id;

        $students = Student::query()
            ->select('users.*', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'students.id as id', 'student_groups.group_name', 'students.student_category_id')
            ->join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->leftJoin('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->leftJoin('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->leftJoin('student_groups', 'students.group', '=', 'student_groups.id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('users.user_type', 'Student')
            ->where('student_sessions.section_id', $sectionId)
            ->where('students.group', $groupId)
            ->where('students.student_category_id', $studentCategoryId)
            ->orderBy('student_sessions.roll', 'ASC')
            ->get();

        $waiverConfigLists = StudentWaiverConfig::join('students', 'student_waiver_configs.student_id', '=', 'students.id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('fee_heads', 'student_waiver_configs.fee_head_id', '=', 'fee_heads.id')
            ->join('waivers', 'student_waiver_configs.waiver_id', '=', 'waivers.id')
            ->select('student_waiver_configs.id', 'student_waiver_configs.amount', 'student_waiver_configs.student_id', 'students.first_name', 'students.last_name', 'student_sessions.roll', 'fee_heads.name', 'waivers.waiver')
            ->where('student_waiver_configs.institute_id', get_institute_id())
            ->where('student_waiver_configs.branch_id', get_branch_id())
            ->get();

        return $this->responseSuccess(
            [
                'students' => $students,
                'waiverConfigLists' => $waiverConfigLists,
            ],
            _lang('Fee Sub-Head has been fetched successfully.')
        );
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'students' => 'required|array',
            'fee_head_id' => 'nullable',
            'wavier_id' => 'required',
            'waiver_amount' => 'required',
        ]);

        $students = $request->students;
        $fee_head_id = (int) $request->fee_head_id;
        $wavier_id = (int) $request->wavier_id;
        $waiver_amount = (float) $request->waiver_amount;

        DB::beginTransaction();
        foreach ($students as $student) {
            $studenWaiverConfig = new StudentWaiverConfig;
            $studenWaiverConfig->institute_id = get_institute_id();
            $studenWaiverConfig->branch_id = get_branch_id();
            $studenWaiverConfig->student_id = (int) $student;
            $studenWaiverConfig->fee_head_id = (int) $fee_head_id;
            $studenWaiverConfig->waiver_id = (int) $wavier_id;
            $studenWaiverConfig->amount = $waiver_amount;
            $studenWaiverConfig->save();
        }
        DB::commit();

        return $this->responseSuccess(
            [],
            _lang('Waiver Config has been create successfully.')
        );
    }

    public function destroy(int $id): JsonResponse
    {
        $studentWaiverConfig = StudentWaiverConfig::where('id', $id)->first();

        if (! empty($studentWaiverConfig)) {
            $studentWaiverConfig->delete();

            return $this->responseSuccess(
                [],
                _lang('Waiver Config has been delete successfully.')
            );
        } else {
            return $this->responseError([], _lang('Something went wrong. Waiver Config can not be delete.'));
        }
    }

    public function attendanceWaiver()
    {
        $classId = (int) request()->class_id;
        $sectionId = (int) request()->section_id;

        $processedData = DB::table('students')
            ->join('student_attendances', 'students.id', '=', 'student_attendances.student_id')
            ->join('student_sessions', 'student_sessions.student_id', '=', 'students.id')
            ->select(
                'students.id as student_id',
                'students.first_name',
                'student_sessions.roll',
                'student_sessions.section_id',
                'student_attendances.period_id'
            )
            ->where('student_attendances.class_id', $classId)
            ->where('student_attendances.section_id', $sectionId)
            ->where('student_attendances.attendance', 2)
            ->whereIn('student_attendances.period_id', [1, 2, 3])
            ->orderBy('student_sessions.roll', 'ASC')
            ->get();

        $fines = $processedData->groupBy('roll')->map(function ($studentData) {
            $attendanceAbsentFine = AbsentFine::where('period_id', 1)->first();
            $quizAbsentFine = AbsentFine::where('period_id', 2)->first();
            $labAbsentFine = AbsentFine::where('period_id', 3)->first();

            $attendanceFine = $studentData->where('period_id', 1)->count() * floatval($attendanceAbsentFine->fee_amount);
            $quizFine = $studentData->where('period_id', 2)->count() * floatval($quizAbsentFine->fee_amount);
            $labFine = $studentData->where('period_id', 3)->count() * floatval($labAbsentFine->fee_amount);

            $totalFine = $attendanceFine + $quizFine + $labFine;

            return [
                'student_id' => $studentData->first()->student_id,
                'roll' => $studentData->first()->roll,
                'first_name' => $studentData->first()->first_name,
                'labFine' => $labFine,
                'quizFine' => $quizFine,
                'attendanceFine' => $attendanceFine,
                'totalFine' => $totalFine,
            ];
        });

        $totalFineAmount = $fines->sum('totalFine');

        return $this->responseSuccess([
            'fines' => $fines->values(), // Ensuring it's formatted correctly
            'classId' => $classId,
            'sectionId' => $sectionId,
            'totalFineAmount' => $fines->sum('totalFine'),
        ], _lang('Waiver Config has been deleted successfully.'));
    }

    public function attendanceWaiverStore(Request $request): JsonResponse
    {
        // Validate the incoming request
        $request->validate([
            'student_ids' => 'required|array|min:1',
            'attendance_fines' => 'required|array|min:1',
            'quiz_fines' => 'required|array|min:1',
            'lab_fines' => 'required|array|min:1',

            'student_ids.*' => 'required|exists:students,id',
            'attendance_fines.*' => 'required|numeric|min:0',
            'quiz_fines.*' => 'required|numeric|min:0',
            'lab_fines.*' => 'required|numeric|min:0',
        ]);

        // Ensure all arrays have the same length
        $studentIds = $request->student_ids;
        $attendanceFines = $request->attendance_fines;
        $quizFines = $request->quiz_fines;
        $labFines = $request->lab_fines;

        if (count($studentIds) !== count($attendanceFines) || count($studentIds) !== count($quizFines) || count($studentIds) !== count($labFines)) {
            return $this->responseError(_lang('All input arrays must have the same number of elements.'), 422);
        }

        // Loop through the student IDs
        for ($i = 0; $i < count($studentIds); $i++) {
            // Find existing AttendanceWaiver or create a new instance
            $attendanceWaiver = AttendanceWaiver::firstOrNew(['student_id' => $studentIds[$i]]);

            // Update the fields
            $attendanceWaiver->attendance_fine = $attendanceFines[$i];
            $attendanceWaiver->quiz_fine = $quizFines[$i];
            $attendanceWaiver->lab_fine = $labFines[$i];
            $attendanceWaiver->total_waiver = $attendanceWaiver->attendance_fine + $attendanceWaiver->quiz_fine + $attendanceWaiver->lab_fine;

            // Save the attendance waiver
            $attendanceWaiver->save();
        }

        return $this->responseSuccess([], _lang('Attendance Waiver Successfully.'));
    }
}
