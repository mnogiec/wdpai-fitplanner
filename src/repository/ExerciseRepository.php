<?php

require_once 'Repository.php';
require_once __DIR__ . '/../models/Exercise.php';

class ExerciseRepository extends Repository
{
  public function getExercisesByCategory($categoryId)
  {
    $query = $this->database->connect()->prepare('
        SELECT id, name
        FROM exercises
        WHERE category_id = :categoryId
    ');
    $query->bindParam(':categoryId', $categoryId, PDO::PARAM_INT);
    $query->execute();

    return $query->fetchAll(PDO::FETCH_ASSOC);
  }

  public function getExercisesBase($searchTerm = null)
  {
    $sql = '
      SELECT 
        id, name, category_id, description, video_url, creator_id, is_private, image_url, updated_at, category_name
      FROM 
        exercises_base_view
      WHERE 
        is_private = false
    ';

    if ($searchTerm) {
      $sql .= ' AND name ILIKE :searchTerm';
    }

    $query = $this->database->connect()->prepare($sql);

    if ($searchTerm) {
      $query->bindValue(':searchTerm', '%' . $searchTerm . '%', PDO::PARAM_STR);
    }

    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $groupedExercises = [];
    foreach ($result as $row) {
      $exercise = new Exercise(
        $row['id'],
        $row['name'],
        $row['category_id'],
        $row['description'],
        $row['video_url'],
        $row['creator_id'],
        $row['is_private'],
        $row['image_url'],
        $row['updated_at'],
      );

      $categoryName = $row['category_name'];

      if (!isset($groupedExercises[$categoryName])) {
        $groupedExercises[$categoryName] = [];
      }

      $groupedExercises[$categoryName][] = $exercise;
    }

    return $groupedExercises;
  }

  public function getPrivateExercises($userId, $searchTerm = null)
  {
    $sql = '
      SELECT 
        id, name, category_id, description, video_url, creator_id, is_private, image_url, updated_at, category_name  
      FROM 
        private_exercises_view
      WHERE
        is_private = true AND creator_id = :user_id
    ';

    if ($searchTerm) {
      $sql .= ' AND name ILIKE :searchTerm';
    }

    $query = $this->database->connect()->prepare($sql);

    $query->bindValue(':user_id', $userId, PDO::PARAM_INT);

    if ($searchTerm) {
      $query->bindValue(':searchTerm', '%' . $searchTerm . '%', PDO::PARAM_STR);
    }

    $query->execute();

    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $groupedExercises = [];
    foreach ($result as $row) {
      $exercise = new Exercise(
        $row['id'],
        $row['name'],
        $row['category_id'],
        $row['description'],
        $row['video_url'],
        $row['creator_id'],
        $row['is_private'],
        $row['image_url'],
        $row['updated_at'],
      );

      $categoryName = $row['category_name'];

      if (!isset($groupedExercises[$categoryName])) {
        $groupedExercises[$categoryName] = [];
      }

      $groupedExercises[$categoryName][] = $exercise;
    }

    return $groupedExercises;
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
      $exercise->getIsPrivate() ? 1 : 0,
      $exercise->getImageUrl(),
    ]);
  }

  public function updateExercise($exercise)
  {
    $query = $this->database->connect()->prepare('
            UPDATE exercises SET name = :name, category_id = :category_id, description = :description, video_url = :video_url, is_private = :is_private, image_url = :image_url 
            WHERE id = :id'
    );

    $query->bindValue(':name', $exercise->getName(), PDO::PARAM_STR);
    $query->bindValue(':category_id', $exercise->getCategoryId(), PDO::PARAM_INT);
    $query->bindValue(':description', $exercise->getDescription(), PDO::PARAM_STR);
    $query->bindValue(':video_url', $exercise->getVideoUrl(), PDO::PARAM_STR);
    $query->bindValue(':is_private', $exercise->getIsPrivate() ? 1 : 0, PDO::PARAM_BOOL);
    $query->bindValue(':image_url', $exercise->getImageUrl(), PDO::PARAM_STR);
    $query->bindValue(':id', $exercise->getId(), PDO::PARAM_INT);
    $query->execute();
  }

  public function deleteExerciseById($exercise_id)
  {
    $query = $this->database->connect()->prepare('
            DELETE FROM exercises WHERE id = :exercise_id
        ');

    $query->bindValue(':exercise_id', $exercise_id, PDO::PARAM_INT);
    $query->execute();
  }
}