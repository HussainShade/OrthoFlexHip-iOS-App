<?php
// Include the database configuration file
require 'dbconn.php';

$response = array();

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch appointment details from the appointment table with status 'Pending'
    $sql = "SELECT id, patient_id, reason, request_date, schedule_date, schedule_time, status 
            FROM appointment 
            WHERE status = 'Pending' 
            ORDER BY schedule_date DESC";
    $result = $conn->query($sql);

    // Check if appointment details were found
    if ($result) {
        if ($result->num_rows > 0) {
            $appointments = array();
            while ($row = $result->fetch_assoc()) {
                $appointmentDetails = $row;
                $patient_id = $appointmentDetails['patient_id'];

                // Fetch patient details from the patient table based on patient_id from the appointment table
                $sql2 = "SELECT id, name, profile_photo FROM patient WHERE id = '$patient_id'";
                $result2 = $conn->query($sql2);

                // Check if patient details were found
                if ($result2) {
                    if ($result2->num_rows > 0) {
                        $patientDetails = $result2->fetch_assoc();

                        // Combine appointment and patient details into a single array
                        $combined_data = array(
                            'appointmentDetails' => $appointmentDetails,
                            'patientDetails' => $patientDetails
                        );

                        // Add combined data to the appointments array
                        $appointments[] = $combined_data;
                    } else {
                        // Set error response if no patient details found
                        $response['success'] = false;
                        $response['error'] = 'No patient details found for the provided appointment ID';
                        // Output the JSON response
                        echo json_encode($response);
                        // Close the database connection
                        $conn->close();
                        exit; // Terminate the script execution
                    }
                } else {
                    // Set error response if patient details query fails
                    $response['success'] = false;
                    $response['error'] = 'Error executing SQL query for patient details: ' . $conn->error;
                    // Output the JSON response
                    echo json_encode($response);
                    // Close the database connection
                    $conn->close();
                    exit; // Terminate the script execution
                }
            }
            // Set success response with the combined data
            $response['success'] = true;
            $response['data'] = $appointments;
        } else {
            // Set error response if no appointment details found
            $response['success'] = false;
            $response['error'] = 'No appointments found with status "Pending"';
        }
    } else {
        // Set error response if appointment details query fails
        $response['success'] = false;
        $response['error'] = 'Error executing SQL query for appointment details: ' . $conn->error;
    }
} else {
    // Set error response for invalid request method
    $response['success'] = false;
    $response['error'] = 'Invalid request method';
}

// Set the Content-Type header to indicate that JSON is being sent
header("Content-Type: application/json");

// Output the JSON response
echo json_encode($response);

// Close the database connection
$conn->close();
?>
