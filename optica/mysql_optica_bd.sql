-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Temps de generació: 11-02-2025 a les 18:21:13
-- Versió del servidor: 10.4.32-MariaDB
-- Versió de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE optica CHARACTER SET utf8mb4;
ALTER DATABASE optica COLLATE =utf8mb4_unicode_ci;

USE optica;

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `street` varchar(100) DEFAULT NULL,
  `number` tinyint(4) DEFAULT NULL,
  `floor` varchar(5) DEFAULT NULL,
  `door` varchar(5) DEFAULT NULL,
  `postal_code` varchar(5) DEFAULT NULL,
  `country` varchar(110) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `providers` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address_id` int(11) NOT NULL,
  `telephon` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `nif` varchar(10) DEFAULT NULL,
  `reg_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `reg_date` int(11) NOT NULL DEFAULT current_timestamp(),
  `nif` varchar(10) NOT NULL,
  `reco_customer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `reg_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `glasses` (
  `id` int(11) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `glass_graduation_left` decimal(3,2) DEFAULT NULL,
  `glass_graduation_right` decimal(3,2) DEFAULT NULL,
  `glass_color_right` decimal(3,2) NOT NULL,
  `glass_color_left` decimal(3,2) NOT NULL,
  `mount_type` int(11) DEFAULT NULL,
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `price` decimal(10,2) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `mount_types` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL,
  `reg_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_employee` int(11) NOT NULL,
  `id_glasses` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `reg_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers` (`address_id`);

ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `glasses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `glasses` (`provider_id`);

ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `providers` (`address_id`);

ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ID_CUSTOMER` (`id_customer`) USING BTREE,
  ADD KEY `fk_id_glasses` (`id_glasses`);

ALTER TABLE `mount_types` ADD PRIMARY KEY(`id`);

ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `glasses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `providers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mount_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customers` ADD UNIQUE(`nif`);

ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customer_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

ALTER TABLE `providers`
  ADD CONSTRAINT `fk_provider_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

ALTER TABLE `sales`
  ADD CONSTRAINT `fk_sale_glasses` FOREIGN KEY (`id_glasses`) REFERENCES `glasses` (`id`),
  ADD CONSTRAINT `fk_sale_customer` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `fk_sale_employee` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id`);

ALTER TABLE `glasses`
  ADD CONSTRAINT `fk_glasses_provider` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`),
  ADD CONSTRAINT `fk_glasses_mount` FOREIGN KEY (`mount_type`) REFERENCES `mount_types` (`id`);

COMMIT;

