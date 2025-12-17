<?php

namespace Modules\LayoutCert\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Academic\Models\Student;

class TransferCertificate extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'student_id',
        'reason',
        'issue_date',
        'left_date',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(Student::class)->with('studentSession', 'user');
    }
}
