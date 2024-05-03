<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="public/css/reset.css">
  <title>FitTracker | Login</title>
</head>

<body>
  <form action="/login" method="POST">
    <input type="email" id="email" name="email" required placeholder="Email" />

    <input type="password" id="password" name="password" required placeholder="Password" />

    <button type="submit">Login</button>

    <?php if (isset($errorMessage)) { ?>
      <p><?php echo $errorMessage; ?></p>
    <?php } ?>
  </form>

  <a href="/register">I don't have an account</a>
</body>

</html>