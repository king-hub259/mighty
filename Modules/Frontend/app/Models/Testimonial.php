<?php

namespace Modules\Frontend\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Authentication\Models\User;

class Testimonial extends Model
{
    use HasFactory;

    protected $table = 'testimonials';

    public const TABLE_NAME = 'testimonials';

    protected $fillable = [
        'institute_id',
        'branch_id',
        'user_id',
        'description',
        'status',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id')->select('id', 'name', 'phone', 'email', 'image');
    }
}
