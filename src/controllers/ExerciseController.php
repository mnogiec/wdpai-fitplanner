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
        return $this->render('exercises_base', [
            'groupedExercises' => $this->exerciseRepository->getExercisesBase(),
            'isAdmin' => $this->getLoggedUser()->isAdmin(),
            'categories' => $this->exerciseCategoryRepository->getAllExerciseCategories()
        ]);
    }

    public function search_exercises_base()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();

        $searchTerm = isset($_GET['q']) ? $_GET['q'] : '';
        $exercises = $this->exerciseRepository->getExercisesBase($searchTerm);

        header('Content-Type: application/json');
        echo json_encode($exercises);
    }

    public function private_exercises()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();
        return $this->render('private_exercises', [
            'groupedExercises' => $this->exerciseRepository->getPrivateExercises($this->getLoggedUser()->getId()),
            'categories' => $this->exerciseCategoryRepository->getAllExerciseCategories()
        ]);
    }

    public function search_private_exercises()
    {
        if (!$this->isGet()) {
            return;
        }

        $this->loginRequired();

        $searchTerm = isset($_GET['q']) ? $_GET['q'] : null;
        $userId = $this->getLoggedUser()->getId();
        $exercises = $this->exerciseRepository->getPrivateExercises($userId, $searchTerm);

        header('Content-Type: application/json');
        echo json_encode($exercises);
    }

    public function create_exercise()
    {
        if (!$this->isPost() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $exercise = new Exercise(
            null,
            $_POST['name'],
            $_POST['category'],
            $_POST['description'],
            $_POST['video_url'],
            $this->getLoggedUser()->getId(),
            $_POST['is_private'] ? true : false,
            $_POST['image_url']
        );

        $this->exerciseRepository->createExercise($exercise);
        http_response_code(201);
    }

    public function update_exercise()
    {
        if (!$this->isPatch() || !$this->getSession()->isLoggedIn()) {
            return;
        }

        $patchVars = json_decode(file_get_contents('php://input'), true);

        $exercise = new Exercise(
            $patchVars['exercise_id'],
            $patchVars['name'],
            $patchVars['category'],
            $patchVars['description'],
            $patchVars['video_url'],
            $this->getLoggedUser()->getId(),
            $patchVars['is_private'] ? true : false,
            $patchVars['image_url']
        );

        $this->exerciseRepository->updateExercise($exercise);

        http_response_code(204);
    }

    public function delete_exercise()
    {
        if (!$this->isDelete() || !$this->getSession()->isLoggedIn()) {
            error_log('Unauthorized delete attempt');
            http_response_code(401);
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $exercise_id = $data['exercise_id'];

        $this->exerciseRepository->deleteExercise($exercise_id);

        http_response_code(204);
    }
}