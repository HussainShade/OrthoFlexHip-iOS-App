<?php

require("dbconn.php");

function isSlotAvailable($conn, $patientId, $scheduleDate, $scheduleTime)
{
    // Check if the total count of appointments for the given slot is less than 5
    $query = "SELECT COUNT(*) as count FROM appointment WHERE schedule_date = '$scheduleDate' AND schedule_time = '$scheduleTime' AND status IN ('Approved', 'Pending')";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $count = $row['count'];

        if ($count >= 5) {
            return false; // Slot is not available
        }

        // Check if the patient already has an appointment at the specified date and time
        $query = "SELECT COUNT(*) as patientCount FROM appointment WHERE patient_id = $patientId AND schedule_date = '$scheduleDate' AND schedule_time = '$scheduleTime'";
        $result = $conn->query($query);
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $patientCount = $row['patientCount'];

            return $patientCount == 0; // Return true if patient does not have an appointment at the specified date and time
        }
    }

    return false;
}

function updateStatus($conn)
{
    // Update the status of appointments to 'Completed' if the scheduled time has passed
    $currentDateTime = date("Y-m-d H:i:s");
    $updateQuery = "UPDATE appointment SET status = 'Completed' WHERE CONCAT(schedule_date, ' ', schedule_time) < '$currentDateTime' AND status = 'Pending'";
    if ($conn->query($updateQuery) === TRUE) {
        // echo "Status updated successfully"; // Commented out to prevent this message from being included in the response
    } else {
        echo "Error updating status: " . $conn->error;
    }
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve values from form-data
    $patientId = $_POST['patient_id'];
    $doctorId = $_POST['doctor_id'];
    $scheduleDate = $_POST['schedule_date'];
    $scheduleTime = $_POST['schedule_time'];
    $reason = $_POST['reason'];
    $requestDate = date("Y-m-d");
    $status = "Pending";

    // Check if the requested date is not a Sunday
    $requestedDayOfWeek = date('l', strtotime($scheduleDate));
    if ($requestedDayOfWeek === 'Sunday') {
        $response = array("success" => false, "data" => "Appointments cannot be scheduled on Sundays.");
        echo json_encode($response);
        exit;
    }

    // Check if the slot is available and patient does not have an appointment at the specified date and time
    if (isSlotAvailable($conn, $patientId, $scheduleDate, $scheduleTime)) {
        // Update status before inserting new appointment
        updateStatus($conn);

        // Insert new appointment
        $query = "INSERT INTO appointment (patient_id, doctor_id, schedule_date, schedule_time, reason, request_date, status)
                  VALUES ($patientId, $doctorId, '$scheduleDate', '$scheduleTime', '$reason', '$requestDate', '$status')";

        if ($conn->query($query) === TRUE) {
            $response = array("success" => true, "data" => "Appointment scheduled successfully");
            echo json_encode($response);
        } else {
            $response = array("success" => false, "data" => "Error scheduling appointment: " . $conn->error);
            echo json_encode($response);
        }
    } else {
        $response = array("success" => false, "data" => "Appointment is already booked today or slot not available. Please choose a different time.");
        echo json_encode($response);
    }

    $conn->close();
} else {
    header("HTTP/1.1 405 Method Not Allowed");
    exit;
}
?>
