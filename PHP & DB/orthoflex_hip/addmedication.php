<?php
require 'dbconn.php';

$response = array();

if ($conn->connect_error) {
    $response['status'] = false;
    $response['message'] = "Connection failed: " . $conn->connect_error;
} else {
    // Assuming you have received the user input in $_POST

    // You may want to perform additional validation for other fields
    $patient_id = isset($_POST['patient_id']) ? $_POST['patient_id'] : null;

    if (empty($patient_id)) {
        $response['status'] = false;
        $response['message'] = "Patient ID is empty or not set.";
    } else {
        $anti_edema_drugs = isset($_POST['anti_edema_drugs']) ? $_POST['anti_edema_drugs'] : null;
        $supportive_drugs = isset($_POST['supportive_drugs']) ? $_POST['supportive_drugs'] : null;
        $antibiotics = isset($_POST['antibiotics']) ? $_POST['antibiotics'] : null;
        $analgesics = isset($_POST['analgesics']) ? $_POST['analgesics'] : null;
        $antacids = isset($_POST['antacids']) ? $_POST['antacids'] : null;
        $tromboprophylaxis = isset($_POST['tromboprophylaxis']) ? $_POST['tromboprophylaxis'] : null;

        // Use prepared statement to insert data into the database
        $insert_query = "INSERT INTO medication (patient_id, anti_edema_drugs, supportive_drugs, antibiotics, analgesics, antacids, tromboprophylaxis) 
                        VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $conn->prepare($insert_query);
        $stmt->bind_param(
            "issssss",
            $patient_id,
            $anti_edema_drugs,
            $supportive_drugs,
            $antibiotics,
            $analgesics,
            $antacids,
            $tromboprophylaxis
        );

        if ($stmt->execute()) {
            $response['status'] = true;
            $response['message'] = "Medication added successfully";
        } else {
            $response['status'] = false;
            $response['message'] = "Error inserting data: " . $stmt->error;
        }

        $stmt->close();
    }
}

// Convert the response array to JSON
$json_response = json_encode($response);

// Output the JSON response
echo $json_response;

?>
