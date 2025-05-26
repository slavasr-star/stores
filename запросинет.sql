DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS customer_order;
DROP TABLE IF EXISTS store_product;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS internet_store;

CREATE TABLE internet_store (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    delivery_payment BOOLEAN
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    brand VARCHAR(100),
    model VARCHAR(100),
    specs TEXT,
    price DECIMAL(10,2),
    warranty_period INT,
    image_url TEXT
);

CREATE TABLE store_product (
    store_id INT,
    product_id INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES internet_store(store_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE customer_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    store_id INT,
    product_id INT,
    order_date DATE,
    order_time TIME,
    quantity INT,
    customer_name VARCHAR(255),
    phone VARCHAR(30),
    confirmed BOOLEAN,
    FOREIGN KEY (store_id) REFERENCES internet_store(store_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE delivery (
    order_id INT PRIMARY KEY,
    delivery_date DATE,
    delivery_time TIME,
    delivery_address TEXT,
    customer_name VARCHAR(255),
    courier_name VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id)
);

INSERT INTO internet_store (email, delivery_payment) VALUES
('shop1@example.com', TRUE),
('shop2@example.com', FALSE);

INSERT INTO product (name, brand, model, specs, price, warranty_period, image_url) VALUES
('Электрочайник', 'Philips', 'HD9350', '1.7 л, нерж. сталь', 2990.00, 24, 'https://example.com/kettle.jpg'),
('Кухонный комбайн', 'Bosch', 'MUM4427', '500 Вт, 3.9 л, насадки', 8990.00, 36, 'https://example.com/processor.jpg'),
('Утюг', 'Mulinex', 'IM1234', 'Паровой, 2400 Вт', 3990.00, 24, 'https://example.com/iron.jpg');

INSERT INTO store_product (store_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);

INSERT INTO customer_order (store_id, product_id, order_date, order_time, quantity, customer_name, phone, confirmed) VALUES
(1, 1, '2025-05-22', '12:00:00', 1, 'Иванов Иван', '+79998887766', TRUE),
(2, 3, '2025-05-21', '15:30:00', 2, 'Петрова Анна', '+79997776655', FALSE);

INSERT INTO delivery (order_id, delivery_date, delivery_time, delivery_address, customer_name, courier_name) VALUES
(1, '2025-05-23', '18:00:00', 'ул. Ленина, 10', 'Иванов Иван', 'Курьер Сидоров');

SELECT 
    p.brand,
    p.model,
    COUNT(co.order_id) AS total_orders
FROM 
    product p
JOIN 
    customer_order co ON p.product_id = co.product_id
GROUP BY 
    p.brand, p.model
ORDER BY 
    total_orders DESC;

SELECT 
    co.order_date,
    p.name AS product,
    COUNT(co.order_id) AS orders_count
FROM 
    customer_order co
JOIN 
    product p ON co.product_id = p.product_id
GROUP BY 
    co.order_date, p.name
ORDER BY 
    co.order_date;

SELECT 
    s.store_id,
    s.email,
    s.delivery_payment,
    COUNT(co.order_id) AS total_orders
FROM 
    internet_store s
JOIN 
    customer_order co ON s.store_id = co.store_id
GROUP BY 
    s.store_id;

SELECT 
    order_id,
    customer_name,
    order_date,
    order_time
FROM 
    customer_order
WHERE 
    confirmed = FALSE;

SELECT 
    d.order_id,
    d.customer_name,
    d.courier_name,
    d.delivery_date,
    d.delivery_time,
    d.delivery_address
FROM 
    delivery d
JOIN 
    customer_order co ON d.order_id = co.order_id
WHERE 
    co.confirmed = TRUE;

