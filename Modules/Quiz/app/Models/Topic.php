<?php

namespace Modules\Quiz\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Modules\Quiz\Database\Factories\TopicFactory;

class Topic extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'title',
        'per_q_mark',
        'description',
        'timer',
        'show_ans',
        'amount',
    ];

    public function question(): HasOne
    {
        return $this->hasOne(Question::class);
    }

    public function questions()
    {
        return $this->hasMany(Question::class, 'topic_id');
    }

    public function answer(): HasOne
    {
        return $this->hasOne(Answer::class);
    }

    protected static function newFactory()
    {
        return TopicFactory::new();
    }
}
