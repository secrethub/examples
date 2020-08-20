<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
<title>Hello World</title>
</head>
<body>
<h1> Username: {{ env('APP_USERNAME') }}</h1>
<h1> Password: {{ env('APP_PASSWORD') }}</h1>
</body>
</html>
