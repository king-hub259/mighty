<?php

namespace App\Http\Controllers;

class LanguageController extends Controller
{
    public function index($lang)
    {
        if ($lang != 'bn' && $lang != 'en') {
            abort(404);
        }
        app()->setLocale($lang);
        session()->put('locale', $lang);

        return back();
    }
}
