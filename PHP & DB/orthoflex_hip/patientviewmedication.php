<?php
// Require the database connection code
require "dbconn.php";

// Initialize response array
$response = array();

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Check if the patient id is provided in the request parameters
    if (isset($_GET['patient_id'])) {
        $patient_id = $_GET['patient_id'];

        // Fetch specific patient details from the database based on patient_id
        $sql = "SELECT * FROM medication WHERE patient_id = ? ORDER BY id DESC LIMIT 1";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $patient_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result) {
            // Check if any rows were returned
            if ($result->num_rows > 0) {
                // Patient details found, return as JSON
                $patientDetails = $result->fetch_assoc();
                $response['success'] = true;
                $response['data'] = $patientDetails;
            } else {
                // No patient details found
                $response['success'] = false;
                $response['error'] = 'Patient not found';
            }
        } else {
            // Error in the SQL query
            $response['success'] = false;
            $response['error'] = 'Error executing SQL query';
        }
        $stmt->close();
    } else {
        // Patient id not provided in the request
        $response['success'] = false;
        $response['error'] = 'Patient id is required';
    }
} else {
    // Invalid request method
    $response['success'] = false;
    $response['error'] = 'Invalid request method';
}

// Close the database connection
$conn->close();

// Output JSON response
echo json_encode($response);
?>
