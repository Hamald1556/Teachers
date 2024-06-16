<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';
require 'PHPMailer/src/Exception.php';

// Database connection parameters
$servername = "localhost";
$username = "root";
$password = ""; // Update with your MySQL password if needed
$database = "special_education";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the data from POST request
$email = $_POST['email'];

// Check if the email exists in the database
$sql = "SELECT * FROM teachers WHERE email = '$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Email exists, generate a new password
    $newPassword = bin2hex(random_bytes(4)); // Generate a random 8-character password
    $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);

    // Update the password in the database
    $updateSql = "UPDATE teachers SET password = '$hashedPassword' WHERE email = '$email'";
    if ($conn->query($updateSql) === TRUE) {
        // Send the new password to the user's email using PHPMailer
        $mail = new PHPMailer(true);
        try {
            //Server settings
            $mail->isSMTP();
            $mail->Host       = 'smtp.gmail.com';
            $mail->SMTPAuth   = true;
            $mail->Username   = 'tindwahamadi@gmail.com'; // Update with your Gmail email
            $mail->Password   = 'vqgo thlw eygc vjxx'; // Update with your Gmail password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
            $mail->Port       = 465;

            //Recipients
            $mail->setFrom('tindwahamadi@gmail.com', 'SpecialEducationTeachers App');
            $mail->addAddress($email);
            $mail->addReplyTo('tindwahamadi@gmail.com', 'Information');

            //Content
            $mail->isHTML(true);
            $mail->Subject = 'Password Reset';
            $mail->Body    = "Your new password is: $newPassword";
            $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

            $mail->send();
            echo json_encode(["result" => "A new password has been sent to your email address."]);
        } catch (Exception $e) {
            echo json_encode(["result" => "Message could not be sent. Mailer Error: {$mail->ErrorInfo}"]);
        }
    } else {
        echo json_encode(["result" => "Error updating password: " . $conn->error]);
    }
} else {
    // Email does not exist
    echo json_encode(["result" => "Email not found."]);
}

$conn->close();
?>
