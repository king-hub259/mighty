<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\StudentCollectionTrait;
use App\Traits\Trackable;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Http\Requests\StudentCreateRequest;
use Modules\Academic\Http\Requests\StudentUpdateRequest;
use Modules\Academic\Models\LibraryMember;
use Modules\Academic\Services\StudentService;
use Modules\Academic\Services\StudentSessionService;
use Modules\Academic\Services\UserService;

class APIStudentController extends Controller
{
    use StudentCollectionTrait, Trackable;

    public function __construct(
        private readonly UserService $userService,
        private readonly StudentService $studentService,
        private readonly StudentSessionService $studentSessionService
    ) {}

    public function index(Request $request): JsonResponse
    {
        $class_id = (int) request()->class_id;
        $section_id = (int) request()->section_id;
        $group_id = (int) request()->group_id;
        $perPage = (int) request()->per_page;

        $students = $this->studentService->getStudentsByClassSectionGroup($class_id, $section_id, $group_id, $perPage);
        if (! $students) {
            return $this->responseError([], _lang('Students not found.'), 404);
        }

        return $this->responseSuccess($students, 'Students have been fetched successfully.');
    }

    public function store(StudentCreateRequest $request): JsonResponse
    {
        try {
            DB::beginTransaction();
            $password = '123456';

            $user = $this->userService->createOrUpdateUser([
                'name' => $request->first_name,
                'email' => $request->email, // Fixed issue, previously set as roll
                'phone' => $request->phone,
                'password' => $request->password ?? $password,
                'role_id' => 4,
                'status' => 1,
                'image' => $request->hasFile('image') ? $request->file('image')->store('uploads/students') : null,
                'user_type' => 'Student',
            ]);

            $student = $this->studentService->createStudent([
                'user_id' => $user->id,
                'first_name' => $request->first_name,
                'last_name' => $request->last_name ?? null,
                'father_name' => $request->father_name ?? null,
                'mother_name' => $request->mother_name ?? null,
                'birthday' => $request->birthday ?? null,
                'gender' => $request->gender ?? null,
                'blood_group' => $request->blood_group ?? null,
                'religion' => $request->religion ?? null,
                'phone' => $request->phone,
                'register_no' => intval($request->register_no ?? 0),
                'roll' => intval($request->roll),
                'address' => $request->address ?? null,
                'group' => $request->group ?? null,
                'access_key' => $request->password ?? $password,
                'information_sent_to_name' => $request->information_sent_to_name ?? null,
                'information_sent_to_relation' => $request->information_sent_to_relation ?? null,
                'information_sent_to_phone' => $request->information_sent_to_phone ?? null,
                'information_sent_to_address' => $request->information_sent_to_address ?? null,
            ], $user->id);

            $sessionData = [
                'session_id' => get_option('academic_year'),
                'student_id' => intval($student->id),
                'class_id' => intval($request->class_id),
                'section_id' => intval($request->section_id),
                'roll' => intval($request->roll),
                'qr_code' => str_pad(random_int(0, 9999999999999999), 16, '0', STR_PAD_LEFT),
            ];
            $this->studentSessionService->createStudentSession($sessionData);

            // Library Membership
            LibraryMember::create([
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'user_id' => $user->id,
                'member_type' => 'Student',
                'library_id' => intval($request->roll),
                'student_id' => $student->id,
            ]);

            DB::commit();

            return $this->responseSuccess($student, 'Student has been created successfully.');
        } catch (Exception $e) {
            DB::rollback();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function show(int $id): JsonResponse
    {
        $student = $this->studentService->findStudentById((int) $id);
        if (! $student) {
            return $this->responseError([], _lang('Student not found.'), 404);
        }

        return $this->responseSuccess($student, 'Student have been fetched successfully.');
    }

    public function update(StudentUpdateRequest $request, $id): JsonResponse
    {
        $student = $this->studentService->findStudentById((int) $id);
        if (! $student) {
            return $this->responseError([], _lang('Student not found.'), 404);
        }

        try {
            DB::beginTransaction();
            $password = '123456';

            $user = $this->userService->createOrUpdateUser([
                'name' => $request->first_name,
                'email' => $request->email,
                'phone' => $request->phone,
                'password' => $request->password ?? $password,
                'user_type' => 'Student',
                'role_id' => 4, // ✅ FIXED: Ensure role_id is included
                'status' => 1, // Ensure user is active
                'image' => $request->hasFile('image') ? $request->file('image')->store('uploads/students') : $student->user->image,
            ], (int) $student->user_id);

            // ✅ Update Student information.
            $this->studentService->updateStudent([
                'user_id' => $user->id,
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'father_name' => $request->father_name,
                'mother_name' => $request->mother_name,
                'birthday' => $request->birthday,
                'gender' => $request->gender,
                'blood_group' => $request->blood_group,
                'religion' => $request->religion,
                'phone' => $request->phone,
                'register_no' => intval($request->register_no ?? 0),
                'roll' => intval($request->roll),
                'address' => $request->address,
                'group' => $request->group,
                'access_key' => $request->password ?? $password,
            ], (int) $student->id);

            // ✅ Update or Create Library Membership
            LibraryMember::updateOrCreate(
                ['user_id' => $user->id, 'student_id' => $student->id],
                ['library_id' => intval($request->roll)]
            );

            // ✅ Update Student Session
            $studentSession = $this->studentSessionService->findStudentSessionByStudentId((int) $student->id);
            $sessionData = [
                'class_id' => intval($request->class_id),
                'section_id' => intval($request->section_id),
                'roll' => intval($request->roll),
                'qr_code' => str_pad(random_int(0, 9999999999999999), 16, '0', STR_PAD_LEFT),
            ];
            if ($studentSession) {
                $this->studentSessionService->updateStudentSession($sessionData, $studentSession->id);
            }

            DB::commit();

            return $this->responseSuccess($student, 'Student has been updated successfully.');
        } catch (Exception $e) {
            DB::rollback();

            return $this->responseError([], $e->getMessage());
        }
    }

    public function destroy(int $id): JsonResponse
    {
        try {
            return DB::transaction(function () use ($id) {
                $student = $this->studentService->findStudentById(intval($id));

                // Check if student exists
                if (! $student) {
                    throw new Exception('Student not found.');
                }

                // Delete student session only if it exists
                if (! empty($student->studentSession)) {
                    $this->studentSessionService->deleteStudentSessionById($student->studentSession->id);
                }

                // Delete user if exists
                if (! empty($student->user_id)) {
                    $this->userService->deleteUserById(intval($student->user_id));
                }

                // Delete student record
                $this->studentService->deleteStudentById(intval($student->id));

                return $this->responseSuccess([], 'Student has been deleted successfully.');
            });
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function updateStatus(Request $request): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|integer',
            'type' => 'required|string|in:enable,disable', // Accepts only "enable" or "disable"
        ]);

        $student = $this->studentService->findStudentById((int) $request->student_id);
        if (! $student) {
            return $this->responseError([], 'Student Not Found', 404);
        }

        // Determine the status based on the type
        $status = $request->type === 'enable' ? '1' : '0';

        // Update student status
        $student->update(['status' => $status]);

        // Update associated user status
        $user = $this->userService->findUserById((int) $student->user_id);
        if ($user) {
            $user->update(['user_status' => $status]);
        }

        $message = $request->type === 'enable'
            ? 'Student has been enabled successfully.'
            : 'Student has been disabled successfully.';

        return $this->responseSuccess([], $message);
    }

    public function multipleDelete(Request $request): JsonResponse
    {
        $request->validate([
            'student_ids' => 'required|array|min:1',
            'student_ids.*' => 'integer|exists:students,id',
        ]);

        foreach ($request->student_ids as $key => $student_id) {
            DB::transaction(function () use ($student_id) {
                $student = $this->studentService->findStudentById(intval($student_id));
                $this->studentSessionService->deleteStudentSessionById($student->studentSession->id);
                $this->userService->deleteUserById(intval($student->user_id));
                $this->studentService->deleteStudentById(intval($student->id));
            });
        }

        return $this->responseSuccess([], 'Students have been deleted successfully.');
    }
}
