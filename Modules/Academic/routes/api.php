<?php

use Illuminate\Support\Facades\Route;
use Modules\Academic\Http\Controllers\API\APIAcademicYearsController;
use Modules\Academic\Http\Controllers\API\APIAssignmentController;
use Modules\Academic\Http\Controllers\API\APIAttendanceController;
use Modules\Academic\Http\Controllers\API\APIClassController;
use Modules\Academic\Http\Controllers\API\APIClassRoutineController;
use Modules\Academic\Http\Controllers\API\APIDepartmentsController;
use Modules\Academic\Http\Controllers\API\APIEventController;
use Modules\Academic\Http\Controllers\API\APIGetAllIndex;
use Modules\Academic\Http\Controllers\API\APINoticeController;
use Modules\Academic\Http\Controllers\API\APIPeriodController;
use Modules\Academic\Http\Controllers\API\APIPicklistController;
use Modules\Academic\Http\Controllers\API\APISectionController;
use Modules\Academic\Http\Controllers\API\APIStaffController;
use Modules\Academic\Http\Controllers\API\APIStudentCategoriesController;
use Modules\Academic\Http\Controllers\API\APIStudentController;
use Modules\Academic\Http\Controllers\API\APIStudentGroupController;
use Modules\Academic\Http\Controllers\API\APISubjectController;
use Modules\Academic\Http\Controllers\API\APISyllabusController;
use Modules\Academic\Http\Controllers\API\APITeacherController;
use Modules\Academic\Http\Controllers\API\AssignShiftController;
use Modules\Academic\Http\Controllers\API\AssignSubjectController;
use Modules\Academic\Http\Controllers\API\ClassAssignController;
use Modules\Academic\Http\Controllers\API\ExamEssentialsController;
use Modules\Academic\Http\Controllers\API\ShiftController;
use Modules\Academic\Http\Controllers\API\SignatureController;
use Modules\Academic\Http\Controllers\API\StudentMigrationController;
use Modules\Academic\Http\Controllers\API\ZoomController;

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::controller(APIGetAllIndex::class)->group(function () {
        Route::get('get-classes', 'getClasses');
        Route::get('get-sections', 'getSections');
        Route::get('get-section/{class_id}', 'classWiseSection');
        Route::get('get-groups', 'getGroups');
        Route::get('get-group/{group_id}', 'groupWiseSection');
        Route::get('get-periods', 'getPeriods');
        Route::get('get-subjects', 'getSubjects');
        Route::get('get-subject/{class_id}', 'getClassWiseSubjects');
        Route::get('get-students', 'getStudentsByClassSectionGroup');
        Route::get('get-teachers', 'getTeachers');
        Route::get('get-staffs', 'getStaffs');
        Route::get('get-books', 'getBooks');
        Route::get('get-library-members', 'getLibraryMembers');
        Route::get('at-a-glance', 'atAGlance');
    });

    // Student Attendance routes
    Route::get('student-attendance', [APIAttendanceController::class, 'getStudentAttendance']);
    Route::post('student-attendance', [APIAttendanceController::class, 'studentAttendance']);
    Route::post('student-qr-code-attendance', [APIAttendanceController::class, 'studentQrCodeAttendance']);
    Route::post('staffs-attendance', [APIAttendanceController::class, 'staffAttendance']);
    Route::get('student-attendance-delete', [APIAttendanceController::class, 'studentAttendanceDelete']);
    Route::post('student-attendance-delete', [APIAttendanceController::class, 'studentAttendanceDelete']);
    Route::get('reports-student-attendance', [APIAttendanceController::class, 'studentAttendanceReport']);
    Route::get('reports-student-absent-fine', [APIAttendanceController::class, 'absentFineReport']);
    Route::get('reports-staffs-attendance', [APIAttendanceController::class, 'staffAttendanceReport']);

    // Assign Class
    Route::apiResource('assignments', APIAssignmentController::class);
    Route::apiResource('syllabus', APISyllabusController::class);

    //  Class - Section - Group Route Controller
    Route::apiResource('shifts', ShiftController::class);
    Route::apiResource('class', APIClassController::class);
    Route::apiResource('sections', APISectionController::class);
    Route::apiResource('groups', APIStudentGroupController::class);
    Route::apiResource('subjects', APISubjectController::class);
    Route::apiResource('periods', APIPeriodController::class);

    // Academic Configuration
    Route::apiResource('sessions', APIAcademicYearsController::class);
    Route::apiResource('departments', APIDepartmentsController::class);
    Route::apiResource('student-categories', APIStudentCategoriesController::class);

    // student migration
    Route::get('migrated-list', [StudentMigrationController::class, 'migratedList']);
    Route::get('students-get_students-migration', [StudentMigrationController::class, 'get_student_for_migration']);
    Route::apiResource('student-migration', StudentMigrationController::class);

    // Class Routine
    Route::get('class-routines', [APIClassRoutineController::class, 'index']);
    Route::post('class-routines', [APIClassRoutineController::class, 'store']);

    // Exam Routine
    Route::match(['get', 'post'], 'exam-routines/{type?}', [APIClassRoutineController::class, 'exam_schedule']);
    Route::post('exam-routines-store', [APIClassRoutineController::class, 'storeExamSchedule']);
    Route::apiResource('exam-essentials', ExamEssentialsController::class);

    // PickList Controller
    Route::apiResource('picklists', APIPicklistController::class);

    // Students CRUD
    Route::apiResource('students', APIStudentController::class);
    Route::get('students-status', [APIStudentController::class, 'updateStatus']);

    // Teachers CRUD
    Route::apiResource('teachers', APITeacherController::class);

    // Staff CRUD
    Route::apiResource('staffs', APIStaffController::class);

    // Notices & Events Setting
    Route::apiResource('notices', APINoticeController::class);
    Route::apiResource('events', APIEventController::class);

    // Principal Signature
    Route::apiResource('signatures', SignatureController::class);

    // Assign Shift
    Route::apiResource('assign-shifts', AssignShiftController::class);

    // Assign Class
    Route::apiResource('assign-classes', ClassAssignController::class);

    // Assign Subject Route
    Route::apiResource('assign-subjects', AssignSubjectController::class);

    // Zoom API
    Route::apiResource('zooms', ZoomController::class);
});
