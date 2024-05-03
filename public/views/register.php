<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="public/assets/favicon/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" type="text/css" href="public/css/base.css" />
  <link rel="stylesheet" type="text/css" href="public/css/auth.css" />
  <link rel="stylesheet" type="text/css" href="public/css/header.css">
  <title>FitTracker | Register</title>
</head>

<body>
  <?php include_once __DIR__ . '/shared/simple-header.php' ?>

  <div class="auth-container flex-center">
    <div class="card flex-column auth-card text-center">
      <div>
        <p class="text-4xl font-bold">Nice to meet you!</p>
        <h1 class="text-xl font-medium text-gray">Create an account to start using the app</h1>
      </div>

      <form action="/register" method="POST" class="flex-column auth-form">
        <input type="text" id="firstName" name="firstName" required placeholder="First name" class="text-input" />

        <input type="text" id="lastName" name="lastName" required placeholder="Last name" class="text-input" />

        <input type="email" id="email" name="email" required placeholder="Email" class="text-input" />

        <input type="password" id="password" name="password" required placeholder="Password" class="text-input" />

        <input type="password" id="repeatedPassword" name="repeatedPassword" required placeholder="Repeat password"
          class="text-input" />

        <div class="flex auth-terms-wrapper">
          <input type="checkbox" id="terms" name="terms" required />
          <label for="terms">I agree to <a href="#" class="link">terms of service</a> and <a href="#"
              class="link">privacy policy</a>.</label>
        </div>

        <?php if (isset($errorMessage)) { ?>
          <p class="text-error"><?php echo $errorMessage; ?></p>
        <?php } ?>

        <button type="submit" class="btn auth-btn">Register</button>

      </form>
      <a href="/login" class="link">I already have an account</a>
    </div>
  </div>
</body>

</html>