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
  <?php include_once __DIR__ . '/shared/side-menu.php' ?>

  <main class="main">
    <div id="exerciseModal" class="modal hidden">
      <div class="modal-content">
        <div class="modal-topbar">
          <h3 class="modal-title font-bold text-2xl"></h3>
          <span class="close">&times;</span>
        </div>
        <div class="modal-body">
          <!-- Modal content will be dynamically inserted here -->
        </div>
      </div>
    </div>

    <div class="exercises-container">
      <div class="exercises-topbar">
        <h1 class="text-4xl font-bold">Exercises base</h1>
        <div class="exercises-topbar-right">
          <?php if ($isAdmin): ?>
            <button type="button" class="btn">
              Add exercise
              <i class="fa-solid fa-plus"></i>
            </button>
          <?php endif; ?>
          <input type="text" placeholder="Search by exercise name" class="exercises-search-input text-input" />
        </div>
      </div>

      <div class="exercises-wrapper">
        <?php if (empty($groupedExercises)): ?>
          <p class="text-lg text-red-500">No exercises found.</p>
        <?php else: ?>
          <?php foreach ($groupedExercises as $categoryName => $exercises): ?>
            <section class="exercises-section">
              <h2 class="text-2xl font-semibold"><?php echo htmlspecialchars($categoryName); ?></h2>
              <div class="exercises-boxes-wrapper">
                <?php foreach ($exercises as $exercise): ?>
                  <div class="exercises-box" data-video-url="<?php echo htmlspecialchars($exercise->getVideoUrl()); ?>">
                    <img src="<?php echo htmlspecialchars($exercise->getImageUrl()); ?>"
                      alt="<?php echo htmlspecialchars($exercise->getName()); ?>" class="exercises-image">
                    <div class="exercises-text-box">
                      <h3 class="font-bold"><?php echo htmlspecialchars($exercise->getName()); ?></h3>
                      <p class="text-sm text-gray exercises-description">
                        <?php echo htmlspecialchars($exercise->getDescription()); ?>
                      </p>
                    </div>
                    <?php if ($isAdmin): ?>
                      <div class="exercises-options-wrapper">
                        <button type="button" class="exercises-option-btn" title="Edit">
                          <i class="fa-solid fa-pen-to-square"></i>
                        </button>
                        <button type="button" class="exercises-option-btn" title="Delete">
                          <i class="fa-solid fa-trash-can"></i>
                        </button>
                      </div>
                    <?php endif; ?>
                  </div>
                <?php endforeach; ?>
              </div>
            </section>
          <?php endforeach; ?>
        <?php endif; ?>
      </div>
    </div>
  </main>
  <script src="public/scripts/exerciseDetailsModal.js"></script>
</body>

</html>