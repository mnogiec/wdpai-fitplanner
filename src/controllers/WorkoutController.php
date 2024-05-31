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
        if (!$this->isGet()) {
            return;
        }

        $categories = $this->exerciseCategoryRepository->getAllExerciseCategories();
        header('Content-Type: application/json');
        echo json_encode($categories);
    }

    public function get_exercises_by_category()
    {
        if (!$this->isGet()) {
            return;
        }

        $categoryId = $_GET['category_id'];
        if ($categoryId === null) {
            http_response_code(400);
            return;
        }

        $exercises = $this->exerciseRepository->getExercisesByCategory($categoryId);
        header('Content-Type: application/json');
        echo json_encode($exercises);
    }

    public function create_workout()
    {
        if (!$this->isPost() || !$this->getSession()->isLoggedIn()) {
            http_response_code(401);
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);
        if (!isset($data['exerciseId'], $data['sets'], $data['reps'], $data['weight'])) {
            http_response_code(400);
            return;
        }

        $workoutDayId = $data['workout_day_id'] ?? null;
        $workoutDayDate = $data['date'] ?? null;

        if ($workoutDayId === null && $workoutDayDate === null) {
            http_response_code(400);
            echo json_encode(['error' => 'Either workout_day_id or date is required']);
            return;
        }

        if ($workoutDayId !== null) {
            $this->workoutRepository->createWorkoutExercise($workoutDayId, $data['exerciseId'], $data['sets'], $data['reps'], $data['weight']);
        } else {
            $userId = $this->getSession()->getUserId();
            $this->workoutRepository->createWorkoutDayAndExercise($workoutDayDate, $data['exerciseId'], $data['sets'], $data['reps'], $data['weight'], $userId);
        }

        header('Content-Type: application/json');
        http_response_code(201);
        echo json_encode(['success' => true]);
    }

    public function update_workout()
    {
        if (!$this->isPatch() || !$this->getSession()->isLoggedIn()) {
            http_response_code(401);
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);
        if (!isset($data['id'], $data['sets'], $data['reps'], $data['weight'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Missing required parameters']);
            return;
        }

        $this->workoutRepository->updateExerciseById($data['id'], $data['sets'], $data['reps'], $data['weight']);
        http_response_code(204);
    }

    public function delete_workout()
    {
        if (!$this->isDelete() || !$this->getSession()->isLoggedIn()) {
            http_response_code(401);
            return;
        }

        $exerciseId = $_GET['id'] ?? null;
        if ($exerciseId === null) {
            http_response_code(400);
            return;
        }

        $this->workoutRepository->deleteExerciseById($exerciseId);
        http_response_code(204);
    }
}