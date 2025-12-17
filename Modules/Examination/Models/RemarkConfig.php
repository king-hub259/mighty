<?php

namespace Modules\Examination\Models;

use Illuminate\Database\Eloquent\Model;

class RemarkConfig extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'remark_title',
        'remarks',
    ];
}
