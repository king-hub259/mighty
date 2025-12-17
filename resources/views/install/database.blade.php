@extends('install.layouts.master')

@section('title', _lang('install_database'))
@section('container')
    <form action="{{ url('install/database') }}" method="POST" name="form" enctype="multipart/form-data">
        @csrf

        @if ($errors->any())
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <div class="form-group">
            <label for="software_name">{{ _lang('Software Name') }}</label>
            <input type="text" name="software_name" id="software_name" class="form-control"
                value="{{ old('software_name') }}" placeholder="Software Name" required>
        </div>

        <div class="form-group">
            <label for="host">{{ _lang('install_host') }}</label>
            <input type="text" name="host" id="host" class="form-control" value="127.0.0.1" required>
        </div>

        <div class="form-group">
            <label for="username">{{ _lang('install_username') }}</label>
            <input type="text" name="username" id="username" value="{{ old('username') }}" class="form-control"
                required>
        </div>

        <div class="form-group">
            <label for="password">{{ _lang('install_password') }}</label>
            <input type="password" name="password" id="password" value="{{ old('password') }}" class="form-control">
        </div>

        <div class="form-group">
            <label for="name">{{ _lang('install_name') }}</label>
            <input type="text" name="name" id="name" class="form-control" value="{{ old('name') }}" required>
        </div>

        <div class="form-group">
            <label for="port">{{ _lang('install_port') }}</label>
            <input type="number" name="port" id="port" class="form-control" value="3306" required>
        </div>

        <div class="form-group">
            <button type="submit" class="btn pull-right">{{ _lang('install_next') }}</button>
        </div>
    </form>
@endsection
