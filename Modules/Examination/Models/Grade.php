<?php

namespace Modules\Examination\Models;

use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    protected $table = 'grades';

    protected $fillable =
        [
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
}
