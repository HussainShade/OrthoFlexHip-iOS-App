<?php
// Require the database connection code
require "dbconn.php";

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Check if the doctor ID is provided in the request parameters
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        // Fetch specific doctor details from the database based on ID
        $sql = "SELECT id, username, name, profile_photo, age, gender, dob, mobile FROM doctor WHERE id = '$id'";
        $result = $conn->query($sql);

        if ($result) {
            // Check if any rows were returned
            if ($result->num_rows > 0) {
                // Doctor details found, return as JSON
                $doctorDetails = $result->fetch_assoc();
                header('Content-Type: application/json');
                echo json_encode(['success' => true, 'data' => $doctorDetails]);
            } else {
                // No doctor details found
                header('Content-Type: application/json');
                echo json_encode(['success' => false, 'error' => 'Doctor not found']);
            }
        } else {
            // Error in the SQL query
            header('Content-Type: application/json');
            echo json_encode(['success' => false, 'error' => 'Error executing SQL query: ' . $conn->error]);
        }
    } else {
        // Doctor ID not provided in the request
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'error' => 'Doctor ID is required']);
    }
} else {
    // Invalid request method
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'error' => 'Invalid request method']);
}

// Close the database connection
$conn->close();
?>
