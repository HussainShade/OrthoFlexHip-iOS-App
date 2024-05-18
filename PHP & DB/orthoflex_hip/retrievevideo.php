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

    // Prepare SQL statement to fetch all data from the 'video' table
    $sql = "SELECT * FROM video";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();

    // Fetch all the results
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($results) {
        // Data found, construct the response
        $response = array(
            'status' => true,
            'data' => $results
        );
    } else {
        // No data found in the 'video' table
        $response = array(
            'status' => false,
            'message' => 'No data found in the video table'
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
