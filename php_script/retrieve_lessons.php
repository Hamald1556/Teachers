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

$sql = "SELECT lesson_title, author_name, lesson_description, lesson_materials FROM lesson";
$result = $conn->query($sql);

$lessons = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $lessons[] = $row;
    }
}

echo json_encode($lessons);

$conn->close();
?>
