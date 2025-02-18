-- SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
-- SET time_zone = "+00:00";

CREATE DATABASE optica CHARACTER SET utf8mb4;
ALTER DATABASE optica COLLATE =utf8mb4_unicode_ci;

USE optica;
SET GLOBAL default_storage_engine = InnoDB;

CREATE TABLE `providers` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `address_id` int(11),
  `phone_number` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `nif` varchar(10) DEFAULT NULL,
  `reg_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customers` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address_id` int(11),
  `email` varchar(100) NOT NULL,
  `reg_date` int(11) NOT NULL DEFAULT current_timestamp(),
  `nif` varchar(10) NOT NULL UNIQUE,
  `reco_customer` int(11) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `street` varchar(100) DEFAULT NULL,
  `number` tinyint(4) DEFAULT NULL,
  `floor` varchar(5) DEFAULT NULL,
  `door` varchar(5) DEFAULT NULL,
  `postal_code` varchar(5) DEFAULT NULL,
  `country` varchar(110) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `employees` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `reg_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `glasses` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `brand` varchar(100) NOT NULL,
  `glass_graduation_left` decimal(3,2) DEFAULT NULL,
  `glass_graduation_right` decimal(3,2) DEFAULT NULL,
  `glass_color_right` decimal(3,2) NOT NULL,
  `glass_color_left` decimal(3,2) NOT NULL,
  `mount_type` int(11) DEFAULT NULL,
  `reg_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `price` decimal(10,2) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `mount_types` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL,
  `reg_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sales` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `id_customer` int(11) NOT NULL,
  `id_employee` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `reg_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `basket` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `id_glasses` int(11) NOT NULL,
  `amount` int(3) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `reg_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `customers` 
  ADD CONSTRAINT `fk_customer_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `fk_customer_reco` FOREIGN KEY (`reco_customer`) REFERENCES `customers` (`id`);

ALTER TABLE `providers`
  ADD CONSTRAINT `fk_provider_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

ALTER TABLE `sales`
  ADD CONSTRAINT `fk_sale_customer` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `fk_sale_employee` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id`);

ALTER TABLE `basket`
  ADD CONSTRAINT `fk_sale_glasses` FOREIGN KEY (`id_glasses`) REFERENCES `glasses` (`id`),
  ADD CONSTRAINT `fk_sale_basket` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`);
  
ALTER TABLE `glasses`
  ADD CONSTRAINT `fk_glasses_provider` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`),
  ADD CONSTRAINT `fk_glasses_mount` FOREIGN KEY (`mount_type`) REFERENCES `mount_types` (`id`);

COMMIT;

