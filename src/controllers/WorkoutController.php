<?php

require_once 'AppController.php';
// require_once __DIR__ . '/../repository/WorkoutRepository.php';
// require_once __DIR__ . '/../repository/ExerciseRepository.php';
// require_once __DIR__ . '/../repository/ExerciseCategoryRepository.php';

class WorkoutController extends AppController
{
    private $workoutRepository;
    private $exerciseRepository;
    private $exerciseCategoryRepository;

    public function __construct()
    {
        parent::__construct();
        // $this->workoutRepository = new WorkoutRepository();
        // $this->exerciseRepository = new ExerciseRepository();
        // $this->exerciseCategoryRepository = new ExerciseCategoryRepository();
    }

    public function workouts()
    {
        if (!$this->isGet()) {
            return;
        }

        // TODO: Implement (group by day)
    }

    public function createWorkout()
    {
        if (!$this->isPost()) {
            return;
        }

        // TODO: Implement
    }

    public function updateWorkout()
    {
        if (!$this->isPatch()) {
            return;
        }

        // TODO: Implement
    }

    public function deleteWorkout()
    {
        if (!$this->isDelete()) {
            return;
        }

        // TODO: Implement
    }
}