<?php

class Workout
{
  public $id;
  public $exerciseId;
  public $userId;
  public $date;
  public $sets;
  public $reps;
  public $weight;

  public function __construct($id, $exerciseId, $userId, $date, $sets, $reps, $weight)
  {
    $this->id = $id;
    $this->exerciseId = $exerciseId;
    $this->userId = $userId;
    $this->date = $date;
    $this->sets = $sets;
    $this->reps = $reps;
    $this->weight = $weight;
  }

  public function getId()
  {
    return $this->id;
  }

  public function getExerciseId()
  {
    return $this->exerciseId;
  }

  public function getUserId()
  {
    return $this->userId;
  }

  public function getDate()
  {
    return $this->date;
  }

  public function getSets()
  {
    return $this->sets;
  }

  public function getReps()
  {
    return $this->reps;
  }

  public function getWeight()
  {
    return $this->weight;
  }
}