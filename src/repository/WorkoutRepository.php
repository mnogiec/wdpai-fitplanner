<?php

require_once 'Repository.php';
require_once __DIR__ . '/../models/Exercise.php';
require_once __DIR__ . '/../models/WorkoutDay.php';
require_once __DIR__ . '/../models/WorkoutExercise.php';

class WorkoutRepository extends Repository
{
  public function getUserWorkouts($userId)
  {
    $query = $this->database->connect()->prepare('
        SELECT wd.date, we.* ,
        e.name as exercise_name, e.id as exercise_id, e.category_id, e.description, e.video_url, e.creator_id, e.is_private, e.image_url
        FROM workout_days wd 
        JOIN workout_exercises we ON wd.id = we.workout_day_id
        JOIN exercises e ON e.id = we.exercise_id
        WHERE wd.user_id = :userId
    ');

    $query->bindParam(':userId', $userId, PDO::PARAM_INT);
    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $workouts = [];

    foreach ($result as $row) {
      $date = $row['date'];
      if (!isset($workouts[$date])) {
        $workouts[$date] = [];
      }

      $exercise = new Exercise(
        $row['exercise_id'],
        $row['exercise_name'],
        $row['category_id'],
        $row['description'],
        $row['video_url'],
        $row['creator_id'],
        $row['is_private'],
        $row['image_url']
      );

      $workouts[$date][] = new WorkoutExercise(
        $row['id'],
        $row['exercise_id'],
        $row['workout_day_id'],
        $row['sets'],
        $row['reps'],
        $row['weight'],
        $exercise
      );
    }

    return $workouts;
  }
}