<?php

require_once 'src/controllers/HomeController.php';
require_once 'src/controllers/SecurityController.php';

class Router
{
  public static $routes;

  public static function get($url, $view)
  {
    self::$routes[$url] = $view;
  }

  public static function post($url, $view)
  {
    self::$routes[$url] = $view;
  }

  public static function run($url)
  {

    $urlParts = explode("/", $url);
    $action = $urlParts[0];

    if (!array_key_exists($action, self::$routes)) {
      ob_start();
      include 'public/views/not_found.php';
      print ob_get_clean();
      return;
    }

    $controller = self::$routes[$action];
    $object = new $controller;
    $action = $action ?: 'index';

    $id = $urlParts[1] ?? '';

    $object->$action($id);
  }
}