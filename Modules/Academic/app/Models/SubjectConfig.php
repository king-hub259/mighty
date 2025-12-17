<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SubjectConfig extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'class_id',
        'group_id',
        'subject_id',
        'subject_type',
        'sr_no',
        'merge_config_id',
    ];

    public function subject(): BelongsTo
    {
        return $this->belongsTo(Subject::class);
    }
}
