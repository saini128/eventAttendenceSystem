<?php
header('Content-Type: application/json');

// Read request body
$requestBody = json_decode(file_get_contents('php://input'), true);

$roll_no = $requestBody['roll_no'] ?? null;
$attendance = $requestBody['attendance'] ?? null;

if ($roll_no === null || $attendance === null) {
    echo json_encode(['error' => 'Roll number and attendance status are required']);
    exit;
}

if (!is_bool($attendance)) {
    echo json_encode(['error' => 'Invalid attendance status']);
    exit;
}

try {
    $mongoClient = new MongoDB\Client('mongodb://localhost:27017');
    $collection = $mongoClient->hacktu->participants; 
    $result = $collection->updateOne(
        ['roll_no' => $roll_no],
        ['$set' => ['attendance' => $attendance]]
    );

    if ($result->getModifiedCount() > 0) {
        echo json_encode(['success' => true, 'message' => 'Attendance updated successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Participant not found or attendance already set to the specified value']);
    }
} catch (Exception $e) {
    echo json_encode(['error' => 'Error updating attendance']);
}
