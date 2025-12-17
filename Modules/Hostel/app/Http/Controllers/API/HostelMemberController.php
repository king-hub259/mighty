<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\Student;
use Modules\Hostel\Models\HostelCategory;
use Modules\Hostel\Models\HostelMember;

class HostelMemberController extends Controller
{
    public function index(): JsonResponse
    {
        $students = Student::join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->leftJoin('hostel_members', function ($join) {
                $join->on('hostel_members.student_id', '=', 'students.id');
            })
            ->select('users.*', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'students.id as id', 'hostel_members.id AS member_id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            // ->where('student_sessions.class_id', $classId)
            ->where('users.user_type', 'Student')
            ->orderBy('students.id', 'DESC')
            ->get();

        return $this->responseSuccess($students, 'Hostel members fetch successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'hostel_category_id' => 'required|exists:hostel_categories,id',
        ]);

        $member = new HostelMember;
        $member->institute_id = get_institute_id();
        $member->branch_id = get_branch_id();
        $member->student_id = $request->student_id;
        $member->hostel_category_id = $request->hostel_category_id;
        $member->save();

        return $this->responseSuccess($member, 'Hostel member fetch successfully.');
    }

    public function show($id): JsonResponse
    {
        $student = Student::join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('students.id', $id)->first();

        return $this->responseSuccess($student, 'Hostel member fetch successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'student_id' => 'nullable|exists:students,id',
            'hostel_category_id' => 'required|exists:hostel_categories,id',
        ]);

        $member = HostelMember::find($id);
        if (! $member) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        if ($request->student_id) {
            $member->student_id = $request->student_id;
        }
        $member->hostel_category_id = $request->hostel_category_id;
        $member->save();

        return $this->responseSuccess($member, 'Hostel member fetch successfully.');
    }

    public function destroy(int $id): JsonResponse
    {
        $member = HostelMember::find($id);
        if (! $member) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }
        $member->delete();

        return $this->responseSuccess([], 'Hostel member fetch successfully.');
    }

    public function get_hostel_fee(Request $request): JsonResponse
    {
        $request->validate([
            'hostel_category_id' => 'required|exists:hostel_categories,id',
        ]);

        $categoryId = (int) $request->hostel_category_id;
        $category = HostelCategory::find($categoryId)->first();
        if (! $category) {
            return $this->responseError([], _lang('Something went wrong. Category can not be found.'));
        }

        $hostel_fee = $category->hostel_fee;

        return $this->responseSuccess($hostel_fee, 'Hostel fee fetch successfully.');
    }
}
