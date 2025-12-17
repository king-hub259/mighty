<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentMigration;
use Modules\Academic\Models\StudentSession;

class StudentMigrationController extends Controller
{
    public function get_student_for_migration(Request $request): JsonResponse
    {
        $classId = (int) $request->class_id;
        $sectionId = (int) $request->section_id;

        $students = Student::join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->select('students.*', 'student_sessions.roll')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('student_sessions.institute_id', get_institute_id())
            ->where('student_sessions.branch_id', get_branch_id())
            ->where('student_sessions.class_id', $classId)
            ->where('student_sessions.section_id', $sectionId)
            ->with('studentSession', 'studentGroup')
            ->get();

        return $this->responseSuccess($students, 'Get Student for migration.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'users' => 'required|array',
            'section_id' => 'required|exists:sections,id',
            'migrate_section_id' => 'required',
            'group_id' => 'required|exists:student_groups,id',
            'class_id' => 'required|array', // Ensure this is treated as an array
            'migrate_class_id' => 'required',
            'prev_roll' => 'required|array', // Ensure this is an array
            'new_roll' => 'required|array', // Ensure this is an array
            'type' => 'required|string',
            'academic_year' => 'required|numeric',
        ]);

        $studentIds = $request->users;
        $prev_class_id = $request->class_id; // Assuming this is an array
        $class_id = $request->migrate_class_id;
        $prev_section_id = $request->section_id;
        $section_id = $request->migrate_section_id;
        $group_id = $request->group_id;
        $type = $request->type;
        $prev_roll = $request->prev_roll;
        $new_roll = $request->new_roll;
        $academic_year = $request->academic_year;

        DB::beginTransaction();

        try {
            foreach ($studentIds as $key => $studentId) {
                // Ensure indexes exist before accessing array values
                $migrate = new StudentMigration;
                $migrate->student_id = $studentId;
                $migrate->prev_section_id = $prev_section_id;
                $migrate->section_id = $section_id;
                $migrate->group_id = $group_id;
                $migrate->prev_class_id = $prev_class_id[0] ?? null; // Handle single value as array
                $migrate->class_id = $class_id;
                $migrate->new_roll = $new_roll[$key] ?? null;
                $migrate->prev_roll = $prev_roll[$key] ?? null;
                $migrate->type = $type;
                $migrate->academic_year = $academic_year;
                $migrate->institute_id = get_institute_id();
                $migrate->branch_id = get_branch_id();
                $migrate->save();

                $student = Student::find((int) $studentId);
                if ($student) {
                    $session = StudentSession::find($student->studentSession?->id);
                    if ($session) {
                        $session->update([
                            'section_id' => $section_id,
                            'class_id' => $class_id,
                            'roll' => $new_roll[$key] ?? null,
                        ]);
                    }

                    $student->update([
                        'group' => $group_id,
                        'roll_no' => $new_roll[$key] ?? null,
                    ]);
                }
            }

            DB::commit();

            return $this->responseSuccess([], 'Migrate successfully.');
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function migratedList(Request $request): JsonResponse
    {
        $sectionId = intval($request->section_id);
        $academicYearId = intval($request->academic_year_id);
        $migratedLists = [];

        $migratedLists = StudentMigration::query()
            ->with('class', 'section')
            ->select(
                'students.*',
                'students.id as student_id',
                'student_migrations.*',
                'student_sessions.*',
            )
            ->leftJoin('students', 'students.id', '=', 'student_migrations.student_id')
            ->leftJoin('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->where('student_migrations.section_id', $sectionId)
            ->where('student_migrations.academic_year', $academicYearId)
            ->orderBy('student_sessions.roll', 'ASC')
            ->get();

        return $this->responseSuccess($migratedLists, 'Get Migration Students.');
    }
}
