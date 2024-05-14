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

  public function __construct($id, $name, $categoryId, $description, $videoUrl, $creatorId, $isPrivate, $imageUrl)
  {
    $this->id = $id;
    $this->name = $name;
    $this->categoryId = $categoryId;
    $this->description = $description;
    $this->videoUrl = $videoUrl;
    $this->creatorId = $creatorId;
    $this->isPrivate = $isPrivate;
    $this->imageUrl = $imageUrl;
  }

  public function getId()
  {
    return $this->id;
  }

  public function getName()
  {
    return $this->name;
  }

  public function getCategoryId()
  {
    return $this->categoryId;
  }

  public function getDescription()
  {
    return $this->description;
  }

  public function getVideoUrl()
  {
    return $this->videoUrl;
  }

  public function getCreatorId()
  {
    return $this->creatorId;
  }

  public function isPrivate()
  {
    return $this->isPrivate;
  }

  public function getImageUrl()
  {
    return $this->imageUrl;
  }
}