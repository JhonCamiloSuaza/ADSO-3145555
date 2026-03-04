
CREATE TABLE person (
    id_person SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE role (
    id_role SERIAL PRIMARY KEY,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    id_person INT NOT NULL UNIQUE,

    CONSTRAINT fk_user_person
        FOREIGN KEY (id_person) REFERENCES person(id_person)
);

CREATE TABLE user_role (
    id_user_role SERIAL PRIMARY KEY,
    id_user INT NOT NULL,
    id_role INT NOT NULL,

    CONSTRAINT fk_userrole_user
        FOREIGN KEY (id_user) REFERENCES users(id_user),

    CONSTRAINT fk_userrole_role
        FOREIGN KEY (id_role) REFERENCES role(id_role)
);


INSERT INTO person (name, edad)
VALUES 
('Juan Perez', 25),
('Maria Lopez', 30),
('Carlos Ramirez', 22);

INSERT INTO users (email, password, user_name, id_person)
VALUES 
('juan@email.com', '123456', 'juanp', 1),
('maria@email.com', '123456', 'marial', 2),
('carlos@email.com', '123456', 'carlosr', 3);

INSERT INTO role (role)
VALUES 
('ADMIN'),
('USER'),
('SUPPORT');

INSERT INTO user_role (id_user, id_role)
VALUES 
(1, 1), -- Juan es ADMIN
(2, 2), -- Maria es USER
(3, 3); -- Carlos es SUPPORT

SELECT * FROM users;
SELECT * FROM user_role;