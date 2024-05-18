<?php
require 'dbconn.php';

$response = array();

if ($conn->connect_error) {
    $response['status'] = false;
    $response['message'] = "Connection failed: " . $conn->connect_error;
} else {
    // Assuming you have received the user input in $_POST

    // You may want to perform additional validation for other fields
    $id = isset($_POST['id']) ? $_POST['id'] : null;
    $feedback = isset($_POST['feedback']) ? $_POST['feedback'] : null;

    if (empty($id) || empty($feedback)) {
        $response['status'] = false;
        $response['message'] = "ID or Feedback is empty or not set.";
    } else {
        // Use prepared statement to update data in the database
        $update_query = "UPDATE patient SET feedback = ? WHERE id = ?";

        $stmt = $conn->prepare($update_query);
        $stmt->bind_param("si", $feedback, $id);

        if ($stmt->execute()) {
            $response['status'] = true;
            $response['message'] = "Feedback updated successfully";
        } else {
            $response['status'] = false;
            $response['message'] = "Error updating data: " . $stmt->error;
        }

        $stmt->close();
    }
}

// Convert the response array to JSON
$json_response = json_encode($response);

// Output the JSON response
echo $json_response;

?>
