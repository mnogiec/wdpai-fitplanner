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
      SELECT
        day_id, 
        date,
        user_id,
        id,
        sets,
        reps,
        weight,
        workout_day_id, 
        exercise_name, 
        exercise_id, 
        category_id, 
        description, 
        video_url, 
        creator_id, 
        is_private, 
        image_url
      FROM 
        user_workouts_view
      WHERE 
        user_id = :userId
      ORDER BY 
        date DESC
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
        $row['image_url'],
        $row['updated_at']
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

  public function createWorkoutDayAndExercise($workoutDayDate, $exerciseId, $sets, $reps, $weight, $userId)
  {
    $connection = $this->database->connect();
    try {
      $connection->beginTransaction();

      // Create workout day
      $queryDay = $connection->prepare('
        INSERT INTO workout_days (date, user_id)
        VALUES (:workoutDayDate, :userId)
        RETURNING id
      ');
      $queryDay->bindParam(':workoutDayDate', $workoutDayDate, PDO::PARAM_STR);
      $queryDay->bindParam(':userId', $userId, PDO::PARAM_INT);
      $queryDay->execute();
      $workoutDayId = $queryDay->fetchColumn();

      // Create workout exercise
      $queryExercise = $connection->prepare('
        INSERT INTO workout_exercises (workout_day_id, exercise_id, sets, reps, weight)
        VALUES (:workoutDayId, :exerciseId, :sets, :reps, :weight)
      ');
      $queryExercise->bindParam(':workoutDayId', $workoutDayId, PDO::PARAM_INT);
      $queryExercise->bindParam(':exerciseId', $exerciseId, PDO::PARAM_INT);
      $queryExercise->bindParam(':sets', $sets, PDO::PARAM_INT);
      $queryExercise->bindParam(':reps', $reps, PDO::PARAM_INT);
      $queryExercise->bindParam(':weight', $weight, PDO::PARAM_INT);
      $queryExercise->execute();

      $connection->commit();
    } catch (Exception $e) {
      if ($connection->inTransaction()) {
        $connection->rollBack();
      }
      throw $e;
    }
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