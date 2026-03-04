

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE DATABASE IF NOT EXISTS "coffee-shop";
USE "coffee-shop";

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

-- MODULE 1: SECURITY

CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL REFERENCES person(id),
    username VARCHAR(60) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL CHECK (LENGTH(password) >= 60),
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

-- MODULE 3: INVENTORY

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

-- MODULE 4: SALES

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

-- MODULE 5: BILLING

CREATE TABLE invoice (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL UNIQUE REFERENCES "order"(id),
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