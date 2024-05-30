<?php

class Exercise
{
  private $id;
  private $name;
  private $categoryId;
  private $description;
  private $videoUrl;
  private $creatorId;
  private $isPrivate;
  private $imageUrl;
  private $exerciseCategory;

  public function __construct($id, $name, $categoryId, $description, $videoUrl, $creatorId, $isPrivate, $imageUrl, $exerciseCategory = null)
  {
    $this->id = $id;
    $this->name = $name;
    $this->categoryId = $categoryId;
    $this->description = $description;
    $this->videoUrl = $videoUrl;
    $this->creatorId = $creatorId;
    $this->isPrivate = $isPrivate;
    $this->imageUrl = $imageUrl;
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

  public function getDescription(): string
  {
    return $this->description;
  }

  public function getVideoUrl(): ?string
  {
    return $this->videoUrl;
  }

  public function getCreatorId(): int
  {
    return $this->creatorId;
  }

  public function isPrivate(): bool
  {
    return $this->isPrivate;
  }

  public function getImageUrl(): ?string
  {
    return $this->imageUrl;
  }

  public function getExerciseCategory()
  {
    return $this->exerciseCategory;
  }
}