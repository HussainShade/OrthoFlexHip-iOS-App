<?php
// Require the database connection code
require "dbconn.php";

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Check if the patient ID is provided in the request parameters
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        // Fetch specific patient details from the database based on ID
        $sql1 = "SELECT id, username, password, name, age, gender, mobile, hospital_id, height, weight, problem, admitted_date, discharge_date, feedback FROM patient WHERE id = '$id'";
        $result1 = $conn->query($sql1);

        // Fetch patient's hipscore if available
        $sql2 = "SELECT id, patient_id, COALESCE(score, '') AS score, COALESCE(score_result, '') AS score_result 
                FROM hipscore 
                WHERE patient_id = '$id' 
                ORDER BY id DESC 
                LIMIT 1";
        $result2 = $conn->query($sql2);

        if ($result1->num_rows > 0) {
            // Fetch data from the result set for patient details
            $data1 = array();
            while($row = $result1->fetch_assoc()) {
                $data1[] = $row;
            }

            // Fetch data from the result set for hipscore details
            $data2 = array();
            while($row = $result2->fetch_assoc()) {
                $data2[] = $row;
            }

            // Combine the data from both tables into a single array
            $combined_data = array(
                'patientdetails' => $data1,
                'patientscore' => $data2
            );

            // Set success response with the combined data
            $response['success'] = true;
            $response['data'] = $combined_data;
        } else {
            // Set error response if no data found for the provided patient ID in either table
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
