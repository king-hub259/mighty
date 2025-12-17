<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class Department extends Model
{
    protected $table = 'departments';

    protected $fillable = [
        'institute_id',
        'branch_id',
        'department_name',
        'slug',
        'priority',
    ];
}
