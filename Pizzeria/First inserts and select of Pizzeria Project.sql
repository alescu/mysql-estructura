START TRANSACTION;
USE pizzeria;
INSERT INTO provinces (name) VALUES
('Barcelona'),
('Tarragona'),
('Girona'),
('Lleida'),
('València');

INSERT INTO cities (name, province_id) VALUES
('Mataró', 1),  -- Barcelona
('Reus', 2),    -- Tarragona
('Figueres', 3), -- Girona
('Cervera', 4),  -- Lleida
('Gandia', 5);   -- València

INSERT INTO addresses (address, postal_code, city_id, phone_number) VALUES
('Carrer Major, 10', '08001', 1, '931234567'), 
('Plaça de la Font, 5', '43003', 2, '977987654'),
('Carrer Nou, 22', '17001', 3, '972123456'), 
('Avinguda de l\'Estació, 8', '25002', 4, '973456789'),
('Passeig Marítim, 15', '46011', 5, '666777888'),
('Carrer Major, 10', '08001', 1, '931234567'), 
('Plaça de la Font, 5', '43003', 2, '977987654'),
('Carrer Nou, 22', '17001', 1, '972123456'), 
('Avinguda de l\'Estació, 8', '25002', 2, '973456789'),
('Passeig Marítim, 15', '46011', 1, '666777888');

INSERT INTO products_types (name) VALUES
('Pizza'),
('Hamburguesa'),
('Beguda');

INSERT INTO products_categories (product_type_id, name, date_start, date_end) VALUES
(1, 'Pizzes Clàssiques', '2023-01-01', '2024-01-01'),  -- Pizza
(1, 'Pizzes Especials', '2023-01-01', '2024-01-01'), -- Pizza
(2, 'Hamburgueses Simples', '2023-01-01', '2024-01-01'), -- Hamburguesa
(2, 'Hamburgueses Gourmet', '2023-01-01', '2024-01-01'), -- Hamburguesa
(3, 'Begudes', '2023-01-01', '2024-01-01');       -- Beguda

INSERT INTO products (product_type, name, image, product_id, price, description, date) VALUES
(1, 'Margherita', 'margherita.jpg', 1, 8.99, 'Tomàquet, mozzarella, alfàbrega', '2023-10-27 12:00:00'),  -- Pizza, Pizzes Clàssiques
(1, 'Prosciutto', 'prosciutto.jpg', 2, 10.99, 'Tomàquet, mozzarella, pernil salat', '2023-10-27 12:00:00'), -- Pizza, Pizzes Especials
(2, 'Clàssica', 'classica.jpg', 3, 7.50, 'Carn de vedella, enciam, tomàquet', '2023-10-27 12:00:00'), -- Hamburguesa, Hamburgueses Simples
(2, 'Gourmet', 'gourmet.jpg', 4, 12.00, 'Vedella, formatge brie, ceba caramel·litzada', '2023-10-27 12:00:00'), -- Hamburguesa, Hamburgueses Gourmet
(3, 'Coca-Cola', 'cocacola.jpg', 5, 2.00, 'Refresc de cola', '2023-10-27 12:00:00'); -- Beguda, Refrescos

INSERT INTO jobs_category (job_name) VALUES
('Cuiner/a'),
('Cambrer/a Caixer/a nivell 1'),
('Caixer/a Caixer/a nivell 2'),
('Repartidor/a'),
('Encàrrec/a');

INSERT INTO stores (nif, name, address_id) VALUES
('B12345678', 'Pizzeria La Nonna', 1),
('C87654321', 'Pizzeria Napoli', 2),
('A98765432', 'Pizzeria Roma', 3),
('B12345678', 'Pizzeria La Nonna 2', 4),
('C87654321', 'Pizzeria Napoli 2', 5),
('A98765432', 'Pizzeria Roma 2', 6);

INSERT INTO workers (store_id, job_id, nif, name, lastnames, address_id) VALUES
(1, 1, 'X1234567Y', 'Mario', 'Rossi', 4),  -- La Nonna, Cuiner/a
(1, 2, 'Z9876543W', 'Luigi', 'Verdi', 5),  -- La Nonna, Cambrer/a
(2, 1, 'A4567891B', 'Sofia', 'Bianchi', 6), -- Napoli, Cuiner/a
(2, 4, 'B7890123C', 'Giovanni', 'Neri', 7), -- Napoli, Repartidor/a
(3, 2, 'C1011121D', 'Francesca', 'Gialli', 8); -- Roma, Cambrer/a

INSERT INTO customers (name, last_names, address_id) VALUES
('Joan', 'Pérez', 1),
('Maria', 'García', 2),
('Pere', 'López', 3),
('Anna', 'Martínez', 4),
('Carla', 'Sánchez', 5);

INSERT INTO orders (customer_id, store_id, date, total_price, at_home, status, cooker, server) VALUES
(1, 1, '2023-10-27 14:00:00', 25.50, 'Y','Canceled',1, 2 ),  -- Joan, La Nonna
(2, 2, '2023-10-27 15:30:00', 18.00, 'N', 'Delivered',1, 4),  -- Maria, Napoli
(3, 1, '2023-10-27 16:45:00', 32.75, 'Y', 'Delivered',1, 2),  -- Pere, La Nonna
(4, 3, '2023-10-27 17:15:00', 15.20, 'N', 'Paied',1, 4),  -- Anna, Roma
(5, 2, '2023-10-27 18:00:00', 28.90, 'Y', 'Paied',1, 2),  -- Carla, Napoli
(1, 1, '2024-10-27 14:00:00', 25.50, 'Y', 'Paied',1, 2),  -- 6 Joan, La Nonna
(2, 2, '2024-10-27 15:30:00', 18.00, 'N', 'Paied',1, 4),  -- Maria, Napoli
(3, 1, '2024-10-27 16:45:00', 32.75, 'Y', 'Paied',1, 2),  -- 8 Pere, La Nonna
(4, 3, '2024-10-27 17:15:00', 15.20, 'N', 'Refunded',1, 4),  -- Anna, Roma
(5, 2, '2024-10-27 18:00:00', 28.90, 'Y', 'Paied', 1, 2);  -- 10 Carla, Napoli

INSERT INTO products_orders (order_id, product_id, date, price) VALUES
(1, 1, '2023-10-27 14:00:00', 8.99),  -- Margherita (order 1)
(1, 3, '2023-10-27 14:00:00', 7.50),  -- Clàssica (order 1)
(1, 5, '2023-10-27 14:00:00', 2.00),  -- Coca-Cola (order 1)
(2, 2, '2023-10-27 15:30:00', 10.99), -- Prosciutto (order 2)
(2, 5, '2023-10-27 15:30:00', 2.00),  -- Coca-Cola (order 2)
(3, 1, '2023-10-27 16:45:00', 8.99),  -- Margherita (order 3)
(3, 2, '2023-10-27 16:45:00', 10.99), -- Prosciutto (order 3)
(3, 4, '2023-10-27 16:45:00', 12.00), -- Gourmet (order 3)
(4, 3, '2023-10-27 17:15:00', 7.50),  -- Clàssica (order 4)
(4, 5, '2023-10-27 17:15:00', 2.00),  -- Coca-Cola (order 4)
(5, 2, '2023-10-27 18:00:00', 10.99), -- Prosciutto (order 5)
(5, 4, '2023-10-27 18:00:00', 12.00), -- Gourmet (order 5)
(5, 5, '2023-10-27 18:00:00', 2.00);  -- Coca-Cola (order 5)

INSERT INTO delivery (customer_id, order_id, worker_id, status, observations, date, at_home) VALUES
(1, 1, 3, 'Pending', 'Trucar abans d\'arribar', '2023-10-27 14:30:00', 'Y'), -- Joan, order 1, Repartidor
(3, 3, 3, 'Confirmed', 'Deixar a la porta', '2023-10-27 17:15:00', 'Y'), -- Pere, order 3, Repartidor
(5, 5, 3, 'Preparing', 'Sense observacions', '2023-10-27 18:30:00', 'Y'), -- Carla, order 5, Repartidor
(1, null, 3, 'Canceled', 'Client no disponible', '2023-10-28 10:00:00', 'Y'), -- Joan, Sense comanda, Repartidor
(2, null, 3, 'Delivered', 'Entrega reusita', '2023-10-27 16:00:00', 'N'), -- Maria, Sense comanda, Repartidor
(3, 5, 3, 'Charged', 'Deixat a la porta', '2023-10-27 17:15:00', 'Y'), -- Pere, order 3, Repartidor
(5, 6, 3, 'Charged', 'Sense observacions', '2023-10-27 18:30:00', 'Y'), -- Carla, order 5, Repartidor
(1, 8, 3, 'Charged', 'Client no disponible', '2023-10-28 10:00:00', 'Y'), -- Joan, Sense comanda, Repartidor
(2, 10, 3, 'Charged', 'Entrega reusita', '2023-10-27 16:00:00', 'N'); -- Maria, Sense comanda, Repartidor

COMMIT;  



-- Consultes Pizzeria:
-- 1) Llista quants productes de categoria 'Begudes' s'han venut en una determinada localitat.
-- SELECT * FROM orders WHERE orders.status='Paied' AND orders.id IN (SELECT str.id FROM stores str LEFT JOIN addresses adr ON str.address_id=adr.id AND adr.id=3)

-- 2) Llista quantes comandes ha efectuat un determinat empleat/da:
-- La consulta cerca qui les ha servit:
-- SELECT wrkr.name , count(ord.id) FROM orders ord LEFT JOIN workers wrkr ON ord.server=wrkr.id GROUP BY ord.server
-- La consulta cerca qui les ha cuinat:
-- SELECT wrkr.name , count(ord.id) FROM orders ord LEFT JOIN workers wrkr ON ord.cooker=wrkr.id GROUP BY ord.cooker