<?php

class WorkoutDay
{
  public $id;
  public $date;
  public $userId;

  public function __construct($id, $date, $userId)
  {
    $this->id = $id;
    $this->date = $date;
    $this->userId = $userId;
  }

  public function getId()
  {
    return $this->id;
  }

  public function getDate()
  {
    return $this->date;
  }

  public function getUserId()
  {
    return $this->userId;
  }
}