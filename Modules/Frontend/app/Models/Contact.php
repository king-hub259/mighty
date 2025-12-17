<?php

namespace Modules\Frontend\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contact extends Model
{
    use HasFactory;

    protected $table = 'frontend_contacts';

    public const TABLE_NAME = 'frontend_contacts';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'branch_id',
        'institute_id',
        'name',
        'phone',
        'email',
        'subject',
        'message',
    ];
}
