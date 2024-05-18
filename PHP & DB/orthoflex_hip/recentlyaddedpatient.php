<?php
// Include the database configuration file
require 'dbconn.php';

// Function to fetch the most recently added 5 patients with status and id
function fetchRecentPatients($conn) {
    // Check if the connection is valid
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch the most recently added 5 patients with status and id
    $sql = "SELECT id, name, admitted_date, discharge_date, profile_photo FROM patient ORDER BY id DESC LIMIT 5";
    $result = $conn->query($sql);

    // Check if there are rows in the result
    if ($result->num_rows > 0) {
        // Initialize an array to hold the data
        $data = array();

        // Fetch each row and add it to the data array
        while ($row = $result->fetch_assoc()) {
            // Determine the status based on the discharge date
            $status = (strtotime($row['discharge_date']) < strtotime(date('Y-m-d'))) ? 'Discharged' : 'Admitted';

            // Add the status and id to the row data
            $row['status'] = $status;

            $data[] = $row;
        }

        // Encode the entire data array as JSON
        $json_output['status'] = true;
        $json_output['data'] = $data;

        // Output the JSON response
        echo json_encode($json_output);
    } else {
        // Output a message if no rows are found
        echo json_encode(array("status" => "true", "message" => "No recent patients found"));
    }
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch most recently added 5 patients with status and id
    fetchRecentPatients($conn);
} else {
    // Output a message if the request method is not GET
    echo json_encode(array("status" => false, "message" => "Invalid request method"));
}

// Set the Content-Type header to indicate that JSON is being sent
header("Content-Type: application/json");
?>
