<?php

require_once 'Repository.php';
require_once __DIR__ . '/../models/ExerciseCategory.php';

class ExerciseCategoryRepository extends Repository
{
  public function getAllExerciseCategories()
  {
    $query = $this->database->connect()->prepare(
      'SELECT * FROM exercise_categories'
    );
    $query->execute();
    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $exercises = [];
    foreach ($result as $row) {
      $exercises[] = new ExerciseCategory(
        $row['id'],
        $row['name'],
      );
    }

    return $exercises;
  }
}