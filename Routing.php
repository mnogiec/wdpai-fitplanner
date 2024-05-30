<?php

require_once 'src/controllers/HomeController.php';
require_once 'src/controllers/AuthController.php';
require_once 'src/controllers/WorkoutController.php';
require_once 'src/controllers/ExerciseController.php';

class Router
{
  public static $routes = [
    'GET' => [],
    'POST' => [],
    'PUT' => [],
    'PATCH' => [],
    'DELETE' => [],
  ];

  public static function get($url, $controller)
  {
    self::$routes['GET'][$url] = $controller;
  }

  public static function post($url, $controller)
  {
    self::$routes['POST'][$url] = $controller;
  }

  public static function put($url, $controller)
  {
    self::$routes['PUT'][$url] = $controller;
  }

  public static function patch($url, $controller)
  {
    self::$routes['PATCH'][$url] = $controller;
  }

  public static function delete($url, $controller)
  {
    self::$routes['DELETE'][$url] = $controller;
  }

  public static function run($url)
  {
    $method = $_SERVER['REQUEST_METHOD'];
    $urlParts = explode("/", $url);
    $action = $urlParts[0];

    if (!array_key_exists($action, self::$routes[$method])) {
      ob_start();
      include 'public/views/not_found.php';
      print ob_get_clean();
      return;
    }

    $controller = self::$routes[$method][$action];
    $object = new $controller;
    $actionMethod = $action ?: 'index';

    if (!method_exists($object, $actionMethod)) {
      ob_start();
      include 'public/views/not_found.php';
      print ob_get_clean();
      return;
    }

    $id = $urlParts[1] ?? '';
    $object->$actionMethod($id);
  }
}
