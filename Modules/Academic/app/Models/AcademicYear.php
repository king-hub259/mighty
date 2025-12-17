<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class AcademicYear extends Model
{
    protected $table = 'academic_years';

    protected $fillable = ['session', 'year'];
}
