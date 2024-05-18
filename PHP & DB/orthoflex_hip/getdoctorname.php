<?php
// Include the database configuration file
require 'dbconn.php';

// Function to fetch doctor name based on id
function fetchDoctorName($conn, $doctorId) {
    // Check if the connection is valid
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch doctor name based on id
    $sql = "SELECT id, name FROM doctor WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $doctorId);

    if ($stmt->execute()) {
        $result = $stmt->get_result();

        // Check if there are rows in the result
        if ($result->num_rows > 0) {
            // Fetch the row and add it to the data array
            $row = $result->fetch_assoc();

            // Encode the row data as JSON and output it
            echo json_encode($row);
        } else {
            // Output a message if no doctor is found for the given id
            echo json_encode(array("message" => "No doctor found for the given id"));
        }
    } else {
        // Output a message if there is an error executing the query
        echo json_encode(array("message" => "Error executing SQL query: " . $stmt->error));
    }

    $stmt->close();
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Assuming you receive the doctor id as a query parameter
    $doctorId = isset($_GET['id']) ? $_GET['id'] : null;

    if (!empty($doctorId)) {
        // Fetch doctor name based on id
        fetchDoctorName($conn, $doctorId);
    } else {
        // Output a message if the id parameter is not set
        echo json_encode(array("message" => "Doctor id is empty or not set."));
    }
} else {
    // Output a message if the request method is not GET
    echo json_encode(array("message" => "Invalid request method"));
}

// Set the Content-Type header to indicate that JSON is being sent
header("Content-Type: application/json");
?>
