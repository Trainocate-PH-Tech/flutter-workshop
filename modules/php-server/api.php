<?php
// api.php — simple REST-like API

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");        // allow Flutter web
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST");

$db = new SQLite3('db.sqlite');

// ------------------------------
// GET /api.php → list todos
// ------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $result = $db->query("SELECT id, content FROM todos ORDER BY id DESC");

    $todos = [];
    while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
        $todos[] = $row;
    }

    echo json_encode($todos);
    exit;
}

// ------------------------------
// POST /api.php → create todo
// Expect JSON: { "content": "something" }
// ------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents("php://input"), true);

    if (!isset($input['content'])) {
        echo json_encode(["error" => "Missing content"]);
        exit;
    }

    $content = $db->escapeString($input['content']);
    $db->exec("INSERT INTO todos (content) VALUES ('$content')");

    echo json_encode(["success" => true]);
    exit;
}

echo json_encode(["error" => "Unsupported request"]);
