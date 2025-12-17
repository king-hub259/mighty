<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class ExamSchedule extends Model
{
    protected $guarded = ['id'];

    protected $table = 'exam_schedules';
}
