<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Modules\Examination\Models\Grade;
use Modules\Examination\Models\ShortCode;

class ClassModel extends Model
{
    protected $table = 'classes';

    protected $fillable = ['institute_id', 'branch_id', 'class_name', 'status'];

    public function sections(): BelongsTo
    {
        return $this->belongsTo(StudentSession::class, 'id', 'class_id');
    }

    public function shortCodes(): BelongsToMany
    {
        return $this->belongsToMany(ShortCode::class, 'class_short_codes', 'class_model_id', 'short_code_id');
    }

    public function grades(): BelongsToMany
    {
        return $this->belongsToMany(Grade::class, 'class_grades', 'class_model_id', 'grade_id');
    }
}
