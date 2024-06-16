<?php
if (isset($_GET['file'])) {
    $fileName = basename($_GET['file']);
    $filePath = '../uploads/' . $fileName; // Adjust to the actual server file system path

    if (file_exists($filePath)) {
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . basename($filePath) . '"');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($filePath));
        readfile($filePath);
        exit;
    } else {
        die('File not found: ' . $filePath);
    }
} else {
    die('Invalid request');
}
?>
