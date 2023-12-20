<?php
header('Content-Type: application/json');


if ($_SERVER['REQUEST_METHOD'] === 'POST')
{   
    $data = json_decode(file_get_contents('php://input'), true);
    $roll_no = $data['roll_no'] ?? null;   

    if ($roll_no === null) {
        echo json_encode(['error' => 'Roll number is required']);
        exit;
    }

    try {
        $mongoClient = new MongoDB\Client('mongodb://localhost:27017');
        $collection = $mongoClient->hacktu->participants; 
        $participant = $collection->findOne(['roll_no' => $roll_no]);

        if ($participant !== null) {
            echo json_encode($participant);
        } else {
            echo json_encode(['error' => 'Participant not found']);
        }
    } catch (Exception $e) {
        echo json_encode(['error' => 'Error fetching Participant data']);
    }
}
else {
    echo json_encode(['error' => 'Invalid request method']);
}
?>

