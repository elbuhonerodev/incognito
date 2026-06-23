<?php
header("Content-Type: application/json");
date_default_timezone_set('America/Asuncion');

$file = "keys.txt";

if (!file_exists($file)) {
    echo json_encode(["status" => "error", "message" => "Archivo keys.txt no existe"]);
    exit;
}

$lineas = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
$resultado = [];

foreach ($lineas as $line) {
    $data = explode("|", $line);
    if (count($data) < 3) continue;

    $expira_timestamp = (int)trim($data[1]);

    $resultado[] = [
        "key" => trim($data[0]),
        "expira" => date("H:i:s", $expira_timestamp), // Mostrar hora de muerte de la key
        "estado" => trim($data[2]) // "DISPONIBLE"
    ];
}

echo json_encode([
    "status" => "ok",
    "total" => count($resultado),
    "keys" => $resultado
], JSON_PRETTY_PRINT);