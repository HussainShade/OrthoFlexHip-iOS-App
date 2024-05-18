<?php
include("dbconn.php");

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['username']) && isset($_POST['password'])) {
        $username = $_POST['username'];
        $password = $_POST['password'];

        // Assuming your dbconn.php file contains the mysqli connection

        // Check the connection (Note: We've removed the getDbConnection() function)
        if ($conn->connect_error) {
            $response['success'] = false;
            $response['message'] = "Connection failed: " . $conn->connect_error;
        } else {
            $sql = "SELECT * FROM `patient` WHERE `username` = '$username' AND `password` = '$password'";
            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                // Fetch the row from the result
                $row = $result->fetch_assoc();

                $response['success'] = true;
                $response['message'] = "Login successful!";
                // Cast the fetched 'id' as an integer
                $response['id'] = (int) $row['id'];
            } else {
                $response['success'] = false;
                $response['message'] = "Invalid username or password";
            }
        }
    } else {
        $response['success'] = false;
        $response['message'] = "Username and password parameters are required in the POST request data.";
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
