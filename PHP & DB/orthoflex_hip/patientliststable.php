<?php
// Include the database configuration file
require 'dbconn.php';

// Function to fetch all patients with specific columns
function fetchAllPatients($conn) {
    // Check if the connection is valid
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch all patients with specific columns, ordered by admitted_date in descending order
    $sql = "SELECT id, name, problem, admitted_date, profile_photo FROM patient ORDER BY admitted_date DESC"; // Modified query
    $result = $conn->query($sql);

    // Check if there are rows in the result
    if ($result->num_rows > 0) {
        // Initialize an array to hold the data
        $data = array();

        // Fetch each row and add it to the data array
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        // Encode the entire data array as JSON
        $json_output['status'] = true;
        $json_output['data'] = $data;

        // Output the JSON response
        echo json_encode($json_output);
    } else {
        // Output a message if no rows are found
        echo json_encode(array("status" => "true", "message" => "No patients found"));
    }
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch all patients with specific columns
    fetchAllPatients($conn);
} else {
    // Output a message if the request method is not GET
    echo json_encode(array("status" => false, "message" => "Invalid request method"));
}

// Set the Content-Type header to indicate that JSON is being sent
header("Content-Type: application/json");
?>
