<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class ClassDay extends Model
{
    protected $fillable = ['institute_id', 'branch_id', 'day', 'is_active'];

    protected $table = 'class_days';
}
