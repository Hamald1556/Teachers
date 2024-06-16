<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "special_education";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the feedback from the request
$feedback = $_POST['feedback'];

// Prepare and bind
$stmt = $conn->prepare("INSERT INTO feedback (feedback) VALUES (?)");
$stmt->bind_param("s", $feedback);

if ($stmt->execute()) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error"]);
}

$stmt->close();
$conn->close();
?>
