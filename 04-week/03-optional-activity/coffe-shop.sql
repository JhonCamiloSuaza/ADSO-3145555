

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- MÓDULO 2: PARÁMETROS

CREATE TABLE type_document (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) NOT NULL,
    code VARCHAR(10) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE person (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type_document_id UUID NOT NULL REFERENCES type_document(id),
    document_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(120) UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE file (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL REFERENCES person(id) ON DELETE CASCADE,
    file_name VARCHAR(255) NOT NULL,
    file_path TEXT NOT NULL,
    file_type VARCHAR(50),
    file_size BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);
-- MÓDULO 1: SEGURIDAD


CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL REFERENCES person(id),
    username VARCHAR(60) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL CHECK (LENGTH(password) >= 3 AND LENGTH(password) <= 35),
    failed_attempts SMALLINT NOT NULL DEFAULT 0 CHECK (failed_attempts <= 4),
    locked_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(80) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE module (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(80) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(80),
    route VARCHAR(120),
    sort_order SMALLINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE system_view (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(80) NOT NULL,
    description TEXT,
    route VARCHAR(120),
    sort_order SMALLINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE user_role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    role_id UUID NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    UNIQUE (user_id, role_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE role_module (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_id UUID NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    module_id UUID NOT NULL REFERENCES module(id) ON DELETE CASCADE,
    can_read BOOLEAN NOT NULL DEFAULT FALSE,
    can_write BOOLEAN NOT NULL DEFAULT FALSE,
    can_delete BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE (role_id, module_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE module_view (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    module_id UUID NOT NULL REFERENCES module(id) ON DELETE CASCADE,
    view_id UUID NOT NULL REFERENCES system_view(id) ON DELETE CASCADE,
    UNIQUE (module_id, view_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);


-- MÓDULO 3: INVENTARIO


CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(80) NOT NULL UNIQUE,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE supplier (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL REFERENCES person(id),
    company VARCHAR(120),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID NOT NULL REFERENCES category(id),
    supplier_id UUID REFERENCES supplier(id),
    name VARCHAR(120) NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    unit VARCHAR(20) NOT NULL CHECK (unit IN ('pequeño','mediano','grande')),
    image_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL UNIQUE REFERENCES product(id) ON DELETE CASCADE,
    quantity NUMERIC(12,3) NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    min_stock NUMERIC(12,3) NOT NULL DEFAULT 0,
    max_stock NUMERIC(12,3),
    last_updated TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

-- MÓDULO 4: VENTAS


CREATE TABLE customer (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL UNIQUE REFERENCES person(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE method_payment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(60) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE "order" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES customer(id),
    method_payment_id UUID NOT NULL REFERENCES method_payment(id),
    order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    total NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (total >= 0),
    order_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (order_status IN ('pending','preparing','ready','delivered','cancelled')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE order_item (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES "order"(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES product(id),
    quantity NUMERIC(10,3) NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    subtotal NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

-- MÓDULO 5: FACTURACIÓN

CREATE TABLE invoice (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL UNIQUE REFERENCES "order"(id),
    customer_id UUID NOT NULL REFERENCES customer(id),
    invoice_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    invoice_number VARCHAR(30) NOT NULL UNIQUE,
    total NUMERIC(12,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE invoice_item (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id UUID NOT NULL REFERENCES invoice(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES product(id),
    quantity NUMERIC(10,3) NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    subtotal NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE payment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id UUID NOT NULL REFERENCES invoice(id),
    method_payment_id UUID NOT NULL REFERENCES method_payment(id),
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

-- TYPE_DOCUMENT (11 registros)

INSERT INTO type_document (name, code, description) VALUES
('Cédula de Ciudadanía', 'CC',   'Documento nacional'),
('Tarjeta de Identidad', 'TI',   'Documento para menores'),
('Registro Civil',       'RC',   'Documento de nacimiento'),
('NIT',                  'NIT',  'Identificación tributaria'),
('RUT',                  'RUT',  'Registro tributario'),
('Pasaporte',            'PAS',  'Documento internacional'),
('Cédula Extranjería',   'CE',   'Documento para extranjeros'),
('Carné Estudiantil',    'CEST', 'Documento estudiantil'),
('Carné Empresarial',    'EMP',  'Documento interno empresa'),
('Documento Proveedor',  'DP',   'Identificación proveedor'),
('Otro Documento',       'OTR',  'Otro tipo básico');


-- PERSON 

INSERT INTO person (type_document_id, document_number, first_name, last_name, phone, email) VALUES
((SELECT id FROM type_document WHERE code='CC'),  '1001000001', 'Carlos',    'Gómez',    '3001110001', 'carlos.gomez@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000002', 'María',     'Pérez',    '3001110002', 'maria.perez@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000003', 'Jorge',     'Ramírez',  '3001110003', 'jorge.ramirez@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000004', 'Ana',       'Torres',   '3001110004', 'ana.torres@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000005', 'Luis',      'Castro',   '3001110005', 'luis.castro@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000006', 'Sofía',     'Vargas',   '3001110006', 'sofia.vargas@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000007', 'Diego',     'Morales',  '3001110007', 'diego.morales@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000008', 'Valentina', 'Ríos',     '3001110008', 'valentina.rios@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000009', 'Andrés',    'Herrera',  '3001110009', 'andres.herrera@cafeteria.com'),
((SELECT id FROM type_document WHERE code='NIT'), '1001000010', 'Camila',    'Mendoza',  '3001110010', 'camila.mendoza@cafeteria.com'),
((SELECT id FROM type_document WHERE code='CC'),  '1001000011', 'Felipe',    'Ortega',   '3001110011', 'felipe.ortega@cafeteria.com');


-- FILE (11 registros)

INSERT INTO file (person_id, file_name, file_path, file_type, file_size) VALUES
((SELECT id FROM person WHERE document_number='1001000001'), 'cc_carlos.pdf',    '/docs/cc_carlos.pdf',    'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000002'), 'cc_maria.pdf',     '/docs/cc_maria.pdf',     'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000003'), 'cc_jorge.pdf',     '/docs/cc_jorge.pdf',     'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000004'), 'cc_ana.pdf',       '/docs/cc_ana.pdf',       'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000005'), 'cc_luis.pdf',      '/docs/cc_luis.pdf',      'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000006'), 'cc_sofia.pdf',     '/docs/cc_sofia.pdf',     'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000007'), 'cc_diego.pdf',     '/docs/cc_diego.pdf',     'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000008'), 'cc_valentina.pdf', '/docs/cc_valentina.pdf', 'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000009'), 'cc_andres.pdf',    '/docs/cc_andres.pdf',    'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000010'), 'nit_camila.pdf',   '/docs/nit_camila.pdf',   'application/pdf', 102400),
((SELECT id FROM person WHERE document_number='1001000011'), 'cc_felipe.pdf',    '/docs/cc_felipe.pdf',    'application/pdf', 102400);


-- ROLE 

INSERT INTO role (name, description) VALUES
('Administrador', 'Control total del sistema'),
('Gerente',       'Gestión general de la cafetería'),
('Cajero',        'Maneja ventas y cobros'),
('Barista',       'Prepara bebidas de café'),
('Cocinero',      'Prepara desayunos y almuerzos'),
('Supervisor',    'Supervisa operaciones'),
('Inventarista',  'Gestiona productos y stock'),
('Contador',      'Revisa facturación'),
('Soporte',       'Soporte técnico'),
('Auxiliar',      'Apoyo operativo'),
('Mesero',        'Atención de mesas');


-- MODULE 

INSERT INTO module (name, description, route, sort_order) VALUES
('Seguridad',    'Usuarios y roles',          '/security',   1),
('Parámetros',   'Configuraciones básicas',   '/parameters', 2),
('Inventario',   'Productos y stock',         '/inventory',  3),
('Ventas',       'Gestión de pedidos',        '/sales',      4),
('Facturación',  'Gestión de facturas',       '/billing',    5),
('Reportes',     'Consultas del sistema',     '/reports',    6),
('Clientes',     'Gestión de clientes',       '/customers',  7),
('Proveedores',  'Gestión de proveedores',    '/suppliers',  8),
('Productos',    'Administración productos',  '/products',   9),
('Dashboard',    'Panel principal',           '/dashboard',  10),
('Configuración','Configuraciones generales', '/settings',   11);


-- SYSTEM_VIEW 

INSERT INTO system_view (name, description, route, sort_order) VALUES
('Usuarios',    'Vista de usuarios',    '/users',     1),
('Roles',       'Vista de roles',       '/roles',     2),
('Productos',   'Vista de productos',   '/products',  3),
('Pedidos',     'Vista de pedidos',     '/orders',    4),
('Facturas',    'Vista de facturas',    '/invoices',  5),
('Pagos',       'Vista de pagos',       '/payments',  6),
('Inventario',  'Vista de inventario',  '/inventory', 7),
('Clientes',    'Vista de clientes',    '/customers', 8),
('Proveedores', 'Vista de proveedores', '/suppliers', 9),
('Reportes',    'Vista de reportes',    '/reports',   10),
('Dashboard',   'Vista principal',      '/dashboard', 11);


-- USER 

INSERT INTO "user" (person_id, username, password) VALUES
((SELECT id FROM person WHERE document_number='1001000001'), 'carlos.g',    'cafe123'),
((SELECT id FROM person WHERE document_number='1001000002'), 'maria.p',     'cafe123'),
((SELECT id FROM person WHERE document_number='1001000003'), 'jorge.r',     'cafe123'),
((SELECT id FROM person WHERE document_number='1001000004'), 'ana.t',       'cafe123'),
((SELECT id FROM person WHERE document_number='1001000005'), 'luis.c',      'cafe123'),
((SELECT id FROM person WHERE document_number='1001000006'), 'sofia.v',     'cafe123'),
((SELECT id FROM person WHERE document_number='1001000007'), 'diego.m',     'cafe123'),
((SELECT id FROM person WHERE document_number='1001000008'), 'valentina.r', 'cafe123'),
((SELECT id FROM person WHERE document_number='1001000009'), 'andres.h',    'cafe123'),
((SELECT id FROM person WHERE document_number='1001000010'), 'camila.m',    'cafe123'),
((SELECT id FROM person WHERE document_number='1001000011'), 'felipe.o',    'cafe123');


-- USER_ROLE 

INSERT INTO user_role (user_id, role_id) VALUES
((SELECT id FROM "user" WHERE username='carlos.g'),    (SELECT id FROM role WHERE name='Administrador')),
((SELECT id FROM "user" WHERE username='maria.p'),     (SELECT id FROM role WHERE name='Cajero')),
((SELECT id FROM "user" WHERE username='jorge.r'),     (SELECT id FROM role WHERE name='Cocinero')),
((SELECT id FROM "user" WHERE username='ana.t'),       (SELECT id FROM role WHERE name='Mesero')),
((SELECT id FROM "user" WHERE username='luis.c'),      (SELECT id FROM role WHERE name='Supervisor')),
((SELECT id FROM "user" WHERE username='sofia.v'),     (SELECT id FROM role WHERE name='Barista')),
((SELECT id FROM "user" WHERE username='diego.m'),     (SELECT id FROM role WHERE name='Inventarista')),
((SELECT id FROM "user" WHERE username='valentina.r'), (SELECT id FROM role WHERE name='Contador')),
((SELECT id FROM "user" WHERE username='andres.h'),    (SELECT id FROM role WHERE name='Auxiliar')),
((SELECT id FROM "user" WHERE username='camila.m'),    (SELECT id FROM role WHERE name='Gerente')),
((SELECT id FROM "user" WHERE username='felipe.o'),    (SELECT id FROM role WHERE name='Soporte'));


-- ROLE_MODULE

INSERT INTO role_module (role_id, module_id, can_read, can_write, can_delete) VALUES
((SELECT id FROM role WHERE name='Administrador'), (SELECT id FROM module WHERE name='Seguridad'),    TRUE, TRUE,  TRUE),
((SELECT id FROM role WHERE name='Gerente'),       (SELECT id FROM module WHERE name='Dashboard'),    TRUE, FALSE, FALSE),
((SELECT id FROM role WHERE name='Cajero'),        (SELECT id FROM module WHERE name='Ventas'),       TRUE, TRUE,  FALSE),
((SELECT id FROM role WHERE name='Barista'),       (SELECT id FROM module WHERE name='Productos'),    TRUE, FALSE, FALSE),
((SELECT id FROM role WHERE name='Cocinero'),      (SELECT id FROM module WHERE name='Productos'),    TRUE, FALSE, FALSE),
((SELECT id FROM role WHERE name='Supervisor'),    (SELECT id FROM module WHERE name='Reportes'),     TRUE, FALSE, FALSE),
((SELECT id FROM role WHERE name='Inventarista'),  (SELECT id FROM module WHERE name='Inventario'),   TRUE, TRUE,  FALSE),
((SELECT id FROM role WHERE name='Contador'),      (SELECT id FROM module WHERE name='Facturación'),  TRUE, TRUE,  FALSE),
((SELECT id FROM role WHERE name='Soporte'),       (SELECT id FROM module WHERE name='Configuración'),TRUE, TRUE,  FALSE),
((SELECT id FROM role WHERE name='Auxiliar'),      (SELECT id FROM module WHERE name='Ventas'),       TRUE, FALSE, FALSE),
((SELECT id FROM role WHERE name='Mesero'),        (SELECT id FROM module WHERE name='Clientes'),     TRUE, TRUE,  FALSE);


-- MODULE_VIEW 

INSERT INTO module_view (module_id, view_id) VALUES
((SELECT id FROM module WHERE name='Seguridad'),    (SELECT id FROM system_view WHERE name='Usuarios')),
((SELECT id FROM module WHERE name='Seguridad'),    (SELECT id FROM system_view WHERE name='Roles')),
((SELECT id FROM module WHERE name='Inventario'),   (SELECT id FROM system_view WHERE name='Inventario')),
((SELECT id FROM module WHERE name='Ventas'),       (SELECT id FROM system_view WHERE name='Pedidos')),
((SELECT id FROM module WHERE name='Facturación'),  (SELECT id FROM system_view WHERE name='Facturas')),
((SELECT id FROM module WHERE name='Facturación'),  (SELECT id FROM system_view WHERE name='Pagos')),
((SELECT id FROM module WHERE name='Clientes'),     (SELECT id FROM system_view WHERE name='Clientes')),
((SELECT id FROM module WHERE name='Proveedores'),  (SELECT id FROM system_view WHERE name='Proveedores')),
((SELECT id FROM module WHERE name='Productos'),    (SELECT id FROM system_view WHERE name='Productos')),
((SELECT id FROM module WHERE name='Reportes'),     (SELECT id FROM system_view WHERE name='Reportes')),
((SELECT id FROM module WHERE name='Dashboard'),    (SELECT id FROM system_view WHERE name='Dashboard'));


-- CATEGORY 

INSERT INTO category (name, description) VALUES
('Cafés',           'Bebidas calientes a base de café'),
('Bebidas Frías',   'Jugos y bebidas frías'),
('Desayunos',       'Platos para la mañana'),
('Almuerzos',       'Platos del mediodía'),
('Postres',         'Tortas y dulces'),
('Panadería',       'Productos horneados'),
('Bebidas Calientes','Chocolate y aromáticas'),
('Snacks',          'Productos pequeños'),
('Arepas',          'Arepas tradicionales'),
('Sandwiches',      'Sandwiches variados'),
('Jugos',           'Jugos naturales');


-- SUPPLIER 

INSERT INTO supplier (person_id, company) VALUES
((SELECT id FROM person WHERE document_number='1001000001'), 'Distribuidora Café Premium'),
((SELECT id FROM person WHERE document_number='1001000002'), 'Lácteos del Campo'),
((SELECT id FROM person WHERE document_number='1001000003'), 'Panadería San Jorge'),
((SELECT id FROM person WHERE document_number='1001000004'), 'Frutas y Verduras Frescas'),
((SELECT id FROM person WHERE document_number='1001000005'), 'Carnes y Más'),
((SELECT id FROM person WHERE document_number='1001000006'), 'Bebidas Naturales S.A.'),
((SELECT id FROM person WHERE document_number='1001000007'), 'Granos del Valle'),
((SELECT id FROM person WHERE document_number='1001000008'), 'Snacks Express'),
((SELECT id FROM person WHERE document_number='1001000009'), 'Condimentos y Salsas'),
((SELECT id FROM person WHERE document_number='1001000010'), 'Insumos Cafetería'),
((SELECT id FROM person WHERE document_number='1001000011'), 'Congelados Rápidos');


-- PRODUCT 

INSERT INTO product (category_id, supplier_id, name, unit_price, unit) VALUES
((SELECT id FROM category WHERE name='Cafés'),          (SELECT id FROM supplier WHERE company='Distribuidora Café Premium'), 'Café Americano',       3000.00, 'pequeño'),
((SELECT id FROM category WHERE name='Desayunos'),      (SELECT id FROM supplier WHERE company='Panadería San Jorge'),        'Calentado Mañanero',   8000.00, 'grande'),
((SELECT id FROM category WHERE name='Desayunos'),      (SELECT id FROM supplier WHERE company='Lácteos del Campo'),          'Huevos con Arepa',     6500.00, 'mediano'),
((SELECT id FROM category WHERE name='Almuerzos'),      (SELECT id FROM supplier WHERE company='Carnes y Más'),               'Bandeja Paisa',       14000.00, 'grande'),
((SELECT id FROM category WHERE name='Almuerzos'),      (SELECT id FROM supplier WHERE company='Carnes y Más'),               'Sopa del Día',         7000.00, 'mediano'),
((SELECT id FROM category WHERE name='Jugos'),          (SELECT id FROM supplier WHERE company='Bebidas Naturales S.A.'),     'Jugo de Mora',         4000.00, 'mediano'),
((SELECT id FROM category WHERE name='Panadería'),      (SELECT id FROM supplier WHERE company='Panadería San Jorge'),        'Croissant de Jamón',   3500.00, 'pequeño'),
((SELECT id FROM category WHERE name='Postres'),        (SELECT id FROM supplier WHERE company='Panadería San Jorge'),        'Torta de Chocolate',   5000.00, 'mediano'),
((SELECT id FROM category WHERE name='Arepas'),         (SELECT id FROM supplier WHERE company='Insumos Cafetería'),          'Arepa de Choclo',      3000.00, 'pequeño'),
((SELECT id FROM category WHERE name='Bebidas Calientes'),(SELECT id FROM supplier WHERE company='Distribuidora Café Premium'),'Chocolate Caliente',  3500.00, 'pequeño'),
((SELECT id FROM category WHERE name='Sandwiches'),     (SELECT id FROM supplier WHERE company='Insumos Cafetería'),          'Sandwich Mixto',       6000.00, 'mediano');


-- INVENTORY

INSERT INTO inventory (product_id, quantity, min_stock, max_stock) VALUES
((SELECT id FROM product WHERE name='Café Americano'),    100.000, 20.000, 200.000),
((SELECT id FROM product WHERE name='Calentado Mañanero'), 30.000,  5.000,  50.000),
((SELECT id FROM product WHERE name='Huevos con Arepa'),   40.000,  5.000,  60.000),
((SELECT id FROM product WHERE name='Bandeja Paisa'),      25.000,  5.000,  40.000),
((SELECT id FROM product WHERE name='Sopa del Día'),       30.000,  5.000,  50.000),
((SELECT id FROM product WHERE name='Jugo de Mora'),       80.000, 10.000, 150.000),
((SELECT id FROM product WHERE name='Croissant de Jamón'), 50.000, 10.000, 100.000),
((SELECT id FROM product WHERE name='Torta de Chocolate'), 20.000,  5.000,  40.000),
((SELECT id FROM product WHERE name='Arepa de Choclo'),    60.000, 10.000, 120.000),
((SELECT id FROM product WHERE name='Chocolate Caliente'), 90.000, 15.000, 180.000),
((SELECT id FROM product WHERE name='Sandwich Mixto'),     35.000,  5.000,  70.000);

-- CUSTOMER 

INSERT INTO customer (person_id) VALUES
((SELECT id FROM person WHERE document_number='1001000001')),
((SELECT id FROM person WHERE document_number='1001000002')),
((SELECT id FROM person WHERE document_number='1001000003')),
((SELECT id FROM person WHERE document_number='1001000004')),
((SELECT id FROM person WHERE document_number='1001000005')),
((SELECT id FROM person WHERE document_number='1001000006')),
((SELECT id FROM person WHERE document_number='1001000007')),
((SELECT id FROM person WHERE document_number='1001000008')),
((SELECT id FROM person WHERE document_number='1001000009')),
((SELECT id FROM person WHERE document_number='1001000010')),
((SELECT id FROM person WHERE document_number='1001000011'));


-- METHOD_PAYMENT 

INSERT INTO method_payment (name, description) VALUES
('Efectivo',               'Pago en dinero físico'),
('Tarjeta Débito',         'Pago con tarjeta débito'),
('Tarjeta Crédito',        'Pago con tarjeta crédito'),
('Nequi',                  'Pago digital Nequi'),
('Daviplata',              'Pago digital Daviplata'),
('Transferencia',          'Transferencia bancaria'),
('Código QR',              'Pago con QR'),
('Pago Mixto',             'Combinación de pagos'),
('Bancolombia App',        'Pago desde app bancaria'),
('PSE',                    'Pago electrónico PSE'),
('Efectivo Contraentrega', 'Pago al recibir');


-- ORDER 

INSERT INTO "order" (customer_id, method_payment_id, total, order_status) VALUES
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000001')), (SELECT id FROM method_payment WHERE name='Efectivo'),        11000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000002')), (SELECT id FROM method_payment WHERE name='Nequi'),           14000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000003')), (SELECT id FROM method_payment WHERE name='Tarjeta Débito'),   8000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000004')), (SELECT id FROM method_payment WHERE name='Daviplata'),       21000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000005')), (SELECT id FROM method_payment WHERE name='Efectivo'),         6500.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000006')), (SELECT id FROM method_payment WHERE name='Código QR'),       17000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000007')), (SELECT id FROM method_payment WHERE name='Transferencia'),    3500.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000008')), (SELECT id FROM method_payment WHERE name='Efectivo'),        10000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000009')), (SELECT id FROM method_payment WHERE name='Nequi'),            7000.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000010')), (SELECT id FROM method_payment WHERE name='Tarjeta Crédito'), 19500.00, 'delivered'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000011')), (SELECT id FROM method_payment WHERE name='Efectivo'),         9000.00, 'delivered');


-- ORDER_ITEM

INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000001')) LIMIT 1), (SELECT id FROM product WHERE name='Café Americano'),     2.000,  3000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000002')) LIMIT 1), (SELECT id FROM product WHERE name='Bandeja Paisa'),      1.000, 14000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000003')) LIMIT 1), (SELECT id FROM product WHERE name='Calentado Mañanero'), 1.000,  8000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000004')) LIMIT 1), (SELECT id FROM product WHERE name='Sopa del Día'),       3.000,  7000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000005')) LIMIT 1), (SELECT id FROM product WHERE name='Huevos con Arepa'),   1.000,  6500.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000006')) LIMIT 1), (SELECT id FROM product WHERE name='Jugo de Mora'),        2.000,  4000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000007')) LIMIT 1), (SELECT id FROM product WHERE name='Croissant de Jamón'),  1.000,  3500.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000008')) LIMIT 1), (SELECT id FROM product WHERE name='Arepa de Choclo'),    2.000,  3000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000009')) LIMIT 1), (SELECT id FROM product WHERE name='Sopa del Día'),       1.000,  7000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000010')) LIMIT 1), (SELECT id FROM product WHERE name='Sandwich Mixto'),     2.000,  6000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000011')) LIMIT 1), (SELECT id FROM product WHERE name='Chocolate Caliente'),  2.000,  3500.00);


-- INVOICE 

INSERT INTO invoice (order_id, customer_id, invoice_number, total) VALUES
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000001')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000001')), 'INV-00001',  6000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000002')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000002')), 'INV-00002', 14000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000003')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000003')), 'INV-00003',  8000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000004')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000004')), 'INV-00004', 21000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000005')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000005')), 'INV-00005',  6500.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000006')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000006')), 'INV-00006',  8000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000007')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000007')), 'INV-00007',  3500.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000008')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000008')), 'INV-00008',  6000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000009')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000009')), 'INV-00009',  7000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000010')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000010')), 'INV-00010', 12000.00),
((SELECT id FROM "order" WHERE customer_id=(SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000011')) LIMIT 1), (SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1001000011')), 'INV-00011',  7000.00);

-- INVOICE_ITEM 

INSERT INTO invoice_item (invoice_id, product_id, quantity, unit_price) VALUES
((SELECT id FROM invoice WHERE invoice_number='INV-00001'), (SELECT id FROM product WHERE name='Café Americano'),     2.000,  3000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00002'), (SELECT id FROM product WHERE name='Bandeja Paisa'),      1.000, 14000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00003'), (SELECT id FROM product WHERE name='Calentado Mañanero'), 1.000,  8000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00004'), (SELECT id FROM product WHERE name='Sopa del Día'),       3.000,  7000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00005'), (SELECT id FROM product WHERE name='Huevos con Arepa'),   1.000,  6500.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00006'), (SELECT id FROM product WHERE name='Jugo de Mora'),       2.000,  4000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00007'), (SELECT id FROM product WHERE name='Croissant de Jamón'), 1.000,  3500.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00008'), (SELECT id FROM product WHERE name='Arepa de Choclo'),    2.000,  3000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00009'), (SELECT id FROM product WHERE name='Sopa del Día'),       1.000,  7000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00010'), (SELECT id FROM product WHERE name='Sandwich Mixto'),     2.000,  6000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00011'), (SELECT id FROM product WHERE name='Chocolate Caliente'), 2.000,  3500.00);


-- PAYMENT 
INSERT INTO payment (invoice_id, method_payment_id, amount) VALUES
((SELECT id FROM invoice WHERE invoice_number='INV-00001'), (SELECT id FROM method_payment WHERE name='Efectivo'),         6000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00002'), (SELECT id FROM method_payment WHERE name='Nequi'),           14000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00003'), (SELECT id FROM method_payment WHERE name='Tarjeta Débito'),   8000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00004'), (SELECT id FROM method_payment WHERE name='Daviplata'),       21000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00005'), (SELECT id FROM method_payment WHERE name='Efectivo'),         6500.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00006'), (SELECT id FROM method_payment WHERE name='Código QR'),        8000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00007'), (SELECT id FROM method_payment WHERE name='Transferencia'),    3500.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00008'), (SELECT id FROM method_payment WHERE name='Efectivo'),         6000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00009'), (SELECT id FROM method_payment WHERE name='Nequi'),            7000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00010'), (SELECT id FROM method_payment WHERE name='Tarjeta Crédito'), 12000.00),
((SELECT id FROM invoice WHERE invoice_number='INV-00011'), (SELECT id FROM method_payment WHERE name='Efectivo'),         7000.00);