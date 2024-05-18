<?php
require("dbconn.php");

$response = array();

if (isset($_POST["video_name"]) && isset($_FILES["video_file"])) {
    $video_name = $_POST["video_name"];
    $fileName = $_FILES["video_file"]["name"];
    $fileName = str_replace(' ', '%20', $fileName); // Replace spaces with "%20"
    $tempName = $_FILES["video_file"]["tmp_name"];
    $folder = "video/" . $fileName; // Directory where the video will be stored

    // Insert the video into the database
    $insert_sql = "INSERT INTO video (video_name, video_file) VALUES ('$video_name', '$folder')";
    
    if ($conn->query($insert_sql) === TRUE) {
        // Move the uploaded video to the specified directory
        if (move_uploaded_file($tempName, $folder)) {
            $response['status'] = true;
            $response['message'] = 'Video uploaded successfully.';
        } else {
            $response['status'] = false;
            $response['message'] = 'Failed to move the uploaded video.';
        }
    } else {
        $response['status'] = false;
        $response['message'] = 'Data not inserted. Error: ' . $conn->error;
    }
} else {
    $response['status'] = false;
    $response['message'] = 'Invalid request.';
}

header('Content-Type: application/json');
echo json_encode($response);
?>
