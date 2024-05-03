<?php

require 'Routing.php';


$path = trim($_SERVER['REQUEST_URI'], '/');
$path = parse_url($path, PHP_URL_PATH);

Router::get('', 'HomeController');
Router::get('no_access', 'HomeController');
Router::get('not_found', 'HomeController');

Router::get('login', 'SecurityController');
Router::get('register', 'SecurityController');

Router::post('login', 'SecurityController');
Router::post('register', 'SecurityController');

Router::run($path);