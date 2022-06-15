-- CREATE DATABASE
DROP DATABASE IF EXISTS optical_store;
CREATE DATABASE optical_store;
USE optical_store;

-- CREATE DB TABLES
CREATE TABLE suppliers(
id_supplier INT NOT NULL AUTO_INCREMENT,
name_supplier VARCHAR(60) NOT NULL,
street_name VARCHAR(50) NOT NULL,
street_number INT NOT NULL,
zip VARCHAR(10) NOT NULL,
city VARCHAR(35) NOT NULL,
country VARCHAR(20) NOT NULL,
phone VARCHAR(20) NOT NULL,
fax VARCHAR(20) NOT NULL,
tin VARCHAR(20) NOT NULL, -- tin = nif
PRIMARY KEY(id_supplier)
);

CREATE TABLE customers(
id_customer INT NOT NULL AUTO_INCREMENT,
full_name VARCHAR(60) NOT NULL,
zip INT NOT NULL,
phone VARCHAR(15) NOT NULL,
email VARCHAR(45) NOT NULL,
registration_date DATE NOT NULL,
referring_customer INT,
PRIMARY KEY(id_customer),
FOREIGN KEY(referring_customer) REFERENCES customers(id_customer)
);

CREATE TABLE employees(
id_employee INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(60) NOT NULL,
last_name VARCHAR(60) NOT NULL,
PRIMARY KEY(id_employee)
);

CREATE TABLE sales(
id_sale INT NOT NULL AUTO_INCREMENT,
date_sale DATE NOT NULL,
brand VARCHAR(60) NOT NULL,
lefteye_grade DECIMAL(4,2), 
righteye_grade DECIMAL(4,2),
frame_type ENUM('rimless', 'plastic', 'metal') NOT NULL,
frame_color VARCHAR(45),
lenses_color VARCHAR(45) NOT NULL,
value_sale DECIMAL(6,2) NOT NULL,
id_supplier INT NOT NULL,
id_customer INT NOT NULL,
id_employee INT NOT NULL,
PRIMARY KEY(id_sale),
FOREIGN KEY(id_supplier) REFERENCES suppliers(id_supplier),
FOREIGN KEY(id_customer) REFERENCES customers(id_customer),
FOREIGN KEY(id_employee) REFERENCES employees(id_employee)
);

-- INSERT DATA 
-- employees table
INSERT INTO employees (first_name, last_name)
VALUES ('Alicia', 'Johnson'), 
('Tyler', 'Zimmer'), 
('Jessica', 'Alfano');

-- suppliers table
INSERT INTO suppliers (name_supplier, street_name, street_number, zip, city, country, phone, fax, tin)
VALUES('Europe Eyewear Distribution, Ltd.', 'Langton Road', '85', 'L31 8BU', 'Liverpool', 'United Kingdom', '+441515262626', '+441515262628', '1234567899'),
('Iberica Lentes, S.A', 'Carrer Valles', '56', '08130', 'Mataro', 'Spain', '+346317070', '+34632191919', 'ES9900012984');

-- customers tables
INSERT INTO customers (full_name, zip, phone, email, registration_date, referring_customer)
VALUES('Greta Gonzalez', '08010', '+34679992928', 'ggggreta@tutanota.com', '2022-03-03', NULL),
('Ariadna Perez', '08036', '+3466112312', 'ariperez@protonmail.com', '2022-03-13', '1'),
('Joan Castejon', '08024', '+3466112312', 'joancast@gmx.com', '2022-03-23', '2');

-- sales tables
INSERT INTO sales (date_sale, brand, lefteye_grade, righteye_grade, frame_type, frame_color,lenses_color, value_sale, id_supplier, id_customer, id_employee)
VALUES ('2022-03-13', 'Rayban', '0.75', '1.25', 'plastic', 'black', 'green', '295.99', '1', '1', '1'),
('2022-04-21', 'Rayban', NULL, NULL, 'plastic', 'grey', 'black', '165.99', '1', '1', '2'),
('2022-03-13', 'Armani', '2.00', '0.50', 'rimless', NULL, 'clear', '355.99', '2', '2', '1'),
('2022-03-23', 'Gucci', NULL, NULL, 'metal', 'gold', 'clear', '255.99', '2', '3', '3');

-- TEST QUERIES (3)
-- 1. Llista el total de compres d'un client.

SELECT *
	FROM sales
	WHERE id_customer = 1;

-- 2. Llista les diferents ulleres que ha venut un empleat durant un any.

SELECT *
	FROM sales
	WHERE id_employee = 1 AND date_sale >= '2022-01-01';

-- 3. Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.

SELECT sup.name_supplier
	FROM sales s INNER JOIN suppliers sup
	ON sup.id_supplier = s.id_supplier 
    WHERE id_sale > 0
    GROUP BY sup.name_supplier;

