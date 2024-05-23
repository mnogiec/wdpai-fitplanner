document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.querySelector(".exercises-search-input");
  const exercisesWrapper = document.querySelector(".exercises-wrapper");
  const isPrivateExercisesPage = document.querySelector(
    "#is_private_exercises"
  );

  searchInput.addEventListener("input", async (event) => {
    const searchTerm = event.target.value;
    const url = isPrivateExercisesPage
      ? "/search_private_exercises"
      : "/search_exercises_base";
    const response = await fetch(`${url}?q=${searchTerm}`);
    const exercises = await response.json();

    console.log(exercises);

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

        if (exercise.isPrivate) {
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
  });
});
