<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

require 'db.php';

$sql = "SELECT * FROM product";
$stmt = $pdo->query($sql);

$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
foreach ($products as &$product) {
    $product['product_id'] = (int)$product['product_id'];
    $product['price'] = (float)$product['price'];
    $product['warranty_period'] = (int)$product['warranty_period'];
}
echo json_encode($products);
?>
