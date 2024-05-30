<?php

class WorkoutExercise
{
  private $id;
  private $exerciseId;
  private $workoutDayId;
  private $sets;
  private $reps;
  private $weight;
  private $Exercise;

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

  public function getId(): int
  {
    return $this->id;
  }

  public function getExerciseId(): int
  {
    return $this->exerciseId;
  }
  public function getExercise()
  {
    return $this->Exercise;
  }

  public function getWorkoutDayId(): int
  {
    return $this->workoutDayId;
  }

  public function getSets(): int
  {
    return $this->sets;
  }

  public function getReps(): int
  {
    return $this->reps;
  }

  public function getWeight(): float
  {
    return $this->weight;
  }
}