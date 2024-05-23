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
    <?php if ($isAdmin): ?>
      <div class="hidden" id="is_admin"></div>
    <?php endif; ?>
    <div id="exerciseModal" class="modal hidden">
      <div class="modal-content">
        <div class="modal-topbar">
          <h3 class="modal-title font-bold text-2xl"></h3>
          <span class="close">&times;</span>
        </div>
        <div class="modal-body"></div>
      </div>
    </div>

    <div id="createEditModal" class="modal hidden">
      <div class="modal-content">
        <div class="modal-topbar">
          <h3 class="modal-title font-bold text-2xl" id="create-edit-modal-title"></h3>
          <span class="close">&times;</span>
        </div>
        <div class="modal-body">
          <form id="createEditForm" class="exercises-form">
            <div class="exercises-form-row">
              <input type="hidden" name="exercise_id" id="exercise_id">
              <input type="hidden" name="is_private">
              <label for="name">Name:</label>
              <input class="text-input" type="text" id="name" name="name" required>
            </div>
            <div class="exercises-form-row">
              <label for="category">Category:</label>
              <select class="text-input" id="category" name="category">
                <?php foreach ($categories as $category): ?>
                  <option value="<?php echo $category->getId(); ?>"><?php echo htmlspecialchars($category->getName()); ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="exercises-form-row">
              <label for="description">Description:</label>
              <textarea class="text-input text-area" id="description" name="description"></textarea>
            </div>
            <div class="exercises-form-row">
              <label for="video_url">Video URL:</label>
              <input class="text-input" type="text" id="video_url" name="video_url">
            </div>
            <div class="exercises-form-row">
              <label for="image_url">Image URL:</label>
              <input class="text-input" type="text" id="image_url" name="image_url">
            </div>
            <button type="submit" class="btn">Save</button>
          </form>
        </div>
      </div>
    </div>

    <div id="deleteModal" class="modal hidden">
      <div class="modal-content">
        <div class="modal-topbar">
          <h3 class="modal-title font-bold text-2xl">Confirm Delete</h3>
          <span class="close">&times;</span>
        </div>
        <div class="modal-body">
          <p class="mb-1">Are you sure you want to delete this exercise?</p>
        </div>
        <div class="modal-footer">
          <button id="confirmDelete" class="btn">Yes</button>
          <button id="cancelDelete" class="btn">No</button>
        </div>
      </div>
    </div>

    <div class="exercises-container">
      <div class="exercises-topbar">
        <h1 class="text-4xl font-bold">Exercises base</h1>
        <div class="exercises-topbar-right">
          <?php if ($isAdmin): ?>
            <button type="button" class="btn" id="addExerciseBtn">
              Add exercise
              <i class="fa-solid fa-plus"></i>
            </button>
          <?php endif; ?>
          <input type="text" placeholder="Search by exercise name" class="exercises-search-input text-input" />
        </div>
      </div>

      <div class="exercises-wrapper">
        <?php if (empty($groupedExercises)): ?>
          <p class="exercises-not-found text-lg text-red-500">No exercises found</p>
        <?php else: ?>
          <?php foreach ($groupedExercises as $categoryName => $exercises): ?>
            <section class="exercises-section">
              <h2 class="text-2xl font-semibold"><?php echo htmlspecialchars($categoryName); ?></h2>
              <div class="exercises-boxes-wrapper">
                <?php foreach ($exercises as $exercise): ?>
                  <div class="exercises-box" data-video-url="<?php echo htmlspecialchars($exercise->getVideoUrl()); ?>"
                    data-exercise-id="<?php echo $exercise->getId(); ?>"
                    data-name="<?php echo htmlspecialchars($exercise->getName()); ?>"
                    data-category-id="<?php echo htmlspecialchars($exercise->getCategoryId()); ?>"
                    data-description="<?php echo htmlspecialchars($exercise->getDescription()); ?>"
                    data-image-url="<?php echo htmlspecialchars($exercise->getImageUrl()); ?>"
                    data-is-private="<?php echo htmlspecialchars($exercise->getIsPrivate()); ?>">
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
                        <button type="button" class="exercises-option-btn edit-btn"
                          data-exercise-id="<?php echo $exercise->getId(); ?>" title="Edit">
                          <i class="fa-solid fa-pen-to-square"></i>
                        </button>
                        <button type="button" class="exercises-option-btn delete-btn"
                          data-exercise-id="<?php echo $exercise->getId(); ?>" title="Delete">
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
  <script src="public/scripts/exercises.js"></script>
</body>

</html>