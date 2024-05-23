function getYouTubeVideoId(url) {
  const regex =
    /(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/;
  const match = url.match(regex);
  return match ? match[1] : null;
}

function exerciseDetails() {
  const modal = document.getElementById("exerciseModal");
  const modalBody = modal.querySelector(".modal-body");
  const modalTitle = modal.querySelector(".modal-title");
  const closeButton = modal.querySelector(".close");

  document.querySelectorAll(".exercises-box").forEach((box) => {
    box.addEventListener("click", function () {
      const exerciseName = this.querySelector("h3").innerText;
      const exerciseDescription = this.querySelector(
        ".exercises-description"
      ).innerText;
      const exerciseImageSrc = this.querySelector("img").src;
      const exerciseVideoUrl = this.dataset.videoUrl;

      let modalContent = "";

      if (exerciseVideoUrl) {
        const videoId = getYouTubeVideoId(exerciseVideoUrl);
        if (videoId) {
          modalContent += `
            <iframe width="100%" height="315" src="https://www.youtube.com/embed/${videoId}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen id="exerciseVideo"></iframe>
          `;
        }
      } else {
        modalContent += `<img src="${exerciseImageSrc}" alt="${exerciseName}" class="w-full mb-4">`;
      }

      modalContent += `<p class="modal-text text-gray">${exerciseDescription}</p>`;

      modalTitle.innerText = exerciseName;
      modalBody.innerHTML = modalContent;
      modal.classList.remove("hidden");
    });
  });

  function stopVideo() {
    const video = modalBody.querySelector("#exerciseVideo");
    if (video) {
      video.src = "";
    }
    modalBody.innerHTML = "";
  }

  function closeModal() {
    stopVideo();
    modal.classList.add("hidden");
  }

  closeButton.addEventListener("click", closeModal);

  window.addEventListener("click", function (event) {
    if (event.target === modal) {
      closeModal();
    }
  });
}

function manageExercises() {
  const createEditModal = document.getElementById("createEditModal");
  const createEditModalTitle = document.getElementById(
    "create-edit-modal-title"
  );
  const deleteModal = document.getElementById("deleteModal");
  const createEditForm = document.getElementById("createEditForm");
  const addExerciseBtn = document.getElementById("addExerciseBtn");

  const openModal = (modal) => modal.classList.remove("hidden");
  const closeModal = (modal) => modal.classList.add("hidden");

  document.querySelectorAll(".close").forEach((btn) => {
    btn.addEventListener("click", function () {
      closeModal(btn.closest(".modal"));
    });
  });

  window.addEventListener("click", function (event) {
    if (event.target === createEditModal || event.target === deleteModal) {
      closeModal(event.target);
    }
  });

  if (addExerciseBtn) {
    addExerciseBtn.addEventListener("click", function () {
      createEditModalTitle.textContent = "Add Exercise";
      document.getElementById("exercise_id").value = "";
      document.getElementById("name").value = "";
      document.getElementById("category").value = "";
      document.getElementById("description").value = "";
      document.getElementById("video_url").value = "";
      document.getElementById("image_url").value = "";
      document.querySelector(".modal-title").innerText = "Add Exercise";
      openModal(createEditModal);
    });
  }

  document.querySelectorAll(".edit-btn").forEach((btn) => {
    btn.addEventListener("click", function (event) {
      event.stopPropagation();

      createEditModalTitle.textContent = "Edit Exercise";

      const exerciseBox = btn.closest(".exercises-box");
      const exerciseId = exerciseBox.dataset.exerciseId;
      const name = exerciseBox.dataset.name;
      const categoryId = exerciseBox.dataset.categoryId;
      const description = exerciseBox.dataset.description;
      const videoUrl = exerciseBox.dataset.videoUrl;
      const imageUrl = exerciseBox.dataset.imageUrl;

      document.getElementById("exercise_id").value = exerciseId;
      document.getElementById("name").value = name;
      document.getElementById("category").value = categoryId;
      document.getElementById("description").value = description;
      document.getElementById("video_url").value = videoUrl;
      document.getElementById("image_url").value = imageUrl;
      document.querySelector(".modal-title").innerText = "Edit Exercise";
      openModal(createEditModal);
    });
  });

  document.querySelectorAll(".delete-btn").forEach((btn) => {
    btn.addEventListener("click", function (event) {
      event.stopPropagation();
      const exerciseId = this.dataset.exerciseId;
      document.getElementById("confirmDelete").dataset.exerciseId = exerciseId;
      openModal(deleteModal);
    });
  });

  document
    .getElementById("confirmDelete")
    .addEventListener("click", function () {
      const exerciseId = this.dataset.exerciseId;
      const url = `/delete_exercise`;

      fetch(url, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ exercise_id: exerciseId }),
      }).then((response) => {
        if (response.ok) {
          closeModal(deleteModal);
          location.reload();
        } else {
          alert("Error deleting exercise");
        }
      });
    });

  document
    .getElementById("cancelDelete")
    .addEventListener("click", function () {
      closeModal(deleteModal);
    });

  createEditForm.addEventListener("submit", function (e) {
    e.preventDefault();
    const formData = new FormData(createEditForm);
    const exerciseId = formData.get("exercise_id");
    const method = exerciseId ? "PATCH" : "POST";
    const url = exerciseId ? `/update_exercise` : `/create_exercise`;

    const bodyObject = {};
    formData.forEach((value, key) => (bodyObject[key] = value));
    const bodyJson = JSON.stringify(bodyObject);

    fetch(url, {
      method,
      body: exerciseId ? bodyJson : formData,
    }).then((response) => {
      if (response.ok) {
        closeModal(createEditModal);
        location.reload();
      } else {
        alert("Error saving exercise");
      }
    });
  });
}

function searchExercises() {
  const searchInput = document.querySelector(".exercises-search-input");
  const exercisesWrapper = document.querySelector(".exercises-wrapper");
  const isPrivateExercisesPage = document.querySelector(
    "#is_private_exercises"
  );
  const isAdmin = document.querySelector("#is_admin");

  searchInput.addEventListener("input", async (event) => {
    const searchTerm = event.target.value;
    const url = isPrivateExercisesPage
      ? "/search_private_exercises"
      : "/search_exercises_base";
    const response = await fetch(`${url}?q=${searchTerm}`);
    const exercises = await response.json();

    exercisesWrapper.innerHTML = "";
    if (Object.keys(exercises).length === 0) {
      exercisesWrapper.innerHTML =
        '<p class="exercises-not-found text-lg text-red-500">No exercises found</p>';
      return;
    }

    for (const [categoryName, exercisesList] of Object.entries(exercises)) {
      const section = document.createElement("section");
      section.classList.add("exercises-section");

      const heading = document.createElement("h2");
      heading.classList.add("text-2xl", "font-semibold");
      heading.textContent = categoryName;
      section.appendChild(heading);

      const boxesWrapper = document.createElement("div");
      boxesWrapper.classList.add("exercises-boxes-wrapper");

      exercisesList.forEach((exercise) => {
        const box = document.createElement("div");
        box.classList.add("exercises-box");
        box.dataset.videoUrl = exercise.videoUrl;
        box.dataset.exerciseId = exercise.id;
        box.dataset.name = exercise.name;
        box.dataset.categoryId = exercise.categoryId;
        box.dataset.description = exercise.description;
        box.dataset.imageUrl = exercise.imageUrl;
        box.dataset.isPrivate = exercise.isPrivate;

        const img = document.createElement("img");
        img.src = exercise.imageUrl;
        img.alt = exercise.name;
        img.classList.add("exercises-image");
        box.appendChild(img);

        const textBox = document.createElement("div");
        textBox.classList.add("exercises-text-box");

        const nameHeading = document.createElement("h3");
        nameHeading.classList.add("font-bold");
        nameHeading.textContent = exercise.name;
        textBox.appendChild(nameHeading);

        const description = document.createElement("p");
        description.classList.add(
          "text-sm",
          "text-gray",
          "exercises-description"
        );
        description.textContent = exercise.description;
        textBox.appendChild(description);

        box.appendChild(textBox);

        if (exercise.isPrivate || isAdmin) {
          const optionsWrapper = document.createElement("div");
          optionsWrapper.classList.add("exercises-options-wrapper");

          const editButton = document.createElement("button");
          editButton.type = "button";
          editButton.classList.add("exercises-option-btn", "edit-btn");
          editButton.dataset.exerciseId = exercise.id;
          editButton.title = "Edit";
          editButton.innerHTML = '<i class="fa-solid fa-pen-to-square"></i>';
          optionsWrapper.appendChild(editButton);

          const deleteButton = document.createElement("button");
          deleteButton.type = "button";
          deleteButton.classList.add("exercises-option-btn", "delete-btn");
          deleteButton.dataset.exerciseId = exercise.id;
          deleteButton.title = "Delete";
          deleteButton.innerHTML = '<i class="fa-solid fa-trash-can"></i>';
          optionsWrapper.appendChild(deleteButton);

          box.appendChild(optionsWrapper);
        }

        boxesWrapper.appendChild(box);
      });

      section.appendChild(boxesWrapper);
      exercisesWrapper.appendChild(section);
    }

    manageExercises();
    exerciseDetails();
  });
}

document.addEventListener("DOMContentLoaded", manageExercises);
document.addEventListener("DOMContentLoaded", exerciseDetails);
document.addEventListener("DOMContentLoaded", searchExercises);
