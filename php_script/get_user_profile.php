<?php
// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

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

// Get user_id from POST request
$user_id = $_POST['user_id'];

// Prepare SQL statement to get user details
$sql = "SELECT username, email FROM teachers WHERE id = ?";
$stmt = $conn->prepare($sql);
if ($stmt === false) {
    echo json_encode(array('error' => 'Failed to prepare statement'));
    exit();
}

$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Fetch user details
    $user = $result->fetch_assoc();
    echo json_encode($user);
} else {
    echo json_encode(array('error' => 'User not found'));
}

// Close prepared statement and database connection
$stmt->close();
$conn->close();
?>
