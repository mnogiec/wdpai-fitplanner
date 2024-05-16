<div class="side-menu" id="side-menu">
  <script>
    document.addEventListener('DOMContentLoaded', () => {
      const hamburger = document.getElementById('hamburger');
      const sideMenu = document.getElementById('side-menu');

      hamburger.addEventListener('click', () => {
        sideMenu.classList.toggle('open');
      });
    });
  </script>
  <ul class="side-menu-list">
    <li class="side-menu-item">
      <a href="/" class="side-menu-link text-xl">Home</a>
    </li>
    <li class="side-menu-item">
      <a href="/exercises_base" class="side-menu-link text-xl">Exercises base</a>
    </li>
    <li class="side-menu-item">
      <a href="/private_exercises" class="side-menu-link text-xl">Private exercises</a>
    </li>
    <li class="side-menu-item">
      <form action="/logout" method="POST">
        <button type="submit" class="side-menu-link text-xl side-menu-logout">Logout</button>
      </form>
    </li>
  </ul>
</div>