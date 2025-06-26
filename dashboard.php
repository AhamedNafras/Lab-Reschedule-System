<?php
session_start();
if (!isset($_SESSION['UserID'])) {
    header("Location: login.php");
    exit();
}
include 'includes/db.php';
include 'includes/header.php';
?>
<div class="container mt-5">
  <h3>Welcome, <?= $_SESSION['Name'] ?> (<?= $_SESSION['Role'] ?>)</h3>
  <ul>
    <?php if ($_SESSION['Role'] == 'Student'): ?>
      <li><a href="request_form.php">Submit Reschedule Request</a></li>
      <li><a href="notifications.php">View Notifications</a></li>
    <?php elseif ($_SESSION['Role'] == 'Coordinator'): ?>
      <li><a href="create_schedule.php">Create Lab Schedule</a></li>
      <li><a href="review_requests.php">Review Reschedule Requests</a></li>
      <li><a href="attendance.php">Record Attendance</a></li>
      <li><a href="logs.php">View Logs</a></li>
    <?php elseif ($_SESSION['Role'] == 'Instructor'): ?>
      <li><a href="instructor_panel.php">Review Assigned Requests</a></li>
    <?php endif; ?>
    <li><a href="logout.php">Logout</a></li>
  </ul>
</div>
<?php include 'includes/footer.php'; ?>
