<header class="header">
  <div class="header-left">
    <a href="/">
      <img src="public/assets/images/logo.svg" alt="FitTracker logo" class="logo">
    </a>
    <nav class="nav">
      <ul class="nav-list">
        <li class="nav-item">
          <a href="/" class="nav-link text-xl">Home</a>
        </li>
        <li class="nav-item">
          <a href="/exercises_base" class="nav-link text-xl">Exercises base</a>
        </li>
        <li class="nav-item">
          <a href="/private_exercises" class="nav-link text-xl">Private exercises</a>
        </li>
      </ul>
    </nav>
  </div>
  <form action="/logout" method="POST" class="logout-form">
    <button type="submit" class="logout-button text-xl">
      Logout
    </button>
  </form>
  <button class="hamburger" id="hamburger">
    <span class="hamburger-line"></span>
    <span class="hamburger-line"></span>
    <span class="hamburger-line"></span>
  </button>
</header>