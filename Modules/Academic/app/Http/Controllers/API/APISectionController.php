<?php

namespace Modules\Academic\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Modules\Academic\Models\Section;

class APISectionController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $classId = (int) $request->class_id;

        $query = Section::select('sections.id AS id', 'sections.section_name', 'classes.class_name', 'student_groups.group_name', 'teachers.name as teacher_name')
            ->leftJoin('teachers', 'teachers.id', '=', 'sections.class_teacher_id')
            ->leftJoin('classes', 'classes.id', '=', 'sections.class_id')
            ->leftJoin('student_groups', 'sections.student_group_id', '=', 'student_groups.id');

        // Apply filter if class_id is provided
        if ($classId) {
            $query->where('sections.class_id', $classId);
        }

        $sections = $query->orderBy('sections.id', 'ASC')->paginate($perPage);

        return $this->responseSuccess($sections, 'Sections have been fetched successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'section_name' => 'required|string|max:191',
            'class_id' => 'required|exists:classes,id',
            'student_group_id' => 'required|exists:student_groups,id',
            'class_teacher_id' => 'nullable|string|max:191',
            'room_no' => 'nullable|string|max:191',
            'rank' => 'nullable|string|max:191',
        ]);

        $section = new Section;
        $section->institute_id = get_institute_id();
        $section->branch_id = get_branch_id();
        $section->section_name = $request->section_name;
        $section->class_id = (int) $request->class_id;
        $section->class_teacher_id = (int) $request->class_teacher_id;
        $section->room_no = $request->room_no;
        $section->rank = $request->rank;
        $section->capacity = $request->capacity;
        $section->student_group_id = (int) $request->student_group_id;
        $section->save();

        return $this->responseSuccess([], 'Sections has been added.');
    }

    public function show(int $id): JsonResponse
    {
        $section = Section::select('*', 'sections.id AS id')
            ->join('classes', 'classes.id', '=', 'sections.class_id')
            ->where('sections.id', $id)
            ->first();
        if (! $section) {
            return $this->responseError([], _lang('Something went wrong. Section can not be found.'), 404);
        }

        return $this->responseSuccess($section, 'Sections has been fetch.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'section_name' => 'required|string|max:191',
            'class_id' => 'required|exists:classes,id',
            'student_group_id' => 'required|exists:student_groups,id',
            'class_teacher_id' => [
                'nullable',
                Rule::unique('sections')->ignore($id),
            ],
        ]);

        $section = Section::find($id);
        if (! $section) {
            return $this->responseError([], _lang('Something went wrong. Section can not be found.'), 404);
        }

        $section->section_name = $request->section_name;
        $section->class_id = $request->class_id;
        $section->student_group_id = $request->student_group_id;
        $section->class_teacher_id = $request->class_teacher_id;
        $section->room_no = $request->room_no;
        $section->rank = $request->rank;
        $section->capacity = $request->capacity;
        $section->attendance_time_config_id = $request->attendance_time_config_id;
        $section->save();

        return $this->responseSuccess([], 'Sections has been updated.');
    }

    public function destroy(int $id): JsonResponse
    {
        $section = Section::find($id);
        if (! $section) {
            return $this->responseError([], _lang('Something went wrong. Section can not be found.'), 404);
        }
        if ($section->students) {
            return $this->responseError([], _lang('Section cannot be deleted because it has assigned students.'));
        }
        $section->delete();

        return $this->responseSuccess([], 'Sections has been deleted.');
    }
}
