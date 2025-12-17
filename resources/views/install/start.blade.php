@extends('install.layouts.master')
@section('title', _lang('start_install'))
@section('container')
    <div class="form-group">
        <h1 class="header_one">Mighty School Software Installation
        </h1>
        <hr>
        <p class="paragraph_justify">
            Please proceed step by step with proper data according to instructions</p>
        <p class="paragraph_justify">
            Before starting the installation process please collect this
            information. Without this information, you won’t be able to complete the installation process.
        </p>
        <div class="info-box">
            <ul class="info-box_ul">
                <li>
                    <strong> <span class="text-danger">Required *</span> </strong>
                </li>
                <li>
                    <strong> <span class="text_color"> Host Name </span> </strong>
                </li>
                <li>
                    <strong> <span class="text_color"> Database Name </span> </strong>
                </li>
                <li>
                    <strong> <span class="text_color"> Database Username </span> </strong>
                </li>
                <li>
                    <strong> <span class="text_color"> Database Password </span> </strong>
                </li>
            </ul>
        </div>
        <a href="{{ url('install/requirements') }}" class="btn pull-right">{{ _lang('install_next') }}</a>
    </div>
@endsection
