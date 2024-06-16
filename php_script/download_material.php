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

// Fetch all files from the database
$sql = "SELECT id, path FROM training";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $files = array();
    while ($row = $result->fetch_assoc()) {
        $files[] = array(
            'id' => $row['id'],
            'path' => $row['path'] // Assuming 'path' column stores relative paths like 'uploads/filename.pdf'
        );
    }
    header('Content-Type: application/json');
    echo json_encode($files);
} else {
    echo "No files found";
}

$conn->close();
?>
