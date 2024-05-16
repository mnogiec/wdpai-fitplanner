<?php

require_once 'AppController.php';
// require_once __DIR__ . '/../repository/WorkoutRepository.php';
require_once __DIR__ . '/../repository/ExerciseRepository.php';
require_once __DIR__ . '/../repository/ExerciseCategoryRepository.php';

class WorkoutController extends AppController
{
    private $workoutRepository;
    private $exerciseRepository;
    private $exerciseCategoryRepository;

    public function __construct()
    {
        parent::__construct();
        // $this->workoutRepository = new WorkoutRepository();
        $this->exerciseRepository = new ExerciseRepository();
        $this->exerciseCategoryRepository = new ExerciseCategoryRepository();
    }

    public function index()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();
        return $this->render('workouts');
    }

    public function createWorkout()
    {
        if (!$this->isPost() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        // TODO: Implement
    }

    public function updateWorkout()
    {
        if (!$this->isPatch() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        // TODO: Implement
    }

    public function deleteWorkout()
    {
        if (!$this->isDelete() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        // TODO: Implement
    }
}