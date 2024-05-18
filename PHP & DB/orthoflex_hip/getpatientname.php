<?php
// Include the database configuration file
require 'dbconn.php';

// Function to fetch patient name based on id
function fetchPatientName($conn, $patientId) {
    // Check if the connection is valid
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch patient name based on id
    $sql = "SELECT id, name FROM patient WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $patientId);

    if ($stmt->execute()) {
        $result = $stmt->get_result();

        // Check if there are rows in the result
        if ($result->num_rows > 0) {
            // Fetch the row and add it to the data array
            $row = $result->fetch_assoc();

            // Encode the row data as JSON and output it
            echo json_encode($row);
        } else {
            // Output a message if no patient is found for the given id
            echo json_encode(array("message" => "No patient found for the given id"));
        }
    } else {
        // Output a message if there is an error executing the query
        echo json_encode(array("message" => "Error executing SQL query: " . $stmt->error));
    }

    $stmt->close();
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Assuming you receive the patient id as a query parameter
    $patientId = isset($_GET['id']) ? $_GET['id'] : null;

    if (!empty($patientId)) {
        // Fetch patient name based on id
        fetchPatientName($conn, $patientId);
    } else {
        // Output a message if the id parameter is not set
        echo json_encode(array("message" => "Patient id is empty or not set."));
    }
} else {
    // Output a message if the request method is not GET
    echo json_encode(array("message" => "Invalid request method"));
}

// Set the Content-Type header to indicate that JSON is being sent
header("Content-Type: application/json");
?>
