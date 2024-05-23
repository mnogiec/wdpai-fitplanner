<?php

class WorkoutExercise
{
  public $id;
  public $exerciseId;
  public $workoutDayId;
  public $sets;
  public $reps;
  public $weight;
  public $Exercise;

  public function __construct($id, $exerciseId, $workoutDayId, $sets, $reps, $weight, $exercise = null)
  {
    $this->id = $id;
    $this->exerciseId = $exerciseId;
    $this->workoutDayId = $workoutDayId;
    $this->sets = $sets;
    $this->reps = $reps;
    $this->weight = $weight;
    $this->Exercise = $exercise;
  }

  public function getId()
  {
    return $this->id;
  }

  public function getExerciseId()
  {
    return $this->exerciseId;
  }
  public function getExercise()
  {
    return $this->Exercise;
  }

  public function getWorkoutDayId()
  {
    return $this->workoutDayId;
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