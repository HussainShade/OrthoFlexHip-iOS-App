<?php
// Require the database connection code
require "dbconn.php";

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Check if the patient ID is provided in the request parameters
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        // Fetch specific patient details from the database based on ID
        $sql = "SELECT 
                    p.id, p.username, p.password, p.name, p.age, p.gender, p.mobile, p.hospital_id, 
                    p.height, p.weight, p.problem, p.admitted_date, p.discharge_date, p.feedback,
                    COALESCE(h.score, '') AS score, COALESCE(h.score_result, '') AS score_result
                FROM patient p
                LEFT JOIN hipscore h ON p.id = h.patient_id
                WHERE p.id = '$id'
                ORDER BY h.id DESC
                LIMIT 1"; // Select the score with the highest value of the "id" column

        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            // Fetch data from the result set
            $data = $result->fetch_assoc();

            // Set success response with the fetched data
            $response['success'] = true;
            $response['data'] = $data;
        } else {
            // Set error response if no data found for the provided patient ID
            $response['success'] = false;
            $response['message'] = 'No data found for the provided patient ID';
        }
    } else {
        // Set error response if patient_id parameter is not provided
        $response['success'] = false;
        $response['message'] = 'Patient ID parameter is required';
    }
} else {
    // Set error response for invalid request method
    $response['success'] = false;
    $response['message'] = 'Invalid request method';
} 

// Close the database connection
$conn->close();

// Send the JSON response
header('Content-Type: application/json');
echo json_encode($response);
?>
