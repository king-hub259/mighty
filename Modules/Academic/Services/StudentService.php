<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Modules\Academic\Models\Student;
use Modules\Academic\Repositories\StudentRepository;

class StudentService
{
    public function __construct(
        private readonly StudentRepository $studentRepository
    ) {}

    public function getStudentsAll(): Collection
    {
        return $this->studentRepository->all();
    }

    public function getStudents(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->studentRepository->paginate($perPage, $filter);
    }

    public function findStudentById(int $id): ?Student
    {
        return $this->studentRepository->show((int) $id) ?? null;
    }

    public function createStudent(array $data, $userId = null): ?Student
    {
        $data['user_id'] = intval($userId);
        $data['institute_id'] = get_institute_id();
        $data['branch_id'] = get_branch_id();

        return $this->studentRepository->create($data);
    }

    public function updateStudent(array $data, int $id): mixed
    {
        return $this->studentRepository->update($data, (int) $id);
    }

    public function deleteStudentById(int $id): int
    {
        return $this->studentRepository->delete((int) $id);
    }

    public function getStudentsByClassSectionGroup($classId = null, $sectionId = null, $groupId = null, $perPage = 200)
    {
        $query = Student::query()
            ->select('users.id', 'users.name', 'users.email', 'users.phone', 'users.image', 'users.role_id', 'users.status', 'users.user_status', 'users.user_type', 'student_sessions.roll', 'classes.class_name', 'sections.section_name', 'students.id as id', 'student_groups.group_name', 'students.user_id', 'students.gender', 'students.religion', 'students.status as student_status')

            ->leftJoin('users', 'users.id', '=', 'students.user_id')
            ->leftJoin('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->leftJoin('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->leftJoin('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->leftJoin('student_groups', 'students.group', '=', 'student_groups.id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('users.user_type', 'Student')
            ->where('student_sessions.class_id', $classId)
            ->orderBy('student_sessions.roll', 'ASC');

        if ($sectionId > 0) {
            $query->where('student_sessions.section_id', $sectionId);
        }

        if ($groupId > 0) {
            $query->where('students.group', $groupId);
        }

        return $query->get();
    }

    public function getStudentById($id): ?Student
    {
        return Student::join('users', 'users.id', '=', 'students.user_id')
            ->where('students.id', $id)
            ->select('users.*', 'students.id as studentId')
            ->first();
    }
}
