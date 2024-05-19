<?php

require_once 'AppController.php';
require_once __DIR__ . '/../repository/ExerciseRepository.php';
require_once __DIR__ . '/../repository/ExerciseCategoryRepository.php';

class ExerciseController extends AppController
{
    private $exerciseRepository;
    private $exerciseCategoryRepository;

    public function __construct()
    {
        parent::__construct();
        $this->exerciseRepository = new ExerciseRepository();
        $this->exerciseCategoryRepository = new ExerciseCategoryRepository();
    }

    public function exercises_base()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();
        return $this->render('exercises_base', ['groupedExercises' => $this->exerciseRepository->getExercisesBase()]);
    }

    public function private_exercises()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();
        return $this->render('private_exercises', ['' => $this->exerciseRepository->getPrivateExercises($this->getLoggedUser()->getId())]);

    }

    public function create_private_exercise()
    {
        if (!$this->isPost() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        // TODO: Implement
    }

    public function update_private_exercise()
    {
        if (!$this->isPatch() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        // TODO: Implement
    }

    public function delete_private_exercise()
    {
        if (!$this->isDelete() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        // TODO: Implement
    }

}