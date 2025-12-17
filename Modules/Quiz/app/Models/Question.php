<?php

namespace Modules\Quiz\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Modules\Quiz\Database\Factories\QuestionFactory;

class Question extends Model
{
    use HasFactory;

    protected $fillable = [
        'institute_id',
        'branch_id',
        'topic_id',
        'question',
        'a',
        'b',
        'c',
        'd',
        'answer',
        'code_snippet',
        'answer_exp',
        'question_img',
        'question_video_link',
    ];

    public function answers(): HasOne
    {
        return $this->hasOne(Answer::class);
    }

    public function topic(): BelongsTo
    {
        return $this->belongsTo(Topic::class);
    }

    protected static function newFactory()
    {
        return QuestionFactory::new();
    }
}
