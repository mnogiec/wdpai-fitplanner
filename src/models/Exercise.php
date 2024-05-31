<?php

class Exercise
{
  public $id;
  public $name;
  public $categoryId;
  public $description;
  public $videoUrl;
  public $creatorId;
  public $isPrivate;
  public $imageUrl;
  public $exerciseCategory;
  public $updatedAt;

  public function __construct($id, $name, $categoryId, $description, $videoUrl, $creatorId, $isPrivate, $imageUrl, $updatedAt, $exerciseCategory = null)
  {
    $this->id = $id;
    $this->name = $name;
    $this->categoryId = $categoryId;
    $this->description = $description;
    $this->videoUrl = $videoUrl;
    $this->creatorId = $creatorId;
    $this->isPrivate = $isPrivate;
    $this->imageUrl = $imageUrl;
    $this->updatedAt = $updatedAt;
    $this->exerciseCategory = $exerciseCategory;
  }

  public function getId(): int
  {
    return $this->id;
  }

  public function getName(): string
  {
    return $this->name;
  }

  public function getCategoryId(): int
  {
    return $this->categoryId;
  }

  public function getDescription(): ?string
  {
    return $this->description;
  }

  public function getVideoUrl(): ?string
  {
    return $this->videoUrl;
  }

  public function getCreatorId(): ?int
  {
    return $this->creatorId;
  }

  public function getIsPrivate(): bool
  {
    return $this->isPrivate;
  }

  public function getImageUrl(): ?string
  {
    return $this->imageUrl;
  }

  public function getUpdatedAt(): string
  {
    return $this->updatedAt;
  }

  public function getExerciseCategory()
  {
    return $this->exerciseCategory;
  }
}