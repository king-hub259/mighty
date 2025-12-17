<?php

namespace Modules\Frontend\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

// use Modules\Frontend\Database\Factories\PageFactory;

class Page extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'institute_id',
        'branch_id',
        'branch_id',
        'title',
        'slug',
        'type',
        'content',
        'meta_data',
        'seo_meta_keywords',
        'seo_meta_description',
        'page_status',
        'page_template',
        'author_id',
    ];

    // protected static function newFactory(): PageFactory
    // {
    //     // return PageFactory::new();
    // }
}
