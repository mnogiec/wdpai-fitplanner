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
        SELECT wd.id as day_id, wd.date, we.*,
        e.name as exercise_name, e.id as exercise_id, e.category_id, e.description, e.video_url, e.creator_id, e.is_private, e.image_url
        FROM workout_days wd 
        JOIN workout_exercises we ON wd.id = we.workout_day_id
        JOIN exercises e ON e.id = we.exercise_id
        WHERE wd.user_id = :userId
        ORDER BY wd.date DESC
    ');

    $query->bindParam(':userId', $userId, PDO::PARAM_INT);
    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $workouts = [];

    foreach ($result as $row) {
      $date = $row['date'];
      $dayId = $row['day_id'];
      if (!isset($workouts[$date])) {
        $workouts[$date] = [
          'day_id' => $dayId,
          'exercises' => []
        ];
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

      $workouts[$date]['exercises'][] = new WorkoutExercise(
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

  public function createWorkoutExercise($workoutDayId, $exerciseId, $sets, $reps, $weight)
  {
    $query = $this->database->connect()->prepare('
        INSERT INTO workout_exercises (workout_day_id, exercise_id, sets, reps, weight)
        VALUES (:workoutDayId, :exerciseId, :sets, :reps, :weight)
    ');
    $query->bindParam(':workoutDayId', $workoutDayId, PDO::PARAM_INT);
    $query->bindParam(':exerciseId', $exerciseId, PDO::PARAM_INT);
    $query->bindParam(':sets', $sets, PDO::PARAM_INT);
    $query->bindParam(':reps', $reps, PDO::PARAM_INT);
    $query->bindParam(':weight', $weight, PDO::PARAM_INT);
    $query->execute();
  }

  public function createWorkoutDay($workoutDay, $userId)
  {
    $query = $this->database->connect()->prepare('
        INSERT INTO workout_days (date, user_id)
        VALUES (:workoutDay, :userId)
        RETURNING id
    ');
    $query->bindParam(':workoutDay', $workoutDay, PDO::PARAM_STR);
    $query->bindParam(':userId', $userId, PDO::PARAM_INT);
    $query->execute();

    $lastInsertId = $query->fetchColumn();

    return new WorkoutDay($lastInsertId, $workoutDay, $userId);
  }

  public function updateExerciseById($exerciseId, $sets, $reps, $weight)
  {
    $query = $this->database->connect()->prepare('
        UPDATE workout_exercises
        SET sets = :sets, reps = :reps, weight = :weight
        WHERE id = :exerciseId
    ');
    $query->bindParam(':exerciseId', $exerciseId, PDO::PARAM_INT);
    $query->bindParam(':sets', $sets, PDO::PARAM_INT);
    $query->bindParam(':reps', $reps, PDO::PARAM_INT);
    $query->bindParam(':weight', $weight, PDO::PARAM_INT);
    $query->execute();
  }

  public function deleteExerciseById($exerciseId)
  {
    $query = $this->database->connect()->prepare('DELETE FROM workout_exercises WHERE id = :exerciseId');
    $query->bindParam(':exerciseId', $exerciseId, PDO::PARAM_INT);
    $query->execute();
  }
}