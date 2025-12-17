<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class StudentCategory extends Model
{
    protected $fillable = ['institute_id', 'branch_id', 'name'];
}
