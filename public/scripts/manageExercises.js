document.addEventListener("DOMContentLoaded", function () {
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
});
