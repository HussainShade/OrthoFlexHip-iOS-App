<?php
// Define database connection details
$host = "localhost";
$username = "root";
$password = "";
$dbname = "orthoflexhip_db";

try {
    // Establish a connection to the database
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // Set the PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Check if patient_id parameter is provided
    if (isset($_GET['patient_id'])) {
        $patient_id = $_GET['patient_id'];
        
        // Prepare SQL statement to fetch discharge_summary_pdf based on patient_id
        $sql = "SELECT discharge_summary_pdf FROM patient WHERE id = :patient_id";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':patient_id', $patient_id, PDO::PARAM_INT);
        $stmt->execute();

        // Fetch the result
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result) {
            // Data found, construct the response
            $response = array(
                'status' => true,
                'data' => $result['discharge_summary_pdf']
            );
        } else {
            // No data found for the provided patient_id
            $response = array(
                'status' => false,
                'message' => 'No discharge summary PDF found for the provided patient ID'
            );
        }
    } else {
        // No patient_id parameter provided in the request
        $response = array(
            'status' => false,
            'message' => 'Please provide patient_id parameter'
        );
    }
} catch(PDOException $e) {
    // If an error occurs, catch it and echo the error message
    $response = array(
        'status' => false,
        'message' => 'Error: ' . $e->getMessage()
    );
}

// Output the JSON response
header('Content-Type: application/json');
echo json_encode($response);

// Close the database connection
$pdo = null;
?>
