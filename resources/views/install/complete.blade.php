@extends('install.layouts.master')

@section('title', _lang('install_complete'))
@section('container')
    <p class="paragraph mb-5">
        Installation completed successfully, you can login now with default login details.
        <br>Email: <strong>superadmin@gmail.com</strong>
        <br>Password: <strong>superadmin@1234</strong>
    </p>

    <div class="d-flex justify-content-center mb-4">
        <a href="{{ url('/') }}" class="btn btn-warning">
            {{ _lang('Home Page') }}
        </a>
    </div>
@endsection
