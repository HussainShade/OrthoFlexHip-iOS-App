<?php
require 'dbconn.php';

$response = array();

if ($conn->connect_error) {
    $response['success'] = false;
    $response['message'] = "Connection failed: " . $conn->connect_error;
} else {
    $patient_id = isset($_POST['patient_id']) ? $_POST['patient_id'] : null;
    $pain = isset($_POST['pain']) ? intval($_POST['pain']) : null;
    $distance_walked = isset($_POST['distance_walked']) ? intval($_POST['distance_walked']) : null;
    $activities = isset($_POST['activities']) ? intval($_POST['activities']) : null;
    $public_transportation = isset($_POST['public_transportation']) ? intval($_POST['public_transportation']) : null;
    $support = isset($_POST['support']) ? intval($_POST['support']) : null;
    $limp = isset($_POST['limp']) ? intval($_POST['limp']) : null;
    $stairs = isset($_POST['stairs']) ? intval($_POST['stairs']) : null;
    $sitting = isset($_POST['sitting']) ? intval($_POST['sitting']) : null;
    $section_2 = isset($_POST['section_2']) ? intval($_POST['section_2']) : null;
    $total_degree_of_flexion = isset($_POST['total_degree_of_flexion']) ? $_POST['total_degree_of_flexion'] : null;
    $total_degree_of_abduction = isset($_POST['total_degree_of_abduction']) ? $_POST['total_degree_of_abduction'] : null;
    $total_degree_of_ext_rotation = isset($_POST['total_degree_of_ext_rotation']) ? $_POST['total_degree_of_ext_rotation'] : null;
    $total_degree_of_adduction = isset($_POST['total_degree_of_adduction']) ? $_POST['total_degree_of_adduction'] : null;

    if (empty($patient_id)) {
        $response['success'] = false;
        $response['message'] = "Patient ID is empty or not set.";
    } else {
        // Calculate the overall score based on user input
        $score = calculateScore(
            $pain,
            $distance_walked,
            $activities,
            $public_transportation,
            $support,
            $limp,
            $stairs,
            $sitting,
            $section_2,
            $total_degree_of_flexion,
            $total_degree_of_abduction,
            $total_degree_of_ext_rotation,
            $total_degree_of_adduction
        );

        // Determine the score result based on the calculated score
        $score_result = determineScoreResult($score);

        // Use prepared statement to insert data into the database
        $insert_query = "INSERT INTO hipscore (patient_id, pain, distance_walked, activities, public_transportation, support, limp, stairs, sitting, section_2, total_degree_of_flexion, total_degree_of_abduction, total_degree_of_ext_rotation, total_degree_of_adduction, score, score_result) 
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $conn->prepare($insert_query);
        $stmt->bind_param("iiiiiiiiiiisssss", $patient_id, $pain, $distance_walked, $activities, $public_transportation, $support, $limp, $stairs, $sitting, $section_2, $total_degree_of_flexion, $total_degree_of_abduction, $total_degree_of_ext_rotation, $total_degree_of_adduction, $score, $score_result);

        if ($stmt->execute()) {
            $response['success'] = true;
            $response['message'] = "New Score Added successfully";
            $response['score'] = $score;
            $response['score_result'] = $score_result;
        } else {
            $response['success'] = false;
            $response['message'] = "Error inserting data: " . $stmt->error;
        }

        $stmt->close();
    }
}

// Convert the response array to JSON
$json_response = json_encode($response);

// Output the JSON response
echo $json_response;

// Function to calculate the overall score
function calculateScore($pain, $distance_walked, $activities, $public_transportation, $support, $limp, $stairs, $sitting, $section_2, $total_degree_of_flexion, $total_degree_of_abduction, $total_degree_of_ext_rotation, $total_degree_of_adduction) {
    // Add your logic here based on the selected options
    // You can customize the scoring based on your requirements
    // This is just a placeholder, replace it with your actual logic
    $score = 0;
    $score += $pain;
    $score += $distance_walked;
    $score += $activities;
    $score += $public_transportation;
    $score += $support;
    $score += $limp;
    $score += $stairs;
    $score += $sitting;
    $score += $section_2;
    $score += intval($total_degree_of_flexion);
    $score += intval($total_degree_of_abduction);
    $score += intval($total_degree_of_ext_rotation);
    $score += intval($total_degree_of_adduction);

    return $score;
}

// Function to determine the score result
function determineScoreResult($score) {
    // Determine the score result based on your conditions
    if ($score < 70) {
        return 'Poor';
    } elseif ($score >= 70 && $score < 80) {
        return 'Fair';
    } elseif ($score >= 80 && $score < 90) {
        return 'Good';
    } elseif ($score >= 90 && $score < 101) {
        return 'Excellent';
    } else {
        return 'Unknown'; // Adjust this as needed
    }
}

?>