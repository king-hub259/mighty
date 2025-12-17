<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class StudentSession extends Model
{
    use SoftDeletes;

    protected $table = 'student_sessions';

    protected $fillable = ['institute_id', 'branch_id', 'session_id', 'student_id', 'class_id', 'section_id', 'roll', 'qr_code', 'optional_subject'];

    public function student(): HasOne
    {
        return $this->hasOne(Student::class, 'id', 'student_id')
            ->select(
                'id',
                'user_id',
                'student_category_id',
                'group',
                'first_name',
                'last_name',
                'phone',
                'register_no',
                'father_name',
                'mother_name',
                'birthday',
                'gender',
                'blood_group',
                'religion',
                'address',
                'nationality',
                'birth_certificate_no',
                'nid_no',
                'date_of_admission',
                'tc_date',
            )
            ->with('user', 'studentGroup', 'studentCategory');
    }

    public function session(): HasOne
    {
        return $this->hasOne(AcademicYear::class, 'id', 'session_id');
    }

    public function class(): HasOne
    {
        return $this->hasOne(ClassModel::class, 'id', 'class_id');
    }

    public function section(): HasOne
    {
        return $this->hasOne(Section::class, 'id', 'section_id');
    }

    public function optionalSubjectData(): HasOne
    {
        return $this->hasOne(Subject::class, 'id', 'optional_subject');
    }
}
