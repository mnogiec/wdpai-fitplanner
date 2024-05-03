<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" type="text/css" href="public/css/reset.css" />
  <title>FitTracker | Register</title>
</head>

<body>
  <form action="/register" method="POST">
    <input type="text" id="firstName" name="firstName" required placeholder="First name" />

    <input type="text" id="lastName" name="lastName" required placeholder="Last name" />

    <input type="email" id="email" name="email" required placeholder="Email" />

    <input type="password" id="password" name="password" required placeholder="Password" />

    <input type="password" id="repeatedPassword" name="repeatedPassword" required placeholder="Repeat password" />

    <input type="checkbox" id="terms" name="terms" required />
    <label for="terms">I agree to terms of service and privacy policy.</label>

    <button type="submit">Register</button>

    <?php if (isset($errorMessage)) { ?>
      <p><?php echo $errorMessage; ?></p>
    <?php } ?>
  </form>

  <a href="/login">I already have an account</a>
</body>

</html>