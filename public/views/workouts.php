<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="public/assets/favicon/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="public/css/base.css">
  <link rel="stylesheet" type="text/css" href="public/css/header.css">
  <link rel="stylesheet" type="text/css" href="public/css/workouts.css">
  <title>Workouts</title>
</head>

<body>
  <?php include_once __DIR__ . '/shared/header.php' ?>
  <?php include_once __DIR__ . '/shared/side-menu.php' ?>

  <div id="manageDayModal" class="modal hidden">
    <div class="modal-content">
      <div class="modal-topbar">
        <h3 class="modal-title font-bold text-2xl"></h3>
        <span class="close">&times;</span>
      </div>
      <div class="modal-body">
        <div id="exercisesList" class="workouts-exercises-list"></div>
        <div class="workouts-button-wrapper">
          <button id="addExerciseBtn" class="btn">Add Exercise</button>
        </div>
        <div id="addExerciseForm" class="hidden">
          <p class="font-bold text-xl">New exercise</p>
          <div class="workouts-edit-input-box" id="exerciseCategoryWrapper">
            <label for="exerciseCategory">Category:</label>
            <select id="exerciseCategory" name="exerciseCategory" class="workouts-select">
              <option value="">Select Category</option>
              <!-- Categories will be populated dynamically -->
            </select>
          </div>
          <div class="workouts-edit-input-box hidden" id="exerciseNameWrapper">
            <label for="exerciseName">Exercise:</label>
            <select id="exerciseName" name="exerciseName" class="workouts-select">
              <option value="">Select Exercise</option>
              <!-- Exercises will be populated dynamically -->
            </select>
          </div>
          <div id="workouts-edit-wrapper" class="hidden">
            <div class="workouts-edit-input-box">
              <label for="new-sets">Sets:</label>
              <input type="number" id="new-sets" name="new-sets" class="workouts-edit-input" min="1" required />
            </div>
            <div class="workouts-edit-input-box">
              <label for="new-reps">Reps:</label>
              <input type="number" id="new-reps" name="new-reps" class="workouts-edit-input" min="1" required />
            </div>
            <div class="workouts-edit-input-box">
              <label for="new-weight">Weight:</label>
              <input type="number" id="new-weight" name="new-weight" class="workouts-edit-input" min="1" required />
            </div>
          </div>
          <div class="workouts-button-wrapper">
            <button id="saveNewExerciseBtn" class="btn">Save</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <main class="main">
    <div class="workouts-container">
      <h1 class="text-4xl font-bold">Your workouts</h1>
      <div class="workouts-days-wrapper">
        <?php
        $today = date('Y-m-d');
        $todayFormatted = date('j.m.Y');
        ?>

        <?php if (empty($days) || !isset($days[$today])): ?>
          <div class="workouts-day-box">
            <p class="font-medium text-xl">Today <?php echo $todayFormatted; ?></p>

            <div class="workouts-units-wrapper">
              <p class="workouts-not-found text-gray text-center">You don't have any exercises done today</p>
            </div>

            <div class="workouts-manage-wrapper">
              <button type="button" class="btn" id="manageWorkoutBtn" data-date="<?php echo $today; ?>"
                data-exercises='<?php echo json_encode([]); ?>'>
                Add exercise
                <i class="fa-solid fa-plus"></i>
              </button>
            </div>
          </div>
        <?php endif; ?>

        <?php if ($days): ?>
          <?php foreach ($days as $date => $day): ?>
            <div class="workouts-day-box">
              <p class="font-medium text-xl">
                <?php echo $date === $today ? "Today " . date('j.m.Y') : date('l j.m.Y', strtotime($date)); ?>
              </p>

              <div class="workouts-units-wrapper">
                <?php if (empty($day['exercises'])): ?>
                  <p class="workouts-not-found text-gray text-center">You don't have any exercises done today</p>
                <?php else: ?>
                  <?php foreach ($day['exercises'] as $exercise): ?>
                    <div class="workouts-unit exercise-item og-data"
                      data-id="<?php echo htmlspecialchars($exercise->getId()); ?>">
                      <img src="<?php echo htmlspecialchars($exercise->getExercise()->getImageUrl()); ?>"
                        alt="<?php echo htmlspecialchars($exercise->getExercise()->getName()); ?>" class="workouts-image" />
                      <div class="workouts-text">
                        <p class="font-medium text-lg">
                          <?php echo htmlspecialchars($exercise->getExercise()->getName()); ?>
                        </p>
                        <div class="workouts-details">
                          <p class="text-gray workouts-info" id="sets"
                            data-id="<?php echo htmlspecialchars($exercise->getId()); ?>">Sets:
                            <?php echo htmlspecialchars($exercise->getSets()); ?>
                          </p>
                          <p class="text-gray workouts-info" id="reps"
                            data-id="<?php echo htmlspecialchars($exercise->getId()); ?>">Reps:
                            <?php echo htmlspecialchars($exercise->getReps()); ?>
                          </p>
                          <p class="text-gray workouts-info" id="weight"
                            data-id="<?php echo htmlspecialchars($exercise->getId()); ?>">Weight:
                            <?php echo htmlspecialchars($exercise->getWeight()); ?>kg
                          </p>
                          <p class="text-gray workouts-info workouts-info--long" id="volume">Volume:
                            <?php echo htmlspecialchars($exercise->getSets() * $exercise->getReps() * $exercise->getWeight()); ?>kg
                          </p>
                        </div>
                      </div>
                    </div>
                  <?php endforeach; ?>
                <?php endif; ?>
              </div>

              <div class="workouts-manage-wrapper">
                <button type="button" class="btn" id="manageWorkoutBtn" data-date="<?php echo $date; ?>"
                  data-workout-day-id="<?php echo $day['day_id']; ?>"
                  data-exercises='<?php echo json_encode($day['exercises']); ?>'>
                  <?php echo empty($day['exercises']) ? 'Add exercise' : 'Manage this day'; ?>
                  <i class="fa-solid fa-plus"></i>
                </button>
              </div>
            </div>
          <?php endforeach; ?>
        <?php else: ?>
          <p class="workouts-not-found text-gray text-center">You don't have any workouts recorded.</p>
        <?php endif; ?>
      </div>
    </div>
  </main>

  <script src="public/scripts/workouts.js"></script>
</body>

</html>