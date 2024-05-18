<?php
// Include the database configuration file
require 'dbconn.php';

// Function to insert data into the 'patient' table
function insertData($username, $password, $name, $age, $gender, $height, $weight, $problem, $admitted_date, $discharge_date, $hospital_id, $mobile, $conn) {
    // Check if the connection is valid
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "INSERT INTO patient (username, password, name, age, gender, height, weight, problem, admitted_date, discharge_date, hospital_id, mobile, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Admitted')";
    $stmt = $conn->prepare($sql);

    // Check if the statement is valid
    if ($stmt) {
        $stmt->bind_param("sssssssssssi", $username, $password, $name, $age, $gender, $height, $weight, $problem, $admitted_date, $discharge_date, $hospital_id, $mobile);

        if ($stmt->execute()) {
            // Get the ID of the inserted patient
            $patient_id = $stmt->insert_id;
            return $patient_id;
        } else {
            return false;
        }
    } else {
        die("Error in prepared statement: " . $conn->error);
    }
}

// Function to update patient status to 'Discharged' if discharge date has passed
function updatePatientStatus($conn) {
    $current_date = date('Y-m-d');
    $sql = "UPDATE patient SET status = 'Discharged' WHERE discharge_date < '$current_date' AND status = 'Admitted'";
    if ($conn->query($sql) === TRUE) {
        // Do nothing, status updated successfully
    } else {
        echo json_encode(array("status" => false, "data" => "Error updating patient status: " . $conn->error));
        exit; // Stop execution after sending response
    }
}

// Check if data is received via POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Extract form data
    $username = $_POST['username'];
    $password = $_POST['password'];
    $name = $_POST['name'];
    $age = $_POST['age'];
    $gender = $_POST['gender'];
    $height = $_POST['height'];
    $weight = $_POST['weight'];
    $problem = $_POST['problem'];
    $admitted_date = $_POST['admitted_date'];
    $discharge_date = $_POST['discharge_date'];
    $hospital_id = $_POST['hospital_id'];
    $mobile = $_POST['mobile'];

    // Insert data into the patient table
    $inserted_patient_id = insertData($username, $password, $name, $age, $gender, $height, $weight, $problem, $admitted_date, $discharge_date, $hospital_id, $mobile, $conn);

    if ($inserted_patient_id !== false) {
        // Update patient status if discharge date has passed
        updatePatientStatus($conn);
        // Return success response with patient ID
        echo json_encode(array("status" => true, "data" => "Patient Added Successfully", "patient_id" => $inserted_patient_id));
    } else {
        // Return error response
        echo json_encode(array("status" => false, "data" => "Error inserting data"));
    }
} else {
    // Invalid request method
    echo json_encode(array("status" => false, "data" => "This endpoint only supports POST requests."));
}

// Close the database connection
$conn->close();
?>
