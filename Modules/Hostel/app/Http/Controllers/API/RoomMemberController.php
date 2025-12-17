<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\Student;
use Modules\Hostel\Models\RoomMember;

class RoomMemberController extends Controller
{
    public function index($class = ''): JsonResponse
    {
        $students = Student::join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->leftJoin('room_members', function ($join) {
                $join->on('room_members.student_id', '=', 'students.id');
            })
            ->select('users.*', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'students.id as id', 'room_members.id AS member_id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            // ->where('student_sessions.class_id', $class)
            ->where('users.user_type', 'Student')
            ->orderBy('students.id', 'DESC')
            ->get();

        return $this->responseSuccess($students, 'Room Members fetch successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'room_id' => 'required|exists:rooms,id',
            'student_id' => 'required|exists:students,id',
        ]);

        $member = new RoomMember;
        $member->institute_id = get_institute_id();
        $member->branch_id = get_branch_id();
        $member->room_id = $request->room_id;
        $member->student_id = $request->student_id;
        $member->save();

        return $this->responseSuccess($member, 'Room members fetch successfully.');
    }

    public function show($id): JsonResponse
    {
        $student = Student::join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('students.id', $id)->first();

        return $this->responseSuccess($student, 'Room members fetch successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'room_id' => 'required|exists:rooms,id',
            'student_id' => 'nullable|exists:students,id',
        ]);

        $member = RoomMember::find($id);
        if (! $member) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        if ($request->student_id) {
            $member->student_id = $request->student_id;
        }
        $member->room_id = $request->room_id;
        $member->save();

        return $this->responseSuccess($member, 'Room members fetch successfully.');
    }

    public function destroy($id): JsonResponse
    {
        $member = RoomMember::find($id);
        if (! $member) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        $member->delete();

        return $this->responseSuccess([], 'Room members fetch successfully.');
    }
}
