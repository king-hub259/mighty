<?php

namespace Modules\LayoutCert\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Academic\Models\Student;

class Testimonial extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'exam_name',
        'board_name',
        'issue_date',
        'passing_year',
        'session',
        'board_roll_no',
        'board_reg_no',
        'gpa',
        'grade',
        'student_id',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(Student::class, 'student_id');
    }
}
