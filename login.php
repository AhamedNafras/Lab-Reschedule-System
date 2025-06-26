<?php
session_start();
include 'includes/db.php';
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $password = $_POST['password'];
    $query = "SELECT * FROM Users WHERE Email='$email' AND Password='$password'";
    $result = $conn->query($query);
    if ($result && $result->num_rows == 1) {
        $user = $result->fetch_assoc();
        $_SESSION['UserID'] = $user['UserID'];
        $_SESSION['Role'] = $user['Role'];
        $_SESSION['Name'] = $user['Name'];
        header("Location: dashboard.php");
    } else {
        $error = "Invalid credentials";
    }
}
?>
<!DOCTYPE html>
<html><head><title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center">Login</h2>
    <form method="POST" class="w-50 mx-auto mt-4">
        <?php if(isset($error)) echo "<div class='alert alert-danger'>$error</div>"; ?>
        <input type="email" name="email" placeholder="Email" class="form-control mb-3" required>
        <input type="password" name="password" placeholder="Password" class="form-control mb-3" required>
        <button class="btn btn-primary w-100">Login</button>
    </form>
</div></body></html>
