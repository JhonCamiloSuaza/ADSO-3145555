
CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE role (
    id_role SERIAL PRIMARY KEY,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    person_id INT NOT NULL,
    CONSTRAINT fk_user_person
        FOREIGN KEY (person_id)
        REFERENCES person(id)
        ON DELETE CASCADE
);

CREATE TABLE user_role (
    id_user_role SERIAL PRIMARY KEY,
    id_user INT NOT NULL,
    id_role INT NOT NULL,
    CONSTRAINT fk_userrole_user
        FOREIGN KEY (id_user)
        REFERENCES users(id_user)
        ON DELETE CASCADE,
    CONSTRAINT fk_userrole_role
        FOREIGN KEY (id_role)
        REFERENCES role(id_role)
        ON DELETE CASCADE
);


CREATE TABLE category (
    id_category SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500)
);

CREATE TABLE product (
    id_product SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    price NUMERIC(15,2) NOT NULL,
    stock INT NOT NULL,
    id_category INT NOT NULL,
    CONSTRAINT fk_product_category
        FOREIGN KEY (id_category)
        REFERENCES category(id_category)
        ON DELETE CASCADE
);

CREATE TABLE inventory (
    id_inventory SERIAL PRIMARY KEY,
    id_product INT NOT NULL,
    quantity_available INT NOT NULL,
    quantity_reserved INT NOT NULL,
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (id_product)
        REFERENCES product(id_product)
        ON DELETE CASCADE
);

CREATE TABLE bill (
    id_bill SERIAL PRIMARY KEY,
    id_user INT NOT NULL,
    bill_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(15,2) NOT NULL DEFAULT 0,
    notes VARCHAR(500),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    CONSTRAINT fk_bill_user
        FOREIGN KEY (id_user)
        REFERENCES users(id_user)
        ON DELETE CASCADE
);

CREATE TABLE bill_detail (
    id_bill_detail SERIAL PRIMARY KEY,
    id_bill INT NOT NULL,
    id_product INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(15,2) NOT NULL,
    subtotal NUMERIC(15,2) NOT NULL,
    CONSTRAINT fk_billdetail_bill
        FOREIGN KEY (id_bill)
        REFERENCES bill(id_bill)
        ON DELETE CASCADE,
    CONSTRAINT fk_billdetail_product
        FOREIGN KEY (id_product)
        REFERENCES product(id_product)
        ON DELETE CASCADE
);


-- PERSON
INSERT INTO person (name, edad) VALUES
('Carlos Ramirez', 25),
('Laura Gomez', 30);

-- ROLE
INSERT INTO role (role) VALUES
('ADMIN'),
('USER');

-- USERS (comillas dobles para nombre reservado)
INSERT INTO "users" (email, password, user_name, person_id) VALUES
('carlos@gmail.com', '123456', 'carlos25', 1),
('laura@gmail.com', 'abcdef', 'laura30', 2);

-- USER_ROLE
INSERT INTO user_role (id_user, id_role) VALUES
(1, 1),
(1, 2),
(2, 2);

-- CATEGORY
INSERT INTO category (name, description) VALUES
('Electronics', 'Electronic devices'),
('Office', 'Office supplies');

-- PRODUCT
INSERT INTO product (name, description, price, stock, id_category) VALUES
('Laptop', 'Gaming laptop', 3500.00, 10, 1),
('Mouse', 'Wireless mouse', 80.00, 50, 1),
('Notebook', 'A4 notebook', 5.00, 200, 2);

-- INVENTORY (omitiendo last_updated para usar default)
INSERT INTO inventory (id_product, quantity_available, quantity_reserved) VALUES
(1, 8, 2),
(2, 45, 5),
(3, 180, 20);

-- BILL (omitiendo bill_date para usar default)
INSERT INTO bill (id_user, total_amount, notes, status) VALUES
(1, 3580.00, 'First order', 'PENDING'),
(2, 85.00, 'Office supplies', 'PENDING');

-- BILL_DETAIL
INSERT INTO bill_detail (id_bill, id_product, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 3500.00, 3500.00),
(1, 2, 1, 80.00, 80.00),
(2, 3, 17, 5.00, 85.00);

DROP TABLE IF EXISTS bill_detail CASCADE;
DROP TABLE IF EXISTS bill CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS user_role CASCADE;
DROP TABLE IF EXISTS "users" CASCADE;
DROP TABLE IF EXISTS role CASCADE;
DROP TABLE IF EXISTS person CASCADE;