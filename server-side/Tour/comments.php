<?php
// MySQL server configuration
$servername = "sql213.epizy.com";
$username = "epiz_34339623";
$password = "qCtr4aQSeD";
$dbname = "epiz_34339623_tour_sites";


// Create a new PHP web page
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Handle a POST request to add a comment to a tour site
    $id = $_POST['id'];
    $comment = $_POST['comment'];
    $name = $_POST['name'];
    $date = date('Y-m-d H:i:s');

    // Connect to the MySQL server
    $conn = mysqli_connect($servername, $username, $password, $dbname);

    // Check connection
    if (!$conn) {
        http_response_code(500);
        die("Connection failed: " . mysqli_connect_error());
    }

    // Insert the new comment into the 'comments' table
    $sql = "INSERT INTO comments (comment, name, date, tour_site) VALUES ('$comment', '$name', '$date', '$id')";

    if (mysqli_query($conn, $sql)) {
        // Return a success response
        http_response_code(201);
        echo "Comment added successfully";
    } else {
        // Return an error response
        http_response_code(500);
        echo "Error adding comment: " . mysqli_error($conn);
    }

    // Close the MySQL connection
    mysqli_close($conn);
} else if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Handle a GET request to retrieve all comments for a tour site
    $id = $_GET['id'];

    // Connect to the MySQL server
    $conn = mysqli_connect($servername, $username, $password, $dbname);

    // Check connection
    if (!$conn) {
        http_response_code(500);
        die("Connection failed: " . mysqli_connect_error());
    }

    // Get all comments for the specified tour site from the 'comments' table
    $sql = "SELECT * FROM comments WHERE tour_site = '$id'";

    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        // Convert the comments to an array of objects
        $comments = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $comment = new stdClass();
            $comment->id = $row['id'];
            $comment->comment = $row['comment'];
            $comment->name = $row['name'];
            $comment->date = $row['date'];
            $comment->tour_site = $row['tour_site'];
            $comments[] = $comment;
        }

        // Return the comments as JSON
        header('Content-Type: application/json');
        echo json_encode($comments);
    } else {
        // Return an empty array if no comments were found
        header('Content-Type: application/json');
        echo json_encode(array());
    }

    // Close the MySQL connection
    mysqli_close($conn);
} else {
    // Return a 405 Method Not Allowed error for all other request methods
    http_response_code(405);
    header('Allow: GET, POST');
    echo "Method not allowed";
}