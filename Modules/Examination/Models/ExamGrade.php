<?php

namespace Modules\Examination\Models;

use Illuminate\Database\Eloquent\Model;
use Modules\Academic\Models\ClassModel;

class ExamGrade extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'session_id',
        'class_model_id',
        'grade_id',
        'grade_name',
        'grade_number',
        'grade_point',
        'grade_range',
        'number_high',
        'number_low',
        'point_high',
        'point_low',
        'priority',
    ];

    public function class()
    {
        return $this->belongsTo(ClassModel::class, 'class_model_id', 'id');
    }

    public function grade()
    {
        return $this->belongsTo(Grade::class, 'grade_id', 'id');
    }
}
