<?php
// MySQL server configuration
$servername = "sql213.epizy.com";
$username = "epiz_34339623";
$password = "qCtr4aQSeD";
// $dbname = "epiz_34339623_tour_sites";

// Connect to MySQL server
$conn = mysqli_connect($servername, $username, $password);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Create the database
$sql = "CREATE DATABASE IF NOT EXISTS tour_sites";
if (mysqli_query($conn, $sql)) {
    echo "Database created successfully\n";
} else {
    echo "Error creating database: " . mysqli_error($conn) . "\n";
}

// Select the database
mysqli_select_db($conn, "tour_sites");

// Create the sites table
$sql = "CREATE TABLE IF NOT EXISTS sites (
        id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        site_name VARCHAR(255) NOT NULL,
        location POINT NOT NULL,
        description TEXT NOT NULL,
        photo VARCHAR(255) NOT NULL,
        category VARCHAR(255) NOT NULL
        )";

if (mysqli_query($conn, $sql)) {
    echo "Table 'sites' created successfully\n";
} else {
    echo "Error creating table 'sites': " . mysqli_error($conn) . "\n";
}

// Create the comments table
$sql = "CREATE TABLE IF NOT EXISTS comments (
        id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        comment TEXT NOT NULL,
        name VARCHAR(255) NOT NULL,
        date DATE NOT NULL,
        tour_site INT(11) NOT NULL,
        FOREIGN KEY (tour_site) REFERENCES sites(id)
        )";

if (mysqli_query($conn, $sql)) {
    echo "Table 'comments' created successfully\n";
} else {
    echo "Error creating table 'comments': " . mysqli_error($conn) . "\n";
}

// Close the connection
mysqli_close($conn);
?>