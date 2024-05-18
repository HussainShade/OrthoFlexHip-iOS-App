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

    // Check if the 'id' parameter is set in the GET request
    if(isset($_GET['id'])) {
        $id = $_GET['id'];

        // Prepare SQL statement to fetch data from the 'patient' table based on 'id'
        $sql = "SELECT pre_xray_image, post_xray_image FROM patient WHERE id = :id";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        // Fetch the result
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result) {
            // Data found, construct the response
            $response = array(
                'status' => 'success',
                'data' => $result
            );
        } else {
            // No data found with the given id
            $response = array(
                'status' => 'failure',
                'message' => 'No data found with the given id'
            );
        }
    } else {
        // 'id' parameter not set in the GET request
        $response = array(
            'status' => 'failure',
            'message' => 'No id parameter provided'
        );
    }
} catch(PDOException $e) {
    // If an error occurs, catch it and echo the error message
    $response = array(
        'status' => 'failure',
        'message' => 'Error: ' . $e->getMessage()
    );
}

// Output the JSON response
header('Content-Type: application/json');
echo json_encode($response);

// Close the database connection
$pdo = null;
?>
