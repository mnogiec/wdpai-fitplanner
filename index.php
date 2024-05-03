<?php

require 'Routing.php';


$path = trim($_SERVER['REQUEST_URI'], '/');
$path = parse_url($path, PHP_URL_PATH);

Router::get('', 'HomeController');
Router::get('no_access', 'HomeController');
Router::get('not_found', 'HomeController');

Router::get('login', 'AuthController');
Router::get('register', 'AuthController');

Router::post('login', 'AuthController');
Router::post('logout', 'AuthController');
Router::post('register', 'AuthController');

Router::run($path);