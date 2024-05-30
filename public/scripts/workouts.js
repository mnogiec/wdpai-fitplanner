document.addEventListener("DOMContentLoaded", function () {
  const modal = document.getElementById("manageDayModal");
  const closeButton = document.querySelector(".close");
  const modalTitle = document.querySelector(".modal-title");
  const manageDayBtns = document.querySelectorAll("#manageWorkoutBtn");
  const addExerciseBtn = document.getElementById("addExerciseBtn");
  const addExerciseForm = document.getElementById("addExerciseForm");
  const addExerciseWrapper = document.querySelector("#workouts-edit-wrapper");
  const saveNewExerciseBtn = document.getElementById("saveNewExerciseBtn");
  const exerciseCategory = document.getElementById("exerciseCategory");
  const exerciseName = document.getElementById("exerciseName");
  const exerciseNameWrapper = document.getElementById("exerciseNameWrapper");
  const setsInput = document.getElementById("new-sets");
  const repsInput = document.getElementById("new-reps");
  const weightInput = document.getElementById("new-weight");
  let currentWorkoutDayId;
  let currentWorkoutDayDate;
  let categories = [];

  function closeModal() {
    modal.classList.add("hidden");
    addExerciseForm.classList.add("hidden");
    addExerciseForm.classList.remove("workouts-exercises-form");
    addExerciseBtn.classList.remove("hidden");
    addExerciseWrapper.classList.add("hidden");
    addExerciseWrapper.classList.remove("workouts-edit-wrapper");
    exerciseNameWrapper.classList.add("hidden");
  }

  closeButton.addEventListener("click", closeModal);

  window.addEventListener("click", function (event) {
    if (event.target === modal) {
      closeModal();
    }
  });

  manageDayBtns.forEach((btn) => {
    btn.addEventListener("click", function () {
      modalTitle.textContent = `Manage workout`;
      currentWorkoutDayId = this.dataset.workoutDayId;
      currentWorkoutDayDate = this.dataset.date;
      const exercises = JSON.parse(this.dataset.exercises);
      populateExercises(exercises);
      modal.classList.remove("hidden");
    });
  });

  addExerciseBtn.addEventListener("click", function () {
    addExerciseForm.classList.remove("hidden");
    addExerciseForm.classList.add("workouts-exercises-form");
    addExerciseBtn.classList.add("hidden");
    populateCategories();
  });

  exerciseCategory.addEventListener("change", function () {
    const categoryId = this.value;
    if (categoryId) {
      populateExercisesByCategory(categoryId);
    } else {
      exerciseNameWrapper.classList.add("hidden");
    }
  });

  exerciseName.addEventListener("change", function () {
    if (this.value) {
      addExerciseWrapper.classList.remove("hidden");
      addExerciseWrapper.classList.add("workouts-edit-wrapper");
    }
  });

  saveNewExerciseBtn.addEventListener("click", function () {
    const exerciseId = exerciseName.value;
    const sets = document.getElementById("new-sets").value;
    const reps = document.getElementById("new-reps").value;
    const weight = document.getElementById("new-weight").value;
    addExercise(exerciseId, sets, reps, weight);
  });

  function populateExercises(exercises) {
    const exercisesList = document.getElementById("exercisesList");
    exercisesList.innerHTML = ""; // Clear existing exercises

    exercises?.forEach((exercise) => {
      const exerciseItem = document.createElement("div");
      exerciseItem.classList.add("exercise-item");
      exerciseItem.dataset.id = exercise.id;
      exerciseItem.innerHTML = `
        <div class="workouts-unit exercise-item" data-id="${exercise.id}">
          <img src="${exercise.Exercise.imageUrl}"
            alt="${exercise.Exercise.name}" class="workouts-image" />
          <div class="workouts-text">
            <p class="font-medium text-lg">
              ${exercise.Exercise.name}
            </p>
            <div class="workouts-edit-wrapper">
              <div class="workouts-edit-input-box">
                <label for="sets-${exercise.id}">Sets:</label>
                <input type="number" id="sets-${exercise.id}" name="sets" value="${exercise.sets}" class="workouts-edit-input" min="1" />
              </div>
              <div class="workouts-edit-input-box">
                <label for="reps-${exercise.id}">Reps:</label>
                <input type="number" id="reps-${exercise.id}" name="reps" value="${exercise.reps}" class="workouts-edit-input" min="1" />
              </div>
              <div class="workouts-edit-input-box">
                <label for="weight-${exercise.id}">Weight:</label>
                <input type="number" id="weight-${exercise.id}" name="weight" value="${exercise.weight}" class="workouts-edit-input" min="1" />
              </div>
              <div class="workouts-actions">
                <button class="save-exercise-btn workouts-action-button" data-id="${exercise.id}" title="Save">
                  <i class="fa-solid fa-pen-to-square"></i>
                </button>
                <button class="delete-exercise-btn workouts-action-button" data-id="${exercise.id}" title="Delete">
                  <i class="fa-solid fa-trash-can"></i>
                </button>
              </div>
            </div>
          </div>
        </div>
      `;
      exercisesList.appendChild(exerciseItem);
    });

    // Add event listeners for edit and delete buttons
    document.querySelectorAll(".save-exercise-btn").forEach((btn) => {
      btn.addEventListener("click", function () {
        const exerciseId = this.dataset.id;
        const sets = document.getElementById(`sets-${exerciseId}`);
        const reps = document.getElementById(`reps-${exerciseId}`);
        const weight = document.getElementById(`weight-${exerciseId}`);

        if (![sets.value, reps.value, weight.value].every(Boolean)) {
          [sets, reps, weight].forEach((input) => {
            if (!input.value) {
              input.classList.add("invalid");
            } else {
              input.classList.remove("invalid");
            }
          });
          return;
        } else {
          [sets, reps, weight].forEach((input) => {
            input.classList.remove("invalid");
          });
        }

        updateExercise(exerciseId, sets.value, reps.value, weight.value);
      });
    });

    document.querySelectorAll(".delete-exercise-btn").forEach((btn) => {
      btn.addEventListener("click", function () {
        const exerciseId = this.dataset.id;
        deleteExercise(exerciseId);
      });
    });
  }

  function updateExercise(exerciseId, sets, reps, weight) {
    fetch(`update_workout`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ id: exerciseId, sets, reps, weight }),
    }).then(() => {
      const exerciseItem = document.querySelector(
        `.workouts-unit.exercise-item.og-data[data-id='${exerciseId}']`
      );
      exerciseItem.querySelector("#sets").textContent = `Sets: ${sets}`;
      exerciseItem.querySelector("#reps").textContent = `Reps: ${reps}`;
      exerciseItem.querySelector("#weight").textContent = `Weight: ${weight}kg`;
      const volume = sets * reps * weight;
      exerciseItem.querySelector("#volume").textContent = `Volume: ${volume}kg`;
    });
  }

  function deleteExercise(exerciseId) {
    fetch(`delete_workout?id=${exerciseId}`, {
      method: "DELETE",
    }).then(() => {
      document
        .querySelectorAll(`.exercise-item[data-id='${exerciseId}']`)
        .forEach((item) => item.remove());
    });
  }

  async function addExercise(exerciseId, sets, reps, weight) {
    if (![setsInput.value, repsInput.value, weightInput.value].every(Boolean)) {
      [setsInput, repsInput, weightInput].forEach((input) => {
        if (!input.value) {
          input.classList.add("invalid");
        } else {
          input.classList.remove("invalid");
        }
      });
      return;
    } else {
      [setsInput, repsInput, weightInput].forEach((input) => {
        input.classList.remove("invalid");
      });
    }

    if (!currentWorkoutDayId) {
      console.log("new");
      const response = await fetch(`create_workout_day`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          date: currentWorkoutDayDate,
        }),
      });

      const data = await response.json();
      if (data) {
        currentWorkoutDayId = data.id;
      }
    }

    fetch(`create_workout`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        workout_day_id: currentWorkoutDayId,
        exerciseId,
        sets,
        reps,
        weight,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          location.reload();
        } else {
          alert("Failed to add exercise");
        }
      });
  }

  function populateCategories() {
    // Fetch categories from the server (or you can pass them directly from the backend)
    fetch("get_categories")
      .then((response) => response.json())
      .then((data) => {
        categories = data;
        exerciseCategory.innerHTML =
          '<option value="">Select Category</option>'; // Clear existing options
        categories.forEach((category) => {
          const option = document.createElement("option");
          option.value = category.id;
          option.textContent = category.name;
          exerciseCategory.appendChild(option);
        });
      });
  }

  function populateExercisesByCategory(categoryId) {
    // Fetch exercises for the selected category
    fetch(`get_exercises_by_category?category_id=${categoryId}`)
      .then((response) => response.json())
      .then((data) => {
        exerciseName.innerHTML = '<option value="">Select Exercise</option>'; // Clear existing options
        data.forEach((exercise) => {
          const option = document.createElement("option");
          option.value = exercise.id;
          option.textContent = exercise.name;
          exerciseName.appendChild(option);
        });
        exerciseNameWrapper.classList.remove("hidden");
      });
  }
});
