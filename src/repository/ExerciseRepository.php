<?php

require_once 'Repository.php';
require_once __DIR__ . '/../models/Exercise.php';

class ExerciseRepository extends Repository
{
  public function getAllExercises($user_id)
  {
    $query = $this->database->connect()->prepare('
      SELECT * FROM exercises e JOIN exercise_categories c ON e.category_id = c.id WHERE (e.is_private = false) OR (e.is_private = true AND e.creator_id = :user_id)'
    );

    $query->bindValue(':user_id', $user_id, PDO::PARAM_INT);
    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $exercises = [];
    foreach ($result as $row) {
      $exercises[] = new Exercise(
        $row['id'],
        $row['name'],
        $row['category_id'],
        $row['description'],
        $row['video_url'],
        $row['creator_id'],
        $row['is_private'],
        $row['image_url'],
      );
    }

    return $exercises;
  }

  public function getPrivateExercises($user_id)
  {
    $query = $this->database->connect()->prepare('
      SELECT * FROM exercises e JOIN exercise_categories c ON e.category_id = c.id WHERE e.is_private = true AND e.creator_id = :user_id'
    );

    $query->bindValue(':user_id', $user_id, PDO::PARAM_INT);
    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $exercises = [];
    foreach ($result as $row) {
      $exercises[] = new Exercise(
        $row['id'],
        $row['name'],
        $row['category_id'],
        $row['description'],
        $row['video_url'],
        $row['creator_id'],
        $row['is_private'],
        $row['image_url'],
      );
    }

    return $exercises;
  }

  public function getExercisesBase()
  {
    $query = $this->database->connect()->prepare('
      SELECT * FROM exercises e JOIN exercise_categories c ON e.category_id = c.id WHERE e.is_private = false'
    );

    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $exercises = [];
    foreach ($result as $row) {
      $exercises[] = new Exercise(
        $row['id'],
        $row['name'],
        $row['category_id'],
        $row['description'],
        $row['video_url'],
        $row['creator_id'],
        $row['is_private'],
        $row['image_url'],
      );
    }

    return $exercises;
  }

  public function createExercise($exercise)
  {
    $query = $this->database->connect()->prepare('
      INSERT INTO exercises (name, category_id, description, video_url, creator_id, is_private, image_url)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    ');

    $query->execute([
      $exercise->getName(),
      $exercise->getCategoryId(),
      $exercise->getDescription(),
      $exercise->getVideoUrl(),
      $exercise->getCreatorId(),
      $exercise->getIsPrivate(),
      $exercise->getImageUrl(),
    ]);
  }

  public function updateExercise($exercise, $user_id)
  {
    $query = $this->database->connect()->prepare('
      UPDATE exercises SET name = :name, category_id = :category_id, description = :description, video_url = :video_url, is_private = :is_private, image_url = :image_url WHERE id = :id AND creator_id = :user_id'
    );

    $query->execute([
      $exercise->getName(),
      $exercise->getCategoryId(),
      $exercise->getDescription(),
      $exercise->getVideoUrl(),
      $exercise->getCreatorId(),
      $exercise->getIsPrivate(),
      $exercise->getImageUrl(),
      $exercise->getCreatorId(),
      $exercise->getIsPrivate(),
      $exercise->getImageUrl(),
    ]);
  }

  public function deleteExercise($exercise_id, $user_id)
  {
    $query = $this->database->connect()->prepare('
      DELETE FROM exercises WHERE id = :exercise_id AND creator_id = :user_id
    ');

    $query->bindValue(':exercise_id', $exercise_id, PDO::PARAM_INT);
    $query->bindValue(':user_id', $user_id, PDO::PARAM_INT);
    $query->execute();
  }
}