<?php

class User
{
  private $id;
  private $firstName;
  private $lastName;
  private $email;
  private $password;
  private $createdAt;
  private $isAdmin;

  public function __construct(int $id, string $firstName, string $lastName, string $email, string $password, string $createdAt, bool $isAdmin)
  {
    $this->id = $id;
    $this->firstName = $firstName;
    $this->lastName = $lastName;
    $this->email = $email;
    $this->password = $password;
    $this->createdAt = $createdAt;
    $this->isAdmin = $isAdmin;
  }

  public function getId(): int
  {
    return $this->id;
  }

  public function getFirstName(): string
  {
    return $this->firstName;
  }

  public function getLastName(): string
  {
    return $this->lastName;
  }

  public function getEmail(): string
  {
    return $this->email;
  }

  public function getPassword(): string
  {
    return $this->password;
  }

  public function getCreatedAt(): string
  {
    return $this->createdAt;
  }

  public function isAdmin(): bool
  {
    return $this->isAdmin;
  }
}
