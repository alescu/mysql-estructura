START TRANSACTION;
USE optica;
INSERT INTO addresses (street, number, floor, door, postal_code, country) VALUES
('Carrer del Sol', 10, '2', 'A', '08001', 'Spain'),
('Avinguda Diagonal', 45, '5', 'B', '08002', 'Spain'),
('Plaça Catalunya', 1, '3', '1', '08003', 'Spain'),
('Carrer de la Lluna', 22, '1', 'C', '08004', 'Spain'),
('Passeig de Gràcia', 75, '4', '2', '08005', 'Spain');

INSERT INTO providers (name, address_id, phone_number, fax, nif) VALUES
('Proveeidor A', 1, '931234567', '931234568', 'A12345678'),
('Proveidor B', 2, '939876543', '939876544', 'B87654321'),
('Proveidor C', 3, '935551111', '935552222', 'C11122233'),
('Proveidor D', 4, '937778888', '937779999', 'D44455566'),
('Proveidor E', 5, '932223333', '932224444', 'E77788899');

INSERT INTO customers (name, address_id, email, nif, reco_customer) VALUES
('Client A', 1, 'client.a@example.com', 'X1234567A', null ),
('Client B', 2, 'client.b@example.com', 'Y8765432B', null),
('Client C', 3, 'client.c@example.com', 'Z1112223C', null),
('Client D', 4, 'client.d@example.com', 'W4445556D', null),
('Client E', 5, 'client.e@example.com', 'V7778889E', null);

INSERT INTO employees (name) VALUES
('Treballador 1'),
('Treballador 2'),
('Treballador 3'),
('Treballador 4'),
('Treballador 5');

INSERT INTO mount_types (name, color) VALUES
('Pasta', 'Negre'),
('Metall', 'Platejat'),
('Metall', 'Gris'),
('Pasta', 'Marró'),
('Pasta', 'Blau');

INSERT INTO glasses (brand, glass_graduation_left, glass_graduation_right, glass_color_right, glass_color_left, mount_type, price, provider_id) VALUES
('Ray-Ban', -1.50, -1.00, 0.00, 0.00, 2, 150.00, 1), 
('Oakley', 0.00, 0.00, 0.00, 0.00, 1, 200.00, 2), 
('Arnette', -0.75, -0.75, 0.00, 0.00, 3, 120.00, 3), 
('Persol', -2.00, -2.50, 0.00, 0.00, 4, 180.00, 4), 
('Maui Jim', -0.50, -0.50, 0.00, 0.00, 5, 250.00, 5); 

INSERT INTO sales (id_customer, id_employee, total_price) VALUES
(1, 1, 300.00), 
(2, 2, 270.00), 
(3, 3, 400.00),
(4, 2, 250.00), 
(4, 1, 150.00), 
(5, 2, 200.00); 

INSERT INTO basket (sale_id, id_glasses, amount, price) VALUES
(1, 1, 1, 150.00),
(1, 2, 1, 150.00),
(2, 3, 1, 120.00),
(2, 1, 1, 150.00),
(3, 4, 2, 200.00),
(4, 1, 1, 150.00),
(5, 2, 1, 200.00); 

COMMIT;


--1) Llista el total de factures d'un client/a en un període determinat.
-- SELECT * FROM sales WHERE  id_customer=4
--2) Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.
-- SELECT id, brand FROM glasses g WHERE g.id IN ( SELECT id_glasses FROM sales s LEFT JOIN basket b ON s.id=b.sale_id WHERE s.id_employee = 2 AND s.reg_date>CURDATE()-365 GROUP BY id_glasses )
--3) Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
-- SELECT p.id, p.name FROM providers p LEFT JOIN glasses g on p.id=g.provider_id WHERE g.id IN (SELECT id_glasses FROM sales s LEFT JOIN basket b ON s.id=b.sale_id GROUP BY id_glasses)
