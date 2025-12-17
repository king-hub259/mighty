<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class AssignSubject extends Model
{
    protected $guarded = ['id'];

    public static function getSubjects($classId, $sectionId)
    {
        return self::whereHas('subject', function ($query) use ($classId) {
            $query->where('class_id', $classId);
        })
            ->where('section_id', $sectionId)
            ->get();
    }

    public function subject()
    {
        return $this->belongsTo(Subject::class, 'subject_id'); // Adjust foreign key if necessary
    }
}
