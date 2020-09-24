<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
<title>Hello World</title>
</head>
<body>
<?php
if ($_ENV["DEMO_USERNAME"] != "" && $_ENV["DEMO_PASSWORD"] != "") {
    echo  "Welcome " . $_ENV["DEMO_USERNAME"];
}
else {
    echo "The DEMO_USERNAME or DEMO_PASSWORD environment variable is not set.";
}
?>
</body>
</html>
