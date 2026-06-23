<?php
header("Content-Type: application/json");
$file = "control.txt";
$resultado = [];

if (file_exists($file)) {
    $lineas = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lineas as $line) {
        $data = explode("|", $line);
        if (count($data) < 3) continue;
        $resultado[] = [
            "key"    => trim($data[0]),
            "ip"     => trim($data[1]),
            "estado" => trim($data[2]) // Aquí vendrá el texto "ACTIVADO"
        ];
    }
}
echo json_encode(["status" => "ok", "clientes" => $resultado]);