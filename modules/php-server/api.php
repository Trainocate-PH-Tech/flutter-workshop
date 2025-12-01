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
    if (isset($_GET['id'])) {
        $query = $db->prepare("SELECT id, content FROM todos WHERE id = :id LIMIT 1");
        $query->bindValue(":id", (int)$_GET['id'], SQLITE3_INTEGER);

        $todo = $query->execute()->fetchArray(SQLITE3_ASSOC);
        if ($todo === false) {
            echo json_encode(["error" => "Todo not found"]);
        } else {
            echo json_encode($todo);
        }
        exit;
    }

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
