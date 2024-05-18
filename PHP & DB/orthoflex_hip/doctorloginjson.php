<?php
include("dbconn.php");

// Read the raw input from the request body
$input = file_get_contents('php://input');
// Decode the JSON input into an associative array
$data = json_decode($input, true);

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if username and password are provided in the JSON data
    if (isset($data['username']) && isset($data['password'])) {
        $username = $data['username'];
        $password = $data['password'];

        // Assuming your dbconn.php file contains the mysqli connection

        // Check the connection
        if ($conn->connect_error) {
            $response['success'] = false;
            $response['message'] = "Connection failed: " . $conn->connect_error;
        } else {
            $sql = "SELECT * FROM `doctor` WHERE `username` = '$username' AND `password` = '$password'";
            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                // Fetch the row from the result
                $row = $result->fetch_assoc();

                $response['success'] = true;
                $response['message'] = "Login successful!";
                // Keep the fetched 'id' as a string
                $response['id'] = (int) $row['id'];
            } else {
                $response['success'] = false;
                $response['message'] = "Invalid username or password";
            }
        }
    } else {
        $response['success'] = false;
        $response['message'] = "Username and password parameters are required in the request body.";
    }
} else {
    $response['success'] = false;
    $response['message'] = "This endpoint only supports POST requests.";
}

// Close the database connection
$conn->close();

header('Content-Type: application/json');
echo json_encode($response);
?>
