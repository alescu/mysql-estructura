START TRANSACTION;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
ALTER DATABASE pizzeria COLLATE =utf8mb4_unicode_ci;

USE pizzeria;
SET GLOBAL default_storage_engine = InnoDB;


CREATE TABLE `customers` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `last_names` varchar(150) NOT NULL,
  `address_id` int(11)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `customer_id` int(11),
  `store_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `total_price` decimal(6,2) NOT NULL,
  `at_home` varchar(1) NOT NULL,
  `cooker`  int(11), -- Cuiner de la comanda
  `server`  int(11), -- Qui ha servit la comanda
  `status` ENUM('Pending', 'Confirmed', 'Preparing','Delivered','Canceled', 'Paied','Refunded') NOT NULL  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products_orders` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `price` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `delivery` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11),
  `worker_id` int(11) NOT NULL,
  `status` ENUM('Pending', 'Confirmed', 'Preparing','Delivered','Canceled', 'Paied in delivery') NOT NULL,
  `observations` varchar(300),
  `date` datetime NOT NULL,
  `at_home` varchar(1) NOT NULL  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `stores` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nif` varchar(50) NOT NULL, 
  `name` varchar(50) NOT NULL,
  `address_id` int(11)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `workers` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `store_id` int(11),
  `job_id` int(11),
  `nif` varchar(10) NOT NULL, 
  `name` varchar(50) NOT NULL,
  `lastnames` varchar(50) NOT NULL, 
  `address_id` int(11) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `product_type` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `description` varchar(50) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products_types` (
  `id` int(11) NOT NULL PRIMARY KEY  AUTO_INCREMENT,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products_categories` (
  `id` int(11) NOT NULL PRIMARY KEY  AUTO_INCREMENT,
  `product_type_id` int(11),
  `name` varchar(50) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs_category` (
  `id` int(11) NOT NULL PRIMARY KEY  AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL PRIMARY KEY  AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `postal_code` varchar(5) NOT NULL,
  `city_id` int(11) NOT NULL,  
  `phone_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `province_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `provinces` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- FK1
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customer_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

-- FK2                  
ALTER TABLE `delivery`
  ADD CONSTRAINT `fk_customer_delivery` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

-- FK3                
ALTER TABLE `products_orders`
  ADD CONSTRAINT `fk_products_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

-- FK4               
ALTER TABLE `products_orders`
  ADD CONSTRAINT `fk_order_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
  
-- FK5               
ALTER TABLE `products`
  ADD CONSTRAINT `fk_product_type` FOREIGN KEY (`product_type`) REFERENCES `products_types` (`id`);
 
-- FK6              
ALTER TABLE `cities`
  ADD CONSTRAINT `fk_province_code` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`);

-- FK7             
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);
 
-- FK8             
ALTER TABLE `delivery`
  ADD CONSTRAINT `fk_delivery_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
 
-- FK9             
ALTER TABLE `delivery`
  ADD CONSTRAINT `fk_delivery_worker` FOREIGN KEY (`worker_id`) REFERENCES `workers` (`id`);
 
-- FK10             
ALTER TABLE `workers`
  ADD CONSTRAINT `fk_worker_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);
 
-- FK11             
ALTER TABLE `workers`
  ADD CONSTRAINT `fk_worker_job_category` FOREIGN KEY (`job_id`) REFERENCES `jobs_category` (`id`);
 
-- FK12             
ALTER TABLE `stores` 
  ADD CONSTRAINT `fk_store_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

-- FK13             
ALTER TABLE `workers` 
  ADD CONSTRAINT `fk_worker_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

-- FK14             
ALTER TABLE `addresses` 
  ADD CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`);
  
-- FK15        
ALTER TABLE `products_categories` 
  ADD CONSTRAINT `fk_product_type_category` FOREIGN KEY (`product_type_id`) REFERENCES `products_types` (`id`);

COMMIT;  
