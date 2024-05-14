<?php

require_once 'AppController.php';
// require_once __DIR__ . '/../repository/ExerciseRepository.php';
// require_once __DIR__ . '/../repository/ExerciseCategoryRepository.php';

class ExerciseController extends AppController
{
    private $exerciseRepository;
    private $exerciseCategoryRepository;

    public function __construct()
    {
        parent::__construct();
        // $this->exerciseRepository = new ExerciseRepository();
        // $this->exerciseCategoryRepository = new ExerciseCategoryRepository();
    }

    public function exercises_base()
    {
        if (!$this->isGet()) {
            return;
        }

        // TODO: Implement (with filter)
    }

    public function private_exercises()
    {
        if (!$this->isGet()) {
            return;
        }

        // TODO: Implement (with filter)
    }

    public function create_private_exercise()
    {
        if (!$this->isPost()) {
            return;
        }

        // TODO: Implement
    }

    public function update_private_exercise()
    {
        if (!$this->isPatch()) {
            return;
        }

        // TODO: Implement
    }

    public function delete_private_exercise()
    {
        if (!$this->isDelete()) {
            return;
        }

        // TODO: Implement
    }

}