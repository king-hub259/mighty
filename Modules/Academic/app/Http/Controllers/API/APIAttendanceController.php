<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Enums\UserLogAction;
use App\Http\Controllers\Controller;
use App\Traits\Trackable;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\Academic\Models\AbsentFine;
use Modules\Academic\Models\SmsLog;
use Modules\Academic\Models\StaffAttendance;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentAttendance;
use Modules\Academic\Models\StudentSession;
use Modules\Academic\Services\StudentService;
use Modules\Academic\Services\UserService;
use Modules\Authentication\Models\User;

class APIAttendanceController extends Controller
{
    use Trackable;

    public function __construct(
        private readonly StudentService $studentService,
        private readonly UserService $userService
    ) {}

    public function getStudentAttendance(Request $request): JsonResponse
    {
        $class_id = (int) $request->class_id;
        $section_id = (int) $request->section_id;
        $period_id = (int) $request->period_id;
        $date = $request->date;

        $studentData = Student::select('*', 'student_attendances.id AS attendance_id')
            ->leftJoin('student_attendances', function ($join) use ($date, $period_id) {
                $join->on('student_attendances.student_id', '=', 'students.id');
                $join->where('student_attendances.date', '=', $date);
                $join->where('student_attendances.period_id', '=', $period_id);
            })
            ->join('student_sessions', 'student_sessions.student_id', '=', 'students.id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('student_sessions.class_id', $class_id)
            ->where('student_sessions.section_id', $section_id)
            ->orderBy('student_sessions.roll', 'ASC')
            ->get();

        return $this->responseSuccess($studentData, 'Attendance students fetch successfully.');
    }

    public function studentAttendance(Request $request): JsonResponse
    {
        try {
            // Validate the request
            $request->validate([
                'student_ids' => 'required|array|min:1',
                'student_ids.*' => 'exists:students,id',
                'class_id' => 'required|exists:classes,id',
                'section_id' => 'required|exists:sections,id',
                'period_id' => 'nullable|exists:periods,id',
                'subject_id' => 'nullable|exists:subjects,id',
                'date' => 'required|date',
                'attendance' => 'nullable|array|min:1',
                'attendance.*' => 'in:1,2,3', // Assuming 1=Present, 2=Absent, 3=Late
                'sms_status' => 'nullable|boolean',
            ]);

            // Start a database transaction
            DB::beginTransaction();

            $institute_id = get_institute_id();
            $branch_id = get_branch_id();
            $date = $request->date;

            foreach ($request->student_ids as $key => $student_id) {
                $attendance = $request->attendance[$key] ?? 2; // Default to Absent (2)
                StudentAttendance::updateOrCreate(
                    [
                        'student_id' => $student_id,
                        'class_id' => $request->class_id,
                        'section_id' => $request->section_id,
                        'period_id' => $request->period_id ?? 1,
                        'subject_id' => $request->subject_id,
                        'date' => $date,
                    ],
                    [
                        'institute_id' => $institute_id,
                        'branch_id' => $branch_id,
                        'attendance' => $attendance,
                    ]
                );

                // Check if SMS should be sent for absent students
                if ($request->sms_status == 1 && $attendance == 2) {
                    $student = $this->studentService->getStudentById($student_id);
                    if ($student && ! empty($student->information_sent_to_phone)) {
                        $mobile_number = $student->information_sent_to_phone;
                        $body = "Dear Guardian,\nThis is to inform you that your child is absent today at the college. Please ensure the reason for the absence. Feel free to contact the college administration for any clarification.\n\nThank you,\nDEMO";

                        SmsLog::create([
                            'receiver' => $mobile_number,
                            'message' => $body,
                            'student_id' => $student->id,
                            'user_type' => 'Student',
                            'sender_id' => Auth::user()->id,
                            'status' => 0,
                        ]);
                    }
                }
            }

            // Log attendance action
            $this->trackAction(
                UserLogAction::CREATE,
                StudentAttendance::class,
                Auth::id(),
                "Today's attendance recorded on $date."
            );

            DB::commit();

            return $this->responseSuccess([], 'Attendance recorded successfully.');
        } catch (Exception $e) {
            return $this->responseError([], 'Validation error', 422);
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function staffAttendance(Request $request): JsonResponse
    {
        // Validate the request
        $validator = Validator::make($request->all(), [
            'date' => 'required|date',
            'type' => 'required|string',
            'sms_status' => 'required|integer',
            'attendance' => 'required|array|min:1',
            'attendance.*.user_id' => 'required|exists:users,id',
            'attendance.*.attendance' => 'required|integer|in:1,2,3', // 1=Present, 2=Absent, 3=Late
            'attendance.*.start_time' => 'required|date_format:H:i',
            'attendance.*.end_time' => 'required|date_format:H:i|after:attendance.*.start_time',
        ]);

        if ($validator->fails()) {
            return $this->responseError($validator->errors(), 'Validation failed', 422);
        }

        DB::beginTransaction();

        try {
            $date = $request->date;
            $type = $request->type;
            $sms_status = intval($request->sms_status);
            $institute_id = get_institute_id(); // Fetch institute ID
            $branch_id = get_branch_id(); // Fetch branch ID

            foreach ($request->attendance as $record) {
                $staffAtt = StaffAttendance::updateOrCreate(
                    [
                        'user_id' => $record['user_id'],
                        'date' => $date,
                    ],
                    [
                        'start_time' => $record['start_time'],
                        'end_time' => $record['end_time'],
                        'attendance' => $record['attendance'],
                        'type' => $type,
                        'institute_id' => $institute_id, // Ensuring required field
                        'branch_id' => $branch_id, // Ensuring required field
                    ]
                );

                // Send SMS if necessary
                if ($sms_status == 1 && $staffAtt->attendance == 2) {
                    $this->sendSmsNotification($staffAtt);
                }
            }

            // Log the attendance action
            $this->trackAction(
                UserLogAction::CREATE,
                StaffAttendance::class,
                Auth::id(),
                "Staff attendance recorded on $date."
            );

            DB::commit();

            return $this->responseSuccess([], 'Attendance recorded successfully.');
        } catch (Exception $e) {
            DB::rollback();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function studentAttendanceDelete(Request $request): JsonResponse
    {
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'class_id' => 'required|integer|exists:classes,id',
            'section_id' => 'required|integer|exists:sections,id',
            'date' => 'required|date',
            'period_id' => 'required|integer|exists:periods,id',
            'type' => 'required|string|in:delete,fetch',
        ]);

        if ($validator->fails()) {
            return $this->responseError($validator->errors(), 'Validation failed.', 422);
        }

        $class_id = (int) $request->class_id;
        $section_id = (int) $request->section_id;
        $date = $request->date;
        $period_id = (int) $request->period_id;
        $type = $request->type;

        if ($type === 'delete') {
            DB::beginTransaction();
            try {
                $attendanceRecords = StudentAttendance::where('class_id', $class_id)
                    ->where('section_id', $section_id)
                    ->where('date', $date)
                    ->where('period_id', $period_id)
                    ->get();

                if ($attendanceRecords->isEmpty()) {
                    return $this->responseError([], 'Attendance data not found.', 404);
                }

                // Delete attendance records
                StudentAttendance::where('class_id', $class_id)
                    ->where('section_id', $section_id)
                    ->where('date', $date)
                    ->where('period_id', $period_id)
                    ->delete();

                // Log the delete action
                $this->trackAction(
                    UserLogAction::DELETE,
                    StudentAttendance::class,
                    Auth::id(),
                    "Deleted attendance records for Class ID: $class_id, Section ID: $section_id on $date, Period ID: $period_id."
                );

                DB::commit();

                return $this->responseSuccess([], 'Attendance data deleted successfully.');
            } catch (Exception $e) {
                DB::rollback();

                return $this->responseError([], 'An unexpected error occurred: '.$e->getMessage());
            }
        } else { // Fetch attendance data
            $attendanceRecords = StudentAttendance::where('class_id', $class_id)
                ->where('section_id', $section_id)
                ->where('date', $date)
                ->where('period_id', $period_id)
                ->get();

            return $this->responseSuccess($attendanceRecords, 'Attendance data fetched successfully.');
        }
    }

    public function studentQrCodeAttendance(Request $request): JsonResponse
    {
        $qrCode = $request->qr_code;
        if (! $qrCode) {
            return $this->responseError([], 'QR Code not found.', 404);
        }

        $studentSession = StudentSession::where('qr_code', $qrCode)->first();
        if (! $studentSession) {
            return $this->responseError([], 'Student Session not found.', 404);
        }

        // Check if attendance already exists for today
        $existingAttendance = StudentAttendance::where('student_id', $studentSession->student_id)
            ->whereDate('date', Carbon::today()) // Ensures comparison with date only
            ->exists();
        if ($existingAttendance) {
            return $this->responseError([], 'Attendance already taken for today.', 409);
        }

        // Start a database transaction
        DB::beginTransaction();
        try {
            StudentAttendance::create([
                'student_id' => $studentSession->student_id,
                'class_id' => $studentSession->class_id,
                'section_id' => $studentSession->section_id,
                'period_id' => 1,
                'date' => Carbon::today()->toDateString(), // Ensures only date is stored
                'attendance' => 1,
            ]);

            // Commit the transaction if all operations were successful
            DB::commit();

            return $this->responseSuccess([], 'Attendance taken successfully.');
        } catch (Exception $e) {
            // Rollback the transaction if an error occurred
            DB::rollback();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function studentAttendanceReport(Request $request): JsonResponse
    {
        // Validate incoming data
        $request->validate([
            'class_id' => 'required|integer|exists:classes,id',
            'section_id' => 'required|integer|exists:sections,id',
            'from_date' => 'nullable|date',
            'to_date' => 'nullable|date',
            'percentage' => 'nullable|numeric|min:0|max:100',
        ]);

        $from_date = $request->from_date ?? Carbon::now()->startOfMonth()->format('Y-m-d');
        $to_date = $request->to_date ?? date('Y-m-d');
        $percentage = $request->percentage ?? 0;

        $class_id = (int) $request->class_id;
        $section_id = (int) $request->section_id;

        // Fetch student attendance and student session data
        $students = StudentSession::with(['student'])
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('class_id', $class_id)
            ->where('section_id', $section_id)
            ->orderBy('student_sessions.roll', 'asc')
            ->get();

        $attendanceData = DB::table('student_attendances')
            ->where('student_attendances.institute_id', get_institute_id())
            ->where('student_attendances.branch_id', get_branch_id())
            ->where('period_id', 1)
            ->whereBetween('date', [$from_date, $to_date])
            ->whereIn('student_id', $students->pluck('student_id'))
            ->get();

        // Prepare the report data
        $report_data = [];

        foreach ($students as $studentSession) {
            $studentId = $studentSession->student_id;

            // Get present and absent counts for the student
            $attendance = $attendanceData->where('student_id', $studentId);
            $presentCount = $attendance->where('attendance', 1)->count();
            $absentCount = $attendance->where('attendance', 2)->count();

            // Calculate attendance percentage
            $totalClasses = $presentCount + $absentCount;
            $attendanceRatio = $totalClasses > 0 ? ($presentCount * 100 / $totalClasses) : 0;

            // Filter students by attendance ratio if percentage filter is applied
            if ($percentage > 0 && $attendanceRatio < $percentage) {
                continue;
            }

            $report_data[] = [
                'student_id' => $studentId,
                'student_name' => $studentSession->student->name,
                'present' => $presentCount,
                'absent' => $absentCount,
                'attendance_ratio' => floor($attendanceRatio),
            ];
        }

        // Return response with the attendance report
        return $this->responseSuccess($report_data, 'Attendance report generated successfully.');
    }

    public function absentFineReport(Request $request): JsonResponse
    {
        try {
            // Validate the request parameters
            $request->validate([
                'class_id' => 'required|integer',
                'section_id' => 'required|integer',
                'from_date' => 'nullable|date',
                'to_date' => 'nullable|date',
            ]);

            $class_id = intval($request->class_id);
            $section_id = intval($request->section_id);
            $from_date = $request->from_date ?? Carbon::now()->startOfMonth()->format('Y-m-d');
            $to_date = $request->to_date ?? date('Y-m-d');

            // If no filters are applied, return an empty response
            if (empty($request->all())) {
                return response()->json([
                    'status' => true,
                    'message' => 'No data provided for report.',
                    'data' => [],
                ]);
            }

            $class = get_class_name($class_id);
            $section = get_section_name($section_id);

            // Get the processed data from the database
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
                ->where('student_attendances.institute_id', get_institute_id())
                ->where('student_attendances.branch_id', get_branch_id())
                ->where('student_attendances.class_id', $class_id)
                ->where('student_attendances.section_id', $section_id)
                ->where('student_attendances.attendance', 2)
                ->whereBetween('student_attendances.date', [$from_date, $to_date])
                ->whereIn('student_attendances.period_id', [1, 2, 3])
                ->orderBy('student_sessions.roll', 'ASC')
                ->get();

            // Calculate fines based on processed data
            $fines = $processedData->groupBy('roll')->map(function ($studentData) {
                $attendanceAbsentFine = AbsentFine::where('period_id', 1)
                    ->where('student_attendances.institute_id', get_institute_id())
                    ->where('student_attendances.branch_id', get_branch_id())
                    ->first();
                $quizAbsentFine = AbsentFine::where('period_id', 2)
                    ->where('student_attendances.institute_id', get_institute_id())
                    ->where('student_attendances.branch_id', get_branch_id())
                    ->first();
                $labAbsentFine = AbsentFine::where('period_id', 3)
                    ->where('student_attendances.institute_id', get_institute_id())
                    ->where('student_attendances.branch_id', get_branch_id())
                    ->first();

                // Calculate fines for each period
                $attendanceFine = $studentData->where('period_id', 1)->count() * floatval($attendanceAbsentFine->fee_amount);
                $quizFine = $studentData->where('period_id', 2)->count() * floatval($quizAbsentFine->fee_amount);
                $labFine = $studentData->where('period_id', 3)->count() * floatval($labAbsentFine->fee_amount);

                $totalFine = $attendanceFine + $quizFine + $labFine;

                return [
                    'roll' => $studentData->first()->roll,
                    'first_name' => $studentData->first()->first_name,
                    'labFine' => $labFine,
                    'quizFine' => $quizFine,
                    'attendanceFine' => $attendanceFine,
                    'totalFine' => $totalFine,
                ];
            });

            // Calculate total fine amount
            $totalFineAmount = $fines->sum('totalFine');

            // Return JSON response with the report data
            return response()->json([
                'status' => true,
                'message' => 'Absent fine report generated successfully.',
                'data' => [
                    'class' => $class,
                    'section' => $section,
                    'from_date' => $from_date,
                    'to_date' => $to_date,
                    'fines' => $fines,
                    'totalFineAmount' => $totalFineAmount,
                ],
            ]);
        } catch (Exception $e) {
            // Return an error response in case of failure
            return response()->json([
                'status' => false,
                'message' => 'An error occurred while generating the report.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function staffAttendanceReport(Request $request): JsonResponse
    {
        try {
            // Validate the request
            $request->validate([
                'from_date' => 'required|date',
                'to_date' => 'required|date',
            ]);

            // Get the inputs from the request
            $from_date = $request->from_date;
            $to_date = $request->to_date;
            $institute_id = get_institute_id();
            $branch_id = get_branch_id();

            // Query to get the staff attendance data for the given date range
            $attendanceData = DB::table('staff_attendances')
                ->where('institute_id', $institute_id)
                ->where('branch_id', $branch_id)
                ->whereBetween('date', [$from_date, $to_date])
                ->select(
                    'user_id',
                    'type',
                    'attendance',
                    DB::raw('count(*) as total_attendance')
                )
                ->groupBy('user_id', 'attendance', 'type')
                ->get();

            // Process the data to get attendance summary for each user
            $reportData = [];
            foreach ($attendanceData as $data) {
                $user = User::find($data->user_id); // Get user details (name, role, etc.)

                // Ensure the user is found
                if ($user) {
                    if (! isset($reportData[$data->user_id])) {
                        $reportData[$data->user_id] = [
                            'user_id' => $data->user_id,
                            'name' => $user->name,
                            'role' => $data->type,
                            'present' => 0,
                            'absent' => 0,
                            'on_leave' => 0,
                        ];
                    }

                    // Increment the count based on attendance status
                    if ($data->attendance == 1) {
                        $reportData[$data->user_id]['present'] += $data->total_attendance;
                    } elseif ($data->attendance == 2) {
                        $reportData[$data->user_id]['absent'] += $data->total_attendance;
                    } else {
                        $reportData[$data->user_id]['on_leave'] += $data->total_attendance;
                    }
                }
            }

            // Return the report data
            return response()->json([
                'status' => true,
                'message' => 'Staff attendance report generated successfully.',
                'data' => array_values($reportData), // Return the data as a list
            ]);
        } catch (Exception $e) {
            // Handle any errors that occur
            return response()->json([
                'status' => false,
                'message' => 'An error occurred while generating the report.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    private function sendSmsNotification($staffAtt): bool
    {
        try {
            // Need Principal Number.
            $mobile_number = env('PRINCIPAL_MOBILE_NUMBER');
            // Body of the SMS to the principal
            $teacher = $this->userService->findUserById((int) $staffAtt->user_id);
            $body = "Dear Principal,
                This Teacher marked as absent today.
                Name: {$teacher->name}
                ID: {$teacher->id}
                I request your cooperation in this matter.
                Thank you,
                Academic Office";

            $log = new SmsLog;
            $log->institute_id = get_institute_id();
            $log->branch_id = get_branch_id();
            $log->receiver = $mobile_number;
            $log->message = $body;
            $log->teacher_id = intval($teacher->id);
            $log->user_type = $staffAtt->type;
            $log->sender_id = Auth::user()->id;
            $log->status = 0;
            $log->save();

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    private function deleteAttendanceData($class_id, $section_id, $date, $period_id): bool
    {
        try {
            DB::beginTransaction();
            $deletedRows = StudentAttendance::where('class_id', $class_id)
                ->where('section_id', $section_id)
                ->where('date', $date)
                ->where('period_id', $period_id)
                ->delete();

            $deletedRows > 0;
            DB::commit();

            return true;
        } catch (Exception $e) {
            DB::rollBack();

            return false;
        }
    }
}
