-- CREATE DATABES
DROP DATABASE IF EXISTS pizza_restaurant;
CREATE DATABASE pizza_restaurant;
USE pizza_restaurant;

-- CREATE DB TABLES
CREATE TABLE provinces(
	id_province INT NOT NULL AUTO_INCREMENT,
	name_province VARCHAR(45) NOT NULL,
	PRIMARY KEY(id_province)
);

CREATE TABLE towns(
    id_town INT NOT NULL AUTO_INCREMENT,
    name_town VARCHAR(45) NOT NULL,
    id_province INT NOT NULL,
    PRIMARY KEY(id_town),
    FOREIGN KEY(id_province) REFERENCES provinces(id_province)
);

CREATE TABLE customers(
    id_customer INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    address VARCHAR(100) NOT NULL,
    zip VARCHAR(25) NOT NULL,
    id_town INT NOT NULL,
    phone VARCHAR(45) NOT NULL,
    PRIMARY KEY(id_customer),
    FOREIGN KEY(id_town) REFERENCES towns(id_town)
);

CREATE TABLE stores(
    id_store INT NOT NULL AUTO_INCREMENT,
    address VARCHAR(60) NOT NULL,
    zip VARCHAR(25) NOT NULL,
    id_town INT NOT NULL,
    PRIMARY KEY(id_store),
    FOREIGN KEY(id_town) REFERENCES towns(id_town)
);

CREATE TABLE employees(
    id_employee INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    ssn VARCHAR(45) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    position ENUM('cook', 'delivery_person'),
    id_store INT NOT NULL,
    PRIMARY KEY(id_employee),
    FOREIGN KEY(id_store) REFERENCES stores(id_store)
);

CREATE TABLE delivery_orders(
    id_delivery_order INT NOT NULL AUTO_INCREMENT,
    id_delivery_person INT NOT NULL,
    date_and_time TIMESTAMP,
    PRIMARY KEY(id_delivery_order),
    FOREIGN KEY(id_delivery_person) REFERENCES employees(id_employee)
);

CREATE TABLE orders(
    id_order INT NOT NULL AUTO_INCREMENT,
    date_and_time DATETIME,
    order_type ENUM('delivery', 'store') NOT NULL,
    amount INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    id_customer INT NOT NULL,
    id_delivery_order INT,
    id_store INT NOT NULL,
    id_employee INT NOT NULL,
    PRIMARY KEY(id_order),
    FOREIGN KEY(id_customer) REFERENCES customers(id_customer),
    FOREIGN KEY(id_delivery_order) REFERENCES delivery_orders(id_delivery_order),
    FOREIGN KEY(id_store) REFERENCES stores(id_store),
    FOREIGN KEY(id_employee) REFERENCES employees(id_employee)
);

CREATE TABLE items(
    id_item INT NOT NULL AUTO_INCREMENT,
    type_item ENUM ('pizza', 'burger', 'drink'),
    name_item VARCHAR(45) NOT NULL,
    id_order INT,
    description_item VARCHAR(300) NOT NULL,
    image BLOB,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id_item),
    FOREIGN KEY(id_order) REFERENCES orders(id_order)
);

-- TABLE DATA INSERT
INSERT INTO provinces (name_province) 
VALUES ('Barcelona'),
('Tarragona'),
('Lleida'),
('Girona');

INSERT INTO towns (name_town, id_province) 
VALUES ('Barcelona', 1), 
('Granollers', 1),
('Sitges', 1),
('Tarragona', 2),
('el Vendrell', 2),
('Salou', 2),
('Lleida', 3),
('Tarrega', 3),
('Girona', 4),
('Figueres', 4),
('Lloret de Mar', 4);

INSERT INTO stores(address, zip, id_town) 
VALUES ('Carrer Provença, 217', '08036', 1),
('Avinguda Lluís Companys, 53', '08401', 2),
('Carrer Antic, 7', '08870', 3),
('Carrer del Compte Rius, 11', '43003', 4),
('Carrer de Sant Magí, 34', '43700', 5),
('Passeig Marítim, 71', '43840', 6),
('Carrer Agustins, 1', '25001', 7), 
('Avinguda Raval del Carme, 76', '25300', 8), 
('Plaça de la Independència, 11', '17001', 9), 
('Carrer Nou, 135', '17600', 10), 
('Carrer de la Riera, 14', '17310', 11); 

INSERT INTO employees(first_name, last_name, ssn, phone, position, id_store) 
VALUES ('Mario', 'Paolini', 'X1234567P', '+34665123123', 'cook', 1),
('Paolo', 'Mancuso', 'X2334455J', '+34611012234', 'cook', 4),
('Giulia', 'Rosso', 'X4561238L', '+34607818181', 'cook', 3),
('Anna', 'Tochi', 'X7722123C', '+34677661239', 'cook', 2),
('Alvaro', 'Garcia', '45566711A', '+34611998811', 'delivery_person', 4),
('Jimena', 'Perez', '72345678-G', '+34633123789', 'delivery_person', 3),
('Laia', 'Fradera', '37788991-K', '+34665987432', 'delivery_person', 1),
('Albert', 'Gonzalez', '377889991-M', '+34697156789', 'delivery_person', 2);

INSERT INTO customers(first_name, last_name, address, zip, id_town, phone) 
VALUES ('Jose', 'Esparza', 'Carrer Mallorca, 155', '08036', 1, '+34607229441'),
('Maria', 'Font', 'Carrer Sol, 21', '08024', 1, '+34631986542'),
('Joan', 'Picassent', 'Carrer del Remei', '17001', 9, '+34699912921'),
('Teresa', 'Oliver', 'Carrer Joan Maragall, 21', '43840', 6, '+34633313101'),
('Mireia', 'Gonzalez', 'Carrer Mozart, 56', '43700', 5, '+34651558628');

INSERT INTO items(type_item, name_item, description_item, price) 
VALUES ('pizza', 'margherita', 'classic Neapolitan thin crust pizza, made with San Marzano tomatoes, mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.', 8.99),
('pizza', 'quattro stagioni', 'roman style thin and crispy pizza prepared with mozzarella cheese, Italian baked ham, mushroom, artichoke and tomato.', 9.99),
('pizza', 'capperi e acciughe', 'Neapolitan pizza, made with tomato sauce, mozarella cheese, anchovies, capers and oregano.', 8.99),
('burger', 'classic cheese burger', 'Lettuce, Tomato, raw or sautéed onions, pickles, mayo & american cheese on a fresh baked deli bun.', 12.99),
('burger', 'mushroom swiss burger', 'Sautéed mushrooms & melted swiss on a fresh baked deli bun brushed with garlic parmesan butter.', 12.99),
('burger', 'tex mex burger', 'Roasted pablano peppers, sautéed onions, bacon, pepperjack, guacamole, lettuce & chipotle mayo on a miami onion bun.', 13.99),
('drink', 'water', '20oz mineral water bottle.', 2.50),
('drink', 'soda', '15oz soda cup.', 2.50);

INSERT INTO orders(order_type, amount, price, id_customer, id_store, id_employee) 
VALUES ('store', 23.48, 1, 2, 1, 1);

/*INSERT INTO ordered_items(id_item, amount, id_order)
VALUES (1, 2, 1),
(2, 2, 1); */

-- TEST QUERIES
-- Llista quants productes del tipus 'begudes' s'han venut en una determinada localitat

SELECT *
	FROM items i INNER JOIN towns t
    WHERE i.type_item = 'drink' AND  t.name_town = 'Barcelona' ;
    
-- Llista quantes comandes ha executat un determinat empleat

SELECT id_order 
	FROM orders
	WHERE id_employee = 1;


