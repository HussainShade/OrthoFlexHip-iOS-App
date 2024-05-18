<?php

// Include the database connection
require 'dbconn.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Doctor changes the status of an appointment

    // Retrieve form data
    $appointment_id = $_POST['appointment_id'];
    $status = $_POST['status'];

    // Check if the required fields are set in the POST data
    if (isset($appointment_id) && isset($status)) {
        // Check if the provided status is valid
        if ($status === 'Approved' || $status === 'Rejected') {
            // Check if the appointment_id exists in the appointment table
            $checkQuery = "SELECT * FROM appointment WHERE id = '$appointment_id'";
            $checkResult = $conn->query($checkQuery);

            if ($checkResult->num_rows > 0) {
                // Appointment ID exists, proceed with the update
                $sql = "UPDATE appointment SET status = '$status' WHERE id = '$appointment_id'";

                $response = array();
                if ($conn->query($sql) === TRUE) {
                    $response["success"] = true;
                    $response["message"] = "Appointment status updated successfully.";
                } else {
                    $response["success"] = false;
                    $response["message"] = "Error: " . $sql . "<br>" . $conn->error;
                }
            } else {
                // Appointment ID does not exist
                $response["success"] = false;
                $response["message"] = "Error: Appointment with ID $appointment_id does not exist.";
            }
        } else {
            $response["success"] = false;
            $response["message"] = "Error: Invalid status provided. Status should be either 'Approved' or 'Rejected'.";
        }
    } else {
        $response["success"] = false;
        $response["message"] = "Error: Required fields are not set in the POST data.";
    }

    echo json_encode($response);

} else {
    // Invalid request
    echo json_encode(array("success" => false, "message" => "Invalid request."));
}

$conn->close();

?>
