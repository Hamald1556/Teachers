<?php
// Database connection parameters
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

// SQL query to retrieve resource names and descriptions
$sql = "SELECT resource_name, resource_description FROM resources";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Fetch result rows as an associative array
    $rows = array();
    while ($row = $result->fetch_assoc()) {
        $rows[] = $row;
    }
    
    // Convert the associative array to JSON and output it
    echo json_encode($rows);
} else {
    echo "0 results";
}

// Close connection
$conn->close();
?>
