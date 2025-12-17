<?php

namespace Modules\LayoutCert\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\StudentSession;

class LayoutCertController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $type = $request->type;
        $roll = (int) $request->roll;
        $class_id = $request->class_id;
        $section_id = $request->section_id;

        // Define allowed types
        $allowedTypes = [
            'general-certificate',
            'testimonial',
            'attendance-certificate',
            'transfer-certificate',
            'hsc-recommendation',
            'abroad-recommendation',
        ];

        // Validate type
        if (! in_array($type, $allowedTypes)) {
            return response()->json([
                'status' => false,
                'message' => 'Invalid certificate type.',
            ], 400);
        }

        // Query the student based on roll, class_id, and section_id
        $studentSession = StudentSession::where('roll', $roll)
            ->where('class_id', $class_id)
            ->where('section_id', $section_id)
            ->with('student', 'session', 'class', 'section')
            ->first();

        if (! $studentSession) {
            return response()->json([
                'status' => false,
                'message' => 'No student found.',
            ], 404);
        }

        // Return the data as JSON
        return response()->json([
            'status' => true,
            'message' => 'Student data retrieved successfully.',
            'data' => [
                'type' => $type,
                'student_session' => $studentSession,
            ],
        ]);
    }
}
