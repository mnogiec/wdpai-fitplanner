<?php

require_once 'AppController.php';
require_once __DIR__ . '/../repository/WorkoutRepository.php';
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
        $this->workoutRepository = new WorkoutRepository();
        $this->exerciseRepository = new ExerciseRepository();
        $this->exerciseCategoryRepository = new ExerciseCategoryRepository();
    }

    public function index()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();
        $userId = $this->getSession()->getUserId();
        $workouts = $this->workoutRepository->getUserWorkouts($userId);
        return $this->render('workouts', ["days" => $workouts]);
    }

    public function get_categories()
    {
        if (!$this->isGet() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $categories = $this->exerciseCategoryRepository->getAllExerciseCategories();
        header('Content-Type: application/json');
        echo json_encode($categories);
    }

    public function get_exercises_by_category()
    {
        if (!$this->isGet() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $categoryId = $_GET['category_id'];
        $exercises = $this->exerciseRepository->getExercisesByCategory($categoryId);
        header('Content-Type: application/json');
        echo json_encode($exercises);
    }

    public function create_workout()
    {
        if (!$this->isPost() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);
        $workoutDayId = $data['workout_day_id'];
        $exerciseId = $data['exerciseId'];
        $sets = $data['sets'];
        $reps = $data['reps'];
        $weight = $data['weight'];

        // Assuming you have a method in your repository to add the exercise
        $this->workoutRepository->addExercise($workoutDayId, $exerciseId, $sets, $reps, $weight);

        header('Content-Type: application/json');
        echo json_encode(['success' => true]);
    }

    public function create_workout_day()
    {
        if (!$this->isPost() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);
        $workoutDayDate = $data['date'];

        $day = $this->workoutRepository->addDay($workoutDayDate, $this->getSession()->getUserID());

        header('Content-Type: application/json');
        echo json_encode(["id" => $day->getId()]);
    }

    public function update_workout()
    {
        if (!$this->isPatch() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);
        $exerciseId = $data['id'];
        $sets = $data['sets'];
        $reps = $data['reps'];
        $weight = $data['weight'];

        $this->workoutRepository->updateExerciseById($exerciseId, $sets, $reps, $weight);
    }

    public function delete_workout()
    {
        if (!$this->isDelete() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $exerciseId = $_GET['id'];

        $this->workoutRepository->deleteExerciseById($exerciseId);
        http_response_code(204);
    }
}