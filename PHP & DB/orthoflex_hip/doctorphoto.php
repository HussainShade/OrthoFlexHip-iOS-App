<?php
require("dbconn.php");

$response = array();

if (isset($_POST["doctor_id"]) && isset($_FILES["profile_photo"])) {
    $doctor_id = $_POST["doctor_id"];
    $fileName = $_FILES["profile_photo"]["name"];
    $tempName = $_FILES["profile_photo"]["tmp_name"];
    $folder = "image/" . $fileName; // Directory where the image will be stored

    // Check if a record with the given doctor_id already exists
    $check_sql = "SELECT * FROM doctor WHERE id = '$doctor_id'";
    $check_result = $conn->query($check_sql);

    if ($check_result && $check_result->num_rows > 0) {
        // Update the existing record
        $update_sql = "UPDATE doctor SET profile_photo = '$folder' WHERE id = '$doctor_id'";
        
        if ($conn->query($update_sql) === TRUE) {
            // Move the uploaded file to the specified directory
            if (move_uploaded_file($tempName, $folder)) {
                $response['status'] = 'success';
                $response['message'] = 'Profile photo updated successfully.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Failed to move the uploaded file.';
            }
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Profile photo not updated. Error: ' . $conn->error;
        }
    } else {
        $response['status'] = 'error';
        $response['message'] = 'Doctor not found with ID: ' . $doctor_id;
    }
} else {
    $response['status'] = 'error';
    $response['message'] = 'Invalid request.';
}

header('Content-Type: application/json');
echo json_encode($response);
?>
