<?php
// MySQL server configuration
$servername = "sql213.epizy.com";
$username = "epiz_34339623";
$password = "qCtr4aQSeD";
$dbname = "epiz_34339623_tour_sites";

// Array of tour sites to be added
$tourSites = [
    [
        "name" => "Danakil Depression",
        "description" => "The Danakil Depression is one of the hottest and lowest places on Earth. It is known for its otherworldly landscapes, including sulfur lakes, active volcanoes, and colorful mineral deposits.",
        "coordinates" => [14.2417, 40.3025],
        "category" => "Natural Wonders",
        "image" => "1.Danakil.jpg"
    ],
    [
        "name" => "Lalibela",
        "description" => "Lalibela is a UNESCO World Heritage Site famous for its rock-hewn churches. These impressive structures were carved out of solid rock in the 12th century and are considered masterpieces of Ethiopian architecture.",
        "coordinates" => [12.0319, 39.0375],
        "category" => "Historical and Cultural Sites",
        "image" => "2.Lalibela.jpg"
    ],
    [
        "name" => "Harar wall",
        "description" => "The Harar wall is an ancient defensive wall surrounding the city of Harar in eastern Ethiopia. Built in the 16th century, it has several gates and watchtowers, and it is a symbol of the city's rich history.",
        "coordinates" => [9.3136, 42.1186],
        "category" => "Historical and Cultural Sites",
        "image" => "3.Harar.jpg"
    ],
    [
        "name" => "Simien Mountains National Park",
        "description" => "Simien Mountains National Park is a UNESCO World Heritage Site and offers breathtaking scenery with its jagged mountain peaks, deep valleys, and unique wildlife. It is home to several endangered species, including the Ethiopian wolf and the Walia ibex.",
        "coordinates" => [13.1500, 38.2167],
        "category" => "Wildlife and National Parks",
        "image" => "4.Semien.jpg"
    ],
    [
        "name" => "Omo National Park and River",
        "description" => "Omo National Park and River are located in southwestern Ethiopia and are known for their rich biodiversity and cultural significance. The park is home to various wildlife species, and the Omo River is a lifeline for indigenous tribes living in the region.",
        "coordinates" => [5.8236, 35.0971],
        "category" => "Wildlife and National Parks",
        "image" => "5.Omopark.png"
    ],
    [
        "name" => "National Museum of Ethiopia",
        "description" => "The National Museum of Ethiopia in Addis Ababa houses a vast collection of archaeological artifacts, ancient manuscripts, and artwork. It is best known for hosting the fossilized remains of 'Lucy,' a 3.2-million-year-old hominin.",
        "coordinates" => [9.0251, 38.7462],
        "category" => "Museums",
        "image" => "6.National.png"
    ],
    [
        "name" => "Mount Entoto",
        "description" => "Mount Entoto is the highest peak overlooking the city of Addis Ababa. It offers panoramic views of the city and is a popular destination for hiking and picnicking. At the summit, you can find St. Mary's Church, which is of historical and religious significance.",
        "coordinates" => [9.0119, 38.7859],
        "category" => "Natural Wonders",
        "image" => "7.Entoto.jpeg"
    ],
    [
        "name" => "Abay River",
        "description" => "The Abay River, also known as the Blue Nile, is one of the major rivers in Ethiopia. It originates from Lake Tana and flows through impressive gorges and waterfalls, including the famous Blue Nile Falls (Tis Issat) near Bahir Dar.",
        "coordinates" => [11.8541, 37.3679],
        "category" => "Natural Wonders",
        "image" => "8.Abay.jpg"
    ],
    [
        "name" => "Axum Obelisk",
        "description" => "The Axum Obelisk is a tall granite stele located in the ancient city of Axum. It is one of several obelisks that once stood as symbols of the Axumite Empire. The obelisk is intricately carved and serves as a testament to the region's rich history.",
        "coordinates" => [14.1326, 38.7157],
        "category" => "Historical and Cultural Sites",
        "image" => "9.Axum.jpg"
    ],
    [
        "name" => "Fasilides Castle",
        "description" => "Fasilides Castle, also known as Fasil Ghebbi, is a fortress-like complex located in Gondar. It was built in the 17th century by Emperor Fasilides and served as the royal residence and administrative center. Today, it is a UNESCO World Heritage Site and a major tourist attraction.",
        "coordinates" => [12.6063, 37.4688],
        "category" => "Historical and Cultural Sites",
        "image" => "10.Fasil.jpg"
    ]
];

// Connect to the database
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Loop through the tour sites and add them to the database with sequential IDs
$id = 1;
foreach ($tourSites as $tourSite) {
    $name = $conn->real_escape_string($tourSite["name"]);
    $description = $conn->real_escape_string($tourSite["description"]);
    $location = $tourSite["coordinates"];
    $category = $conn->real_escape_string($tourSite["category"]);
    $image = $conn->real_escape_string($tourSite["image"]);
    // Convert coordinates array to a string representation
    $point = "POINT(" . $location[0] . " " . $location[1] . ")";

    echo $image;
    $sql = "INSERT INTO sites (id, site_name, description, location, category, photo) VALUES ('$id', '$name', '$description', GeomFromText('$point') , '$category', '$image')";
    if ($conn->query($sql) === TRUE) {
        echo "Tour site added successfully";
    } else {
        echo "Error adding tour site: " . $conn->error;
    }
    
    $id++;
}

// Close the database connection
$conn->close();
?>