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
              <button type="button" class="btn" id="manageWorkoutBtn">
                Add exercise
                <i class="fa-solid fa-plus"></i>
              </button>
            </div>
          </div>
        <?php endif; ?>

        <?php if ($days): ?>
          <?php foreach ($days as $date => $exercises): ?>
            <div class="workouts-day-box">
              <p class="font-medium text-xl">
                <?php echo $date === $today ? "Today " . date('j.m.Y') : date('l j.m.Y', strtotime($date)); ?>
              </p>

              <div class="workouts-units-wrapper">
                <?php if (empty($exercises)): ?>
                  <p class="workouts-not-found text-gray text-center">You don't have any exercises done today</p>
                <?php else: ?>
                  <?php foreach ($exercises as $exercise): ?>
                    <div class="workouts-unit">
                      <img src="https://hips.hearstapps.com/hmg-prod/images/core-workouts-at-home-1666192539.png"
                        alt="Exercise image" class="workouts-image" />
                      <div class="workouts-text">
                        <p class="font-medium text-lg">
                          <?php echo $exercise->getExerciseId(); // Replace with actual exercise name ?>
                        </p>
                        <div class="workouts-details">
                          <p class="text-gray workouts-info">Sets: <?php echo $exercise->getSets(); ?></p>
                          <p class="text-gray workouts-info">Reps: <?php echo $exercise->getReps(); ?></p>
                          <p class="text-gray workouts-info">Weight: <?php echo $exercise->getWeight(); ?>kg</p>
                          <p class="text-gray workouts-info workouts-info--long">Volume:
                            <?php echo $exercise->getSets() * $exercise->getReps() * $exercise->getWeight(); ?>kg
                          </p>
                        </div>
                      </div>
                    </div>
                  <?php endforeach; ?>
                <?php endif; ?>
              </div>

              <div class="workouts-manage-wrapper">
                <button type="button" class="btn" id="manageWorkoutBtn">
                  <?php echo empty($exercises) ? 'Add exercise' : 'Manage this day'; ?>
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