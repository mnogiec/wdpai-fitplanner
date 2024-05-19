<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="public/assets/favicon/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="public/css/base.css">
  <link rel="stylesheet" type="text/css" href="public/css/header.css">
  <link rel="stylesheet" type="text/css" href="public/css/exercises.css">
  <title>Exercises base</title>
</head>

<body>
  <?php include_once __DIR__ . '/shared/header.php' ?>

  <main class="main">
    <div class="exercises-container">
      <div class="exercises-topbar">
        <h1 class="text-4xl font-bold">Exercises base</h1>
        <div class="exercises-topbar-right">
          <input type="text" placeholder="Search by exercise name" class="exercises-search-input text-input" />
        </div>
      </div>

      <div class="exercises-wrapper">
        <?php if (empty($groupedExercises)): ?>
          <p class="exercises-not-found text-gray text-center">No exercises found</p>
        <?php else: ?>
          <?php foreach ($groupedExercises as $categoryName => $exercises): ?>
            <section class="exercises-section">
              <h2 class="text-2xl font-semibold"><?php echo htmlspecialchars($categoryName); ?></h2>
              <div class="exercises-boxes-wrapper">
                <?php foreach ($exercises as $exercise): ?>
                  <div class="exercises-box">
                    <img src="<?php echo htmlspecialchars($exercise->getImageUrl()); ?>"
                      alt="<?php echo htmlspecialchars($exercise->getName()); ?>" class="exercises-image">
                    <div class="exercises-text-box">
                      <h3 class="font-bold"><?php echo htmlspecialchars($exercise->getName()); ?></h3>
                      <p class="text-sm text-gray exercises-description">
                        <?php echo htmlspecialchars($exercise->getDescription()); ?>
                      </p>
                    </div>
                  </div>
                <?php endforeach; ?>
              </div>
            </section>
          <?php endforeach; ?>
        <?php endif; ?>
      </div>
    </div>
  </main>
</body>

</html>