<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class Notice extends Model
{
    protected $table = 'notices';

    protected $fillable = ['institute_id', 'branch_id', 'title', 'notice', 'date', 'image', 'created_by'];

    public function userType()
    {
        return $this->hasMany(UserNotice::class, 'notice_id', 'id');
    }
}
