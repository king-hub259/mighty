<?php

namespace Modules\Examination\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Academic\Models\ClassModel;
use Modules\Academic\Models\Exam;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\StudentGroup;
use Modules\Academic\Models\Subject;

class ExamMark extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'session_id',
        'student_id',
        'class_id',
        'group_id',
        'subject_id',
        'exam_id',
        'mark1',
        'mark2',
        'mark3',
        'mark4',
        'mark5',
        'mark6',
        'total_marks',
        'grade',
        'grade_point',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(Student::class)->with('studentSession')->select('id', 'group', 'first_name', 'last_name');
    }

    public function class(): BelongsTo
    {
        return $this->belongsTo(ClassModel::class, 'class_id', 'id')->select('id', 'class_name');
    }

    public function group(): BelongsTo
    {
        return $this->belongsTo(StudentGroup::class, 'group_id')->select('id', 'group_name');
    }

    public function subject(): BelongsTo
    {
        return $this->belongsTo(Subject::class)->select('id', 'subject_name');
    }

    public function exam(): BelongsTo
    {
        return $this->belongsTo(Exam::class)->select('id', 'session_id', 'name');
    }
}
