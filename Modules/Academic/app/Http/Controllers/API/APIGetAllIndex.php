<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\LibraryMember;
use Modules\Academic\Models\Period;
use Modules\Academic\Models\Section;
use Modules\Academic\Models\Staff;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentGroup;
use Modules\Academic\Models\Subject;
use Modules\Academic\Models\Teacher;
use Modules\Academic\Services\ClassService;
use Modules\Academic\Services\SectionService;
use Modules\Academic\Services\StudentService;
use Modules\Library\Models\Book;

class APIGetAllIndex extends Controller
{
    public function __construct(
        private readonly ClassService $classService,
        private readonly SectionService $sectionService,
        private readonly StudentService $studentService
    ) {}

    public function getTeachers(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $teachers = Teacher::select(
                'teachers.id AS id',
                'users.id as user_id',
                'users.name',
                'users.phone',
                'users.image',
                'users.role_id',
                'users.user_type',
                'teachers.designation',
                'teachers.gender',
                'teachers.religion',
                'teachers.sl',
                'teachers.status AS teacher_status',
            )
                ->where('teachers.institute_id', get_institute_id())->where('teachers.branch_id', get_branch_id())
                ->join('users', 'users.id', '=', 'teachers.user_id')
                ->orderBy('teachers.id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $teachers,
                _lang('Teachers has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getStaffs(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $staffs = Staff::select(
                'staffs.id AS id',
                'users.id as user_id',
                'users.name',
                'users.phone',
                'users.image',
                'users.role_id',
                'users.user_type',
                'staffs.designation',
                'staffs.gender',
                'staffs.religion',
                'staffs.sl',
                'departments.department_name',
            )
                ->where('staffs.institute_id', get_institute_id())->where('staffs.branch_id', get_branch_id())
                ->join('users', 'users.id', '=', 'staffs.user_id')
                ->join('departments', 'staffs.department_id', '=', 'departments.id')
                ->orderBy('staffs.id', 'DESC')->paginate($perPage);

            return $this->responseSuccess(
                $staffs,
                _lang('Staffs has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getLibraryMembers(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            // Use paginate() instead of get() to apply pagination
            $libraryMembers = LibraryMember::with('user')->orderBy('id', 'asc')->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);

            return $this->responseSuccess(
                $libraryMembers,
                _lang('Library Members has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getStudentsByClassSectionGroup(Request $request): JsonResponse
    {
        $class_id = (int) request()->class_id;
        $section_id = (int) request()->section_id;
        $group_id = (int) request()->group_id;

        try {
            $students = $this->studentService->getStudentsByClassSectionGroup($class_id, $section_id, $group_id, (int) $request->per_page);

            return $this->responseSuccess(
                $students,
                _lang('Students has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getClasses(): JsonResponse
    {
        try {
            $classes = $this->classService->getClasses();

            return $this->responseSuccess(
                $classes,
                _lang('Class has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getSections(): JsonResponse
    {
        try {
            $classes = $this->sectionService->getSections();

            return $this->responseSuccess(
                $classes,
                _lang('Sections has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getGroups(): JsonResponse
    {
        try {
            $studentGroups = StudentGroup::select('id', 'group_name')->get();

            return $this->responseSuccess(
                $studentGroups,
                _lang('Groups has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function classWiseSection(int $id): JsonResponse
    {
        try {
            $classes = Section::select('id', 'class_id', 'student_group_id', 'section_name')
                ->where('institute_id', get_institute_id())
                ->where('branch_id', get_branch_id())
                ->where('class_id', intval($id))
                ->get();

            return $this->responseSuccess(
                $classes,
                _lang('Class Wise Section has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function groupWiseSection(int $id): JsonResponse
    {
        try {
            $groups = Section::select('id', 'class_id', 'student_group_id', 'section_name')
                ->where('institute_id', get_institute_id())
                ->where('branch_id', get_branch_id())
                ->where('student_group_id', intval($id))
                ->get();

            return $this->responseSuccess(
                $groups,
                _lang('Group Wise Section has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getPeriods(): JsonResponse
    {
        try {
            $periods = Period::select('id', 'period', 'serial_no')
                ->where('institute_id', get_institute_id())
                ->where('branch_id', get_branch_id())
                ->get();

            return $this->responseSuccess(
                $periods,
                _lang('Periods has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getSubjects(): JsonResponse
    {
        try {
            $subjects = Subject::select('id', 'subject_name', 'subject_code', 'class_id', 'group_id')
                ->where('institute_id', get_institute_id())
                ->where('branch_id', get_branch_id())
                ->get();

            return $this->responseSuccess(
                $subjects,
                _lang('Subjects has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getClassWiseSubjects(int $id): JsonResponse
    {
        try {
            $subjects = Subject::select('id', 'subject_name', 'subject_code', 'class_id', 'group_id')
                ->where('institute_id', get_institute_id())
                ->where('branch_id', get_branch_id())
                ->where('class_id', intval($id))->get();

            return $this->responseSuccess(
                $subjects,
                _lang('Class wise subjects has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function getBooks(): JsonResponse
    {
        try {
            $books = Book::select('id', 'code', 'book_name', 'author', 'quantity')
                ->where('institute_id', get_institute_id())
                ->where('branch_id', get_branch_id())
                ->get();

            return $this->responseSuccess(
                $books,
                _lang('Books has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function atAGlance(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        try {
            $students = Student::query()
                ->select('students.*', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'student_groups.group_name')
                ->join('users', 'users.id', '=', 'students.user_id')
                ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
                ->leftJoin('classes', 'classes.id', '=', 'student_sessions.class_id')
                ->leftJoin('sections', 'sections.id', '=', 'student_sessions.section_id')
                ->leftJoin('student_groups', 'students.group', '=', 'student_groups.id')
                ->where('student_sessions.session_id', get_option('academic_year'))
                ->where('student_sessions.institute_id', get_institute_id())
                ->where('student_sessions.branch_id', get_branch_id())
                ->orderBy('student_sessions.roll', 'ASC')
                ->paginate($perPage);

            return $this->responseSuccess(
                $students,
                _lang('Students has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }
}
