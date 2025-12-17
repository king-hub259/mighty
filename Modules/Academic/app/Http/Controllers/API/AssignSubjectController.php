<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\AssignSubject;

class AssignSubjectController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $request->validate([
            'class_id' => 'required|exists:classes,id',
            'section_id' => 'required|exists:sections,id',
        ]);

        $sectionId = (int) $request->section_id;
        $classId = (int) $request->class_id;

        // Corrected method call
        $subjects = AssignSubject::getSubjects($classId, $sectionId);

        return $this->responseSuccess($subjects, 'Subjects search successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'teacher_id' => 'required|array',
            'teacher_id.*' => 'required|exists:teachers,id',
            'subject_id' => 'required|array',
            'subject_id.*' => 'required|exists:subjects,id',
            'section_id' => 'required|array',
            'section_id.*' => 'required|exists:sections,id',
        ]);

        $data = [];
        for ($i = 0; $i < count($request->teacher_id); $i++) {
            $data[] = [
                'id' => $request->a_id[$i] ?? null,
                'institute_id' => get_institute_id(),
                'branch_id' => get_branch_id(),
                'subject_id' => $request->subject_id[$i],
                'teacher_id' => $request->teacher_id[$i],
                'section_id' => $request->section_id[$i],
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ];
        }

        // Use batch processing for better performance
        foreach ($data as $item) {
            AssignSubject::updateOrCreate(
                ['id' => $item['id']],
                $item
            );
        }

        return response()->json([
            'success' => true,
            'message' => 'Subjects assigned successfully.',
        ], 201);
    }
}
