<?php

require 'Routing.php';


$path = trim($_SERVER['REQUEST_URI'], '/');
$path = parse_url($path, PHP_URL_PATH);


// Home
Router::get('', 'WorkoutController');
Router::get('no_access', 'HomeController');
Router::get('not_found', 'HomeController');

// Auth
Router::get('login', 'AuthController');
Router::post('login', 'AuthController');
Router::get('register', 'AuthController');
Router::post('register', 'AuthController');
Router::post('logout', 'AuthController');

// Workouts
Router::post('createWorkout', 'WorkoutController');
Router::patch('updateWorkout', 'WorkoutController');
Router::delete('deleteWorkout', 'WorkoutController');

// Exercises
Router::get('exercises_base', 'ExerciseController');
Router::get('private_exercises', 'ExerciseController');
Router::post('create_private_exercise', 'ExerciseController');
Router::patch('update_private_exercise', 'ExerciseController');
Router::delete('delete_private_exercise', 'ExerciseController');

Router::run($path);