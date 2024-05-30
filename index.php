<?php

require_once 'Routing.php';


$path = trim($_SERVER['REQUEST_URI'], '/');
$path = parse_url($path, PHP_URL_PATH);


define('WORKOUT_CONTROLLER', 'WorkoutController');
define('HOME_CONTROLLER', 'HomeController');
define('AUTH_CONTROLLER', 'AuthController');
define('EXERCISE_CONTROLLER', 'ExerciseController');

// Home
Router::get('', WORKOUT_CONTROLLER);
Router::get('no_access', HOME_CONTROLLER);
Router::get('not_found', HOME_CONTROLLER);

// Auth
Router::get('login', AUTH_CONTROLLER);
Router::post('login', AUTH_CONTROLLER);
Router::get('register', AUTH_CONTROLLER);
Router::post('register', AUTH_CONTROLLER);
Router::post('logout', AUTH_CONTROLLER);

// Workouts
Router::get('get_categories', WORKOUT_CONTROLLER);
Router::get('get_exercises_by_category', WORKOUT_CONTROLLER);
Router::post('create_workout', WORKOUT_CONTROLLER);
Router::post('create_workout_day', WORKOUT_CONTROLLER);
Router::patch('update_workout', WORKOUT_CONTROLLER);
Router::delete('delete_workout', WORKOUT_CONTROLLER);

// Exercises
Router::get('exercises_base', EXERCISE_CONTROLLER);
Router::get('private_exercises', EXERCISE_CONTROLLER);
Router::get('search_exercises_base', EXERCISE_CONTROLLER);
Router::get('search_private_exercises', EXERCISE_CONTROLLER);
Router::post('create_exercise', EXERCISE_CONTROLLER);
Router::patch('update_exercise', EXERCISE_CONTROLLER);
Router::delete('delete_exercise', EXERCISE_CONTROLLER);
// Auth
Router::get('login', 'AuthController');
Router::post('login', 'AuthController');
Router::get('register', 'AuthController');
Router::post('register', 'AuthController');
Router::post('logout', 'AuthController');

// Workouts
Router::get('get_categories', 'WorkoutController');
Router::get('get_exercises_by_category', 'WorkoutController');
Router::post('create_workout', 'WorkoutController');
Router::post('create_workout_day', 'WorkoutController');
Router::patch('update_workout', 'WorkoutController');
Router::delete('delete_workout', 'WorkoutController');

// Exercises
Router::get('exercises_base', 'ExerciseController');
Router::get('private_exercises', 'ExerciseController');
Router::get('search_exercises_base', 'ExerciseController');
Router::get('search_private_exercises', 'ExerciseController');
Router::post('create_exercise', 'ExerciseController');
Router::patch('update_exercise', 'ExerciseController');
Router::delete('delete_exercise', 'ExerciseController');

Router::run($path);