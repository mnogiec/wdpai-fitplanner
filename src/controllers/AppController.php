<?php

class AppController
{
  private $request;

  public function __construct()
  {
    $this->request = $_SERVER['REQUEST_METHOD'];
  }

  protected function isGet(): bool
  {
    return $this->request === 'GET';
  }

  protected function isPost(): bool
  {
    return $this->request === 'POST';
  }

  protected function isPatch(): bool
  {
    return $this->request === 'PATCH';
  }

  protected function isPut(): bool
  {
    return $this->request === 'PUT';
  }

  protected function isDelete(): bool
  {
    return $this->request === 'DELETE';
  }

  public function render(string $template = null, array $variables = [])
  {
    $templatePath = 'public/views/' . $template . '.php';

    if (!file_exists($templatePath)) {
      $templatePath = 'public/views/not_found.html';
    }

    extract($variables);

    ob_start();
    include $templatePath;
    print ob_get_clean();
  }
}