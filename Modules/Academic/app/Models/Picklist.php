<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class Picklist extends Model
{
    protected $guarded = ['id'];

    protected $table = 'picklists';
}
