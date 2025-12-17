<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Support\Facades\DB;

class ClassRoutine extends Model
{
    protected $table = 'class_routines';

    protected $guarded = ['id'];

    public static function RoutineList($class_id = null)
    {
        $query = DB::table('classes')
            ->join('sections', 'classes.id', '=', 'sections.class_id')
            ->leftJoin('class_routines', 'sections.id', '=', 'class_routines.section_id')
            ->select('classes.class_name', 'sections.section_name', 'classes.id as c_id', 'sections.id as s_id', DB::raw('GROUP_CONCAT(class_routines.id) as r_ids'))
            ->when($class_id, function ($query) use ($class_id) {
                return $query->where('classes.id', $class_id);
            })
            ->groupBy('sections.id')
            ->get();

        return $query;
    }

    public static function getRoutine($class = null, $section = null)
    {
        $subjects = DB::table('class_days')
            ->join('subjects', 'class_days.is_active', '=', DB::raw('1'))
            ->where('subjects.class_id', $class)
            ->select('class_days.id as class_day_id', 'class_days.day as class_day', 'subjects.id as s_id', 'subjects.subject_name')
            ->get();

        $routines = [];

        foreach ($subjects as $subject) {
            $routine = DB::table('class_routines')
                ->where('subject_id', $subject->s_id)
                ->where('day', $subject->class_day)
                ->where('section_id', $section)
                ->first();

            $routines[$subject->class_day][$subject->s_id] = [
                'subject' => $subject,
                'routine' => $routine,
            ];
        }

        return $routines; // This will be an array of routines
    }

    public static function getRoutineView($class = '', $section = '')
    {
        $class = sql_escape($class);
        $section = sql_escape($section);

        $subjects = DB::select("
            SELECT subject.*, class_routines.*, teachers.name as teacher_name
            FROM (
                SELECT class_days.id as class_day_id, class_days.day as class_day, subjects.id as s_id, subjects.subject_name
                FROM class_days
                JOIN subjects
                WHERE class_days.is_active = 1 AND subjects.class_id = '$class'
            ) as subject
            LEFT JOIN class_routines
                ON subject.s_id = class_routines.subject_id
                AND subject.class_day = class_routines.day
                AND class_routines.section_id = '$section'
            LEFT JOIN teachers
                ON class_routines.teacher_id = teachers.id
            ORDER BY subject.class_day_id, subject.s_id
        ");

        // Initialize the routines array
        $routines = [];

        // Loop through subjects and group by class_day
        foreach ($subjects as $subject) {
            // Ensure each day has its array initialized
            if (! isset($routines[$subject->class_day])) {
                $routines[$subject->class_day] = [];
            }

            // Add subjects to the day's routine with a numeric index
            $routines[$subject->class_day][] = $subject;
        }

        return $routines;
    }

    public static function getTeacherRoutine($teacher_id = '')
    {
        $teacher_id = sql_escape($teacher_id);

        $teacherRoutine = DB::table('class_routines')
            ->select('subjects.subject_name', 'teachers.name as teacher_name', 'class_routines.*', 'sections.id', 'sections.section_name', 'classes.id', 'classes.class_name')
            ->join('subjects', 'class_routines.subject_id', '=', 'subjects.id')
            ->join('teachers', 'class_routines.teacher_id', '=', 'teachers.id')
            ->leftJoin('sections', 'class_routines.section_id', '=', 'sections.id')
            ->leftJoin('classes', 'sections.class_id', '=', 'classes.id')
            ->where('class_routines.teacher_id', $teacher_id)
            ->orderBy('class_routines.start_time')
            ->get();

        // Group the routines by day
        $groupedRoutine = [];
        foreach ($teacherRoutine as $routine) {
            $day = $routine->day;
            if (! isset($groupedRoutine[$day])) {
                $groupedRoutine[$day] = [];
            }
            $groupedRoutine[$day][] = $routine;
        }

        return $groupedRoutine;
    }

    public function section(): BelongsTo
    {
        return $this->belongsTo(Section::class, 'section_id', 'id')->with('class');
    }

    public function subject(): BelongsTo
    {
        return $this->belongsTo(Subject::class, 'subject_id', 'id');
    }

    public function teacher(): HasOne
    {
        return $this->hasOne(Teacher::class, 'teacher_id', 'id');
    }
}
