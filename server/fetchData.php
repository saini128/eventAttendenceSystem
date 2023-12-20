<?php
header('Content-Type: application/json');

$roll_no = $_POST['roll_no'] ?? null;

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
