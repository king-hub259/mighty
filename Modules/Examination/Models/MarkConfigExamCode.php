<?php

namespace Modules\Examination\Models;

use Illuminate\Database\Eloquent\Model;

class MarkConfigExamCode extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'session_id',
        'subject_id',
        'title',
        'total_marks',
        'pass_mark',
        'acceptance',
    ];
}
