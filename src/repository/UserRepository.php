<?php

require_once 'Repository.php';
require_once __DIR__ . '/../models/User.php';

class UserRepository extends Repository
{
  public function getUser(int $id)
  {
    $query = $this->database->connect()->prepare('
      SELECT * FROM users WHERE id = :id
    ');
    $query->bindParam(':id', $id, PDO::PARAM_INT);
    $query->execute();

    return $query->fetch(PDO::FETCH_CLASS, User::class);
  }

  public function createUser($data)
  {
    $query = $this->database->connect()->prepare('
      INSERT INTO users (first_name, last_name, email, password)
      VALUES (?, ?, ?, ?)
    ');

    $query->execute([
      $data['firstName'],
      $data['lastName'],
      $data['email'],
      $data['password']
    ]);

    return;
  }
}