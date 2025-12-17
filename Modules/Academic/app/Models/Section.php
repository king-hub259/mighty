<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Section extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'id',
        'section_name',
        'room_no',
        'class_id',
        'class_teacher_id',
        'status',
        'rank',
        'capacity',
    ];

    public function class(): BelongsTo
    {
        return $this->belongsTo(ClassModel::class, 'class_id', 'id');
    }

    public function students(): HasMany
    {
        return $this->hasMany(StudentSession::class, 'section_id');
    }

    public function group(): BelongsTo
    {
        return $this->belongsTo(StudentGroup::class, 'student_group_id');
    }
}
