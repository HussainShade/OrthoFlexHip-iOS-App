<?php

require("dbconn.php");

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    // Check if patient_id is provided
    if (isset($_GET['patient_id'])) {
        $patient_id = $_GET['patient_id'];

        // Fetch appointments for the specified patient
        $query = "SELECT * FROM appointment WHERE patient_id = $patient_id ORDER BY schedule_date DESC, schedule_time DESC";
        $result = $conn->query($query);

        if ($result->num_rows > 0) {
            // Output data of each row
            $appointments = array();
            while ($row = $result->fetch_assoc()) {
                $appointments[] = $row;
            }
            echo json_encode(array("success" => true, "data" => $appointments));
        } else {
            echo json_encode(array("success" => false, "message" => "No appointments found for the specified patient."));
        }
    } else {
        echo json_encode(array("success" => false, "message" => "Please provide the patient_id parameter."));
    }
} else {
    header("HTTP/1.1 405 Method Not Allowed");
    exit;
}

$conn->close();
?>
