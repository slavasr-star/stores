CREATE TABLE `internet_store` (
  `store_id` INT PRIMARY KEY AUTO_INCREMENT,
  `email` VARCHAR(255),
  `delivery_payment` BOOLEAN
);

CREATE TABLE `product` (
  `product_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255),
  `brand` VARCHAR(100),
  `model` VARCHAR(100),
  `specs` TEXT,
  `price` DECIMAL(10,2),
  `warranty_period` INT,
  `image_url` TEXT
);

CREATE TABLE `store_product` (
  `store_id` INT,
  `product_id` INT,
  `Primary` Key(store_id,product_id)
);

CREATE TABLE `customer_order` (
  `order_id` INT PRIMARY KEY AUTO_INCREMENT,
  `store_id` INT,
  `product_id` INT,
  `order_date` DATE,
  `order_time` TIME,
  `quantity` INT,
  `customer_name` VARCHAR(255),
  `phone` VARCHAR(30),
  `confirmed` BOOLEAN
);

CREATE TABLE `delivery` (
  `order_id` INT PRIMARY KEY,
  `delivery_date` DATE,
  `delivery_time` TIME,
  `delivery_address` TEXT,
  `customer_name` VARCHAR(255),
  `courier_name` VARCHAR(255)
);

ALTER TABLE `store_product` ADD FOREIGN KEY (`store_id`) REFERENCES `internet_store` (`store_id`);

ALTER TABLE `store_product` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `customer_order` ADD FOREIGN KEY (`store_id`) REFERENCES `internet_store` (`store_id`);

ALTER TABLE `customer_order` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `delivery` ADD FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`order_id`);
