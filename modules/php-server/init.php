<?php
// init.php — run this ONCE to create the database

$db = new SQLite3('db.sqlite');

// Create todos table
$db->exec("
CREATE TABLE IF NOT EXISTS todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT NOT NULL
)");

echo "Database and table created.";

