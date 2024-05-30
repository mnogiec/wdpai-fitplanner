<?php

function redirect($url, $permanent = false)
{
  header('Location: ' . $url, true, $permanent ? 301 : 302);
  exit();
}

function env($key, $default = null)
{
  $env = parse_ini_file('.env');
  $value = $env[$key];

  if ($value === null) {
    return $default;
  }

  return $value;
}