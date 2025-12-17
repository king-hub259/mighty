<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>{{ env('APP_NAME', 'School Software') }}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 flex items-center justify-center h-screen text-center">

    <div>
        <h1 class="text-4xl font-bold text-gray-800">Welcome to {{ env('APP_NAME', 'School Software') }}</h1>
        <p class="text-lg text-gray-600 mt-4">Powered by {{ env('APP_NAME', 'School Software') }}</p>
    </div>

</body>

</html>
