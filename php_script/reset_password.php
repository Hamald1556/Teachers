<?php
// Database connection parameters
$servername = "localhost";
$username = "root"; // Default username for XAMPP
$password = ""; // Default password for XAMPP
$database = "special_education";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get user_id and new_password from POST request
$user_id = $_POST['user_id'];
$new_password = $_POST['new_password'];

// Hash the new password
$hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

// Prepare SQL statement to update the password
$sql = "UPDATE teachers SET password = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $hashed_password, $user_id);
if ($stmt->execute()) {
    echo "Password reset successful";
} else {
    echo "Failed to reset password";
}

// Close prepared statement and database connection
$stmt->close();
$conn->close();
?>
