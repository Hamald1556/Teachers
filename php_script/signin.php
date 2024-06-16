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

// Get email and password from POST request
$email = $_POST['email'];
$password = $_POST['password'];

// Prepare SQL statement to check if user exists
$sql = "SELECT id, password FROM teachers WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

$response = array();

if ($result->num_rows > 0) {
    // User found, verify password
    $row = $result->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        // Password correct, login successful
        $response['status'] = 'success';
        $response['user_id'] = (int)$row['id']; // Return user_id as int
    } else {
        // Password incorrect
        $response['status'] = 'error';
        $response['message'] = 'Incorrect password';
    }
} else {
    // User not found
    $response['status'] = 'error';
    $response['message'] = 'User not found';
}

// Return JSON response
echo json_encode($response);

// Close prepared statement and database connection
$stmt->close();
$conn->close();
?>
