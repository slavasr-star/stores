-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 26 2025 г., 16:08
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `internet_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `customer_order`
--

CREATE TABLE `customer_order` (
  `order_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `order_time` time DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `confirmed` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `customer_order`
--

INSERT INTO `customer_order` (`order_id`, `store_id`, `product_id`, `order_date`, `order_time`, `quantity`, `customer_name`, `phone`, `confirmed`) VALUES
(1, 1, 1, '2025-05-22', '12:00:00', 1, 'Иванов Иван', '+79998887766', 1),
(2, 2, 3, '2025-05-21', '15:30:00', 2, 'Петрова Анна', '+79997776655', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `delivery`
--

CREATE TABLE `delivery` (
  `order_id` int(11) NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `delivery_time` time DEFAULT NULL,
  `delivery_address` text DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `courier_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `delivery`
--

INSERT INTO `delivery` (`order_id`, `delivery_date`, `delivery_time`, `delivery_address`, `customer_name`, `courier_name`) VALUES
(1, '2025-05-23', '18:00:00', 'ул. Ленина, 10', 'Иванов Иван', 'Курьер Сидоров');

-- --------------------------------------------------------

--
-- Структура таблицы `internet_store`
--

CREATE TABLE `internet_store` (
  `store_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `delivery_payment` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `internet_store`
--

INSERT INTO `internet_store` (`store_id`, `email`, `delivery_payment`) VALUES
(1, 'shop1@example.com', 1),
(2, 'shop2@example.com', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `specs` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `warranty_period` int(11) DEFAULT NULL,
  `image_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`product_id`, `name`, `brand`, `model`, `specs`, `price`, `warranty_period`, `image_url`) VALUES
(1, 'Электрочайник', 'Philips', 'HD9350', '1.7 л, нерж. сталь', 2990.00, 24, 'https://example.com/kettle.jpg'),
(2, 'Кухонный комбайн', 'Bosch', 'MUM4427', '500 Вт, 3.9 л, насадки', 8990.00, 36, 'https://example.com/processor.jpg'),
(3, 'Утюг', 'Mulinex', 'IM1234', 'Паровой, 2400 Вт', 3990.00, 24, 'https://example.com/iron.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `store_product`
--

CREATE TABLE `store_product` (
  `store_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `store_product`
--

INSERT INTO `store_product` (`store_id`, `product_id`) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `customer_order`
--
ALTER TABLE `customer_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`order_id`);

--
-- Индексы таблицы `internet_store`
--
ALTER TABLE `internet_store`
  ADD PRIMARY KEY (`store_id`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Индексы таблицы `store_product`
--
ALTER TABLE `store_product`
  ADD PRIMARY KEY (`store_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `customer_order`
--
ALTER TABLE `customer_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `internet_store`
--
ALTER TABLE `internet_store`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `customer_order`
--
ALTER TABLE `customer_order`
  ADD CONSTRAINT `customer_order_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `internet_store` (`store_id`),
  ADD CONSTRAINT `customer_order_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Ограничения внешнего ключа таблицы `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`order_id`);

--
-- Ограничения внешнего ключа таблицы `store_product`
--
ALTER TABLE `store_product`
  ADD CONSTRAINT `store_product_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `internet_store` (`store_id`),
  ADD CONSTRAINT `store_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
