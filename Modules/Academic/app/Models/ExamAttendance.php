<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class ExamAttendance extends Model
{
    protected $table = 'exam_attendances';

    protected $fillable = ['institute_id', 'branch_id', 'exam_id', 'subject_id', 'student_id', 'class_id', 'section_id', 'date', 'attendance'];
}
