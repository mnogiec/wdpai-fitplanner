<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="public/assets/favicon/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" type="text/css" href="public/css/base.css">
  <link rel="stylesheet" type="text/css" href="public/css/auth.css">
  <link rel="stylesheet" type="text/css" href="public/css/header.css">
  <title>FitTracker | Login</title>
</head>

<body>
  <?php include_once __DIR__ . '/shared/simple-header.php' ?>

  <div class="auth-container flex-center">
    <div class="card flex-column auth-card text-center">
      <div>
        <p class="text-4xl font-bold">Good to see you again!</p>
        <h1 class="text-xl font-medium text-gray">Login to start using the app</h1>
      </div>

      <form action="/login" method="POST" class="flex-column auth-form">
        <input type="email" id="email" name="email" required placeholder="Email" class="text-input" />

        <input type="password" id="password" name="password" required placeholder="Password" class="text-input" />

        <?php if (isset($errorMessage)) { ?>
          <p class="text-error"><?php echo $errorMessage; ?></p>
        <?php } ?>

        <button type="submit" class="btn auth-btn">Login</button>

      </form>
      <a href="/register" class="link">I don't have an account</a>
    </div>
  </div>
</body>

</html>