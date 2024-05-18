<?php
// Include the database configuration file
require 'dbconn.php';

$response = array();

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch appointment details from the appointment table with status 'Pending'
    $sql = "SELECT appointment.id, appointment.patient_id, appointment.reason, appointment.request_date, appointment.schedule_date, appointment.schedule_time, appointment.status, patient.name, patient.profile_photo
            FROM appointment
            LEFT JOIN patient ON appointment.patient_id = patient.id
            WHERE appointment.status = 'Pending'
            ORDER BY appointment.schedule_date DESC";
    $result = $conn->query($sql);

    // Check if appointment details were found
    if ($result) {
        if ($result->num_rows > 0) {
            $appointments = array();
            while ($row = $result->fetch_assoc()) {
                // Combine appointment and patient details into a single array
                $appointment = array(
                    'id' => $row['id'],
                    'patient_id' => $row['patient_id'],
                    'reason' => $row['reason'],
                    'request_date' => $row['request_date'],
                    'schedule_date' => $row['schedule_date'],
                    'schedule_time' => $row['schedule_time'],
                    'status' => $row['status'],
                    'name' => $row['name'],
                    'patient_photo' => $row['profile_photo']
                );

                // Add combined data to the appointments array
                $appointments[] = $appointment;
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
