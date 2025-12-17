<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class StudentGroup extends Model
{
    protected $table = 'student_groups';

    protected $guarded = ['id'];

    public function sections(): HasMany
    {
        return $this->hasMany(Section::class, 'id', 'section_id');
    }
}
