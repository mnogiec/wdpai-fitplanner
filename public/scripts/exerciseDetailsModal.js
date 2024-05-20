function getYouTubeVideoId(url) {
  const regex =
    /(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/;
  const match = url.match(regex);
  return match ? match[1] : null;
}

document.addEventListener("DOMContentLoaded", function () {
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
      console.log(exerciseImageSrc);
      console.log(exerciseVideoUrl);

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
      video.src = ""; // Reset the src attribute to stop the video
    }
    modalBody.innerHTML = ""; // Clear the modal content
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
});
