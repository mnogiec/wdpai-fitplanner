<?php

class WorkoutDay
{
  private $id;
  private $date;
  private $userId;

  public function __construct(int $id, string $date, int $userId)
  {
    $this->id = $id;
    $this->date = $date;
    $this->userId = $userId;
  }

  public function getId(): int
  {
    return $this->id;
  }

  public function getDate(): string
  {
    return $this->date;
  }

  public function getUserId(): int
  {
    return $this->userId;
  }
}
