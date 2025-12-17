@extends('parentmodule::layouts.master')

@section('content')
    <h1>Hello World</h1>

    <p>Module: {!! config('parentmodule.name') !!}</p>
@endsection
