@extends('install.layouts.master')

@section('title', _lang('install_requirements'))
@section('container')
    <ul class="list-group">
        @foreach ($requirements as $extention => $enabled)
            <li class="list-group-item">
                {{ $extention }}
                @if ($enabled)
                    <span class="badge badge1"><i class="fa fa-check"></i></span>
                @else
                    <span class="badge badge2"><i class="fa fa-times"></i></span>
                @endif
            </li>
        @endforeach
    </ul>

    <div class="form-group">
        @if ($next)
            <a href="{{ url('install/permissions') }}" class="btn pull-right">{{ _lang('install_next') }}</a>
        @else
            <div class="alert alert-danger">{{ _lang('install_check') }}</div>
            <a class="btn pull-right" href="{{ Request::url() }}">
                {{ _lang('refresh') }}
                <i class="fa fa-refresh"></i></a>
        @endif
    </div>
@endsection
