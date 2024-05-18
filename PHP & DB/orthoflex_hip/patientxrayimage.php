<?php
// Require the database connection code
require "dbconn.php";

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Check if the patient ID is provided in the request parameters
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        // Fetch specific patient details from the database based on ID
        $sql = "SELECT id, pre_xray_image, post_xray_image FROM patient WHERE id = '$id'";
        $result = $conn->query($sql);

        if ($result) {
            // Check if any rows were returned
            if ($result->num_rows > 0) {
                // Patient details found, return as JSON
                $patientDetails = $result->fetch_assoc();
                header('Content-Type: application/json');
                echo json_encode(['success' => true, 'data' => $patientDetails]);
            } else {
                // No patient details found
                header('Content-Type: application/json');
                echo json_encode(['success' => false, 'error' => 'Patient not found']);
            }
        } else {
            // Error in the SQL query
            header('Content-Type: application/json');
            echo json_encode(['success' => false, 'error' => 'Error executing SQL query: ' . $conn->error]);
        }
    } else {
        // Patient ID not provided in the request
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'error' => 'Patient ID is required']);
    }
} else {
    // Invalid request method
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'error' => 'Invalid request method']);
}

// Close the database connection
$conn->close();
?>
