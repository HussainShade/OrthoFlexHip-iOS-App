<?php
require("dbconn.php");

$response = array();

if (isset($_POST["patient_id"]) && isset($_FILES["discharge_summary_pdf"])) {
    $patient_id = $_POST["patient_id"];
    $fileName = $_FILES["discharge_summary_pdf"]["name"];
    $tempName = $_FILES["discharge_summary_pdf"]["tmp_name"];
    $folder = "discharge_summary/" . $fileName; // Directory where the PDF will be stored

    // Check if a record with the given patient_id already exists
    $check_sql = "SELECT * FROM patient WHERE id = '$patient_id'";
    $check_result = $conn->query($check_sql);

    if ($check_result && $check_result->num_rows > 0) {
        // Update the existing record
        $update_sql = "UPDATE patient SET discharge_summary_pdf = '$folder' WHERE id = '$patient_id'";
        
        if ($conn->query($update_sql) === TRUE) {
            // Move the uploaded file to the specified directory
            if (move_uploaded_file($tempName, $folder)) {
                $response['status'] = 'success';
                $response['message'] = 'Discharge summary uploaded successfully.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Failed to move the uploaded file.';
            }
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Data not updated. Error: ' . $conn->error;
        }
    } else {
        // Insert a new record
        $insert_sql = "INSERT INTO patient (id, discharge_summary_pdf) VALUES ('$patient_id', '$folder')";
        
        if ($conn->query($insert_sql) === TRUE) {
            // Move the uploaded file to the specified directory
            if (move_uploaded_file($tempName, $folder)) {
                $response['status'] = 'success';
                $response['message'] = 'Data inserted successfully.';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Failed to move the uploaded file.';
            }
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Data not inserted. Error: ' . $conn->error;
        }
    }
} else {
    $response['status'] = 'error';
    $response['message'] = 'Invalid request.';
}

header('Content-Type: application/json');
echo json_encode($response);
?>
