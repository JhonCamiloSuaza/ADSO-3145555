
--  coffi


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- MÓDULO 2: PARÁMETROS


CREATE TABLE type_document (
    id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name         VARCHAR(50)  NOT NULL,
    code         VARCHAR(10)  NOT NULL UNIQUE,
    description  TEXT,
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ,
    deleted_at   TIMESTAMPTZ,
    created_by   UUID,
    updated_by   UUID,
    deleted_by   UUID,
    status       BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE person (
    id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type_document_id UUID         NOT NULL REFERENCES type_document(id),
    document_number  VARCHAR(20)  NOT NULL UNIQUE,
    first_name       VARCHAR(80)  NOT NULL,
    last_name        VARCHAR(80)  NOT NULL,
    phone            VARCHAR(20),
    email            VARCHAR(120) UNIQUE,
    created_at       TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ,
    deleted_at       TIMESTAMPTZ,
    created_by       UUID,
    updated_by       UUID,
    deleted_by       UUID,
    status           BOOLEAN      NOT NULL DEFAULT TRUE
);



CREATE TABLE file (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id   UUID         NOT NULL REFERENCES person(id) ON DELETE CASCADE,
    file_name   VARCHAR(255) NOT NULL,
    file_path   TEXT         NOT NULL,
    file_type   VARCHAR(50),
    file_size   BIGINT,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN      NOT NULL DEFAULT TRUE
);


-- MÓDULO 1: SEGURIDAD


CREATE TABLE "user" (
    id              UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id       UUID        NOT NULL REFERENCES person(id),
    username        VARCHAR(60) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL CHECK (LENGTH(password) >= 60),
    failed_attempts SMALLINT    NOT NULL DEFAULT 0 CHECK (failed_attempts <= 4),
    locked_until    TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID,
    updated_by      UUID,
    deleted_by      UUID,
    status          BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE role (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(80) NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE module (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(80) NOT NULL UNIQUE,
    description TEXT,
    icon        VARCHAR(80),
    route       VARCHAR(120),
    sort_order  SMALLINT    NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE system_view (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(80) NOT NULL,
    description TEXT,
    route       VARCHAR(120),
    sort_order  SMALLINT    NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE user_role (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id    UUID NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    role_id    UUID NOT NULL REFERENCES role(id)   ON DELETE CASCADE,
    UNIQUE (user_id, role_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE role_module (
    id         UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_id    UUID    NOT NULL REFERENCES role(id)   ON DELETE CASCADE,
    module_id  UUID    NOT NULL REFERENCES module(id) ON DELETE CASCADE,
    can_read   BOOLEAN NOT NULL DEFAULT FALSE,
    can_write  BOOLEAN NOT NULL DEFAULT FALSE,
    can_delete BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE (role_id, module_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE module_view (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    module_id  UUID NOT NULL REFERENCES module(id)      ON DELETE CASCADE,
    view_id    UUID NOT NULL REFERENCES system_view(id) ON DELETE CASCADE,
    UNIQUE (module_id, view_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status     BOOLEAN NOT NULL DEFAULT TRUE
);


-- MÓDULO 3: INVENTARIO


CREATE TABLE category (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(80) NOT NULL UNIQUE,
    description TEXT,
    image_url   TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE supplier (
    id         UUID         PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id  UUID         NOT NULL REFERENCES person(id),
    company    VARCHAR(120),
    created_at TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status     BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE product (
    id          UUID           PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID           NOT NULL REFERENCES category(id),
    supplier_id UUID           REFERENCES supplier(id),
    name        VARCHAR(120)   NOT NULL,
    unit_price  NUMERIC(10,2)  NOT NULL CHECK (unit_price >= 0),
    unit        VARCHAR(20)    NOT NULL CHECK (unit IN ('unidad','kg','gramo','litro','mililitro','porcion')),
    image_url   TEXT,
    created_at  TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN        NOT NULL DEFAULT TRUE
);

CREATE TABLE inventory (
    id           UUID           PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id   UUID           NOT NULL UNIQUE REFERENCES product(id) ON DELETE CASCADE,
    quantity     NUMERIC(12,3)  NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    min_stock    NUMERIC(12,3)  NOT NULL DEFAULT 0,
    max_stock    NUMERIC(12,3),
    last_updated TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    created_at   TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ,
    deleted_at   TIMESTAMPTZ,
    created_by   UUID,
    updated_by   UUID,
    deleted_by   UUID,
    status       BOOLEAN        NOT NULL DEFAULT TRUE
);


CREATE OR REPLACE FUNCTION fn_inventory_last_updated()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity <> OLD.quantity THEN
        NEW.last_updated = NOW();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_inventory_last_updated
BEFORE UPDATE ON inventory
FOR EACH ROW EXECUTE FUNCTION fn_inventory_last_updated();


-- MÓDULO 4: VENTAS


CREATE TABLE customer (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id  UUID NOT NULL UNIQUE REFERENCES person(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE method_payment (
    id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(60) NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE "order" (
    id                UUID          PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id       UUID          NOT NULL REFERENCES customer(id),
    method_payment_id UUID          NOT NULL REFERENCES method_payment(id),
    order_date        TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    total             NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (total >= 0),
    order_status      VARCHAR(20)   NOT NULL DEFAULT 'pending'
        CHECK (order_status IN ('pending','preparing','ready','delivered','cancelled')),
    created_at        TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ,
    deleted_at        TIMESTAMPTZ,
    created_by        UUID,
    updated_by        UUID,
    deleted_by        UUID,
    status            BOOLEAN       NOT NULL DEFAULT TRUE
);

CREATE TABLE order_item (
    id          UUID          PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id    UUID          NOT NULL REFERENCES "order"(id) ON DELETE CASCADE,
    product_id  UUID          NOT NULL REFERENCES product(id),
    quantity    NUMERIC(10,3) NOT NULL CHECK (quantity > 0),
    unit_price  NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    subtotal    NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    UNIQUE (order_id, product_id),
    created_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN       NOT NULL DEFAULT TRUE
);

-- TRIGGER: recalcula order.total al insertar/actualizar/eliminar un order_item
CREATE OR REPLACE FUNCTION fn_update_order_total()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE "order"
    SET total = (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM order_item
        WHERE order_id = COALESCE(NEW.order_id, OLD.order_id)
          AND deleted_at IS NULL
    ),
    updated_at = NOW()
    WHERE id = COALESCE(NEW.order_id, OLD.order_id);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_total
AFTER INSERT OR UPDATE OR DELETE ON order_item
FOR EACH ROW EXECUTE FUNCTION fn_update_order_total();


-- MÓDULO 5: FACTURACIÓN

CREATE TABLE invoice (
    id             UUID          PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id       UUID          NOT NULL UNIQUE REFERENCES "order"(id),
    -- CORRECCIÓN: customer_id se obtiene desde order; se mantiene por trazabilidad
    --             pero se sincroniza mediante FK a customer
    customer_id    UUID          NOT NULL REFERENCES customer(id),
    invoice_date   TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    invoice_number VARCHAR(30)   NOT NULL UNIQUE,
    total          NUMERIC(12,2) NOT NULL DEFAULT 0,
    created_at     TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMPTZ,
    deleted_at     TIMESTAMPTZ,
    created_by     UUID,
    updated_by     UUID,
    deleted_by     UUID,
    status         BOOLEAN       NOT NULL DEFAULT TRUE
);

-- CONSTRAINT: customer_id en invoice debe coincidir con el de la orden
-- Se valida mediante trigger para evitar inconsistencias
CREATE OR REPLACE FUNCTION fn_invoice_customer_check()
RETURNS TRIGGER AS $$
DECLARE
    v_customer_id UUID;
BEGIN
    SELECT customer_id INTO v_customer_id
    FROM "order" WHERE id = NEW.order_id;

    IF NEW.customer_id <> v_customer_id THEN
        RAISE EXCEPTION 'El customer_id de la factura no coincide con el de la orden.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_invoice_customer_check
BEFORE INSERT OR UPDATE ON invoice
FOR EACH ROW EXECUTE FUNCTION fn_invoice_customer_check();

CREATE TABLE invoice_item (
    id          UUID          PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id  UUID          NOT NULL REFERENCES invoice(id) ON DELETE CASCADE,
    product_id  UUID          NOT NULL REFERENCES product(id),
    quantity    NUMERIC(10,3) NOT NULL CHECK (quantity > 0),
    unit_price  NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    subtotal    NUMERIC(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    UNIQUE (invoice_id, product_id),
    created_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,
    deleted_at  TIMESTAMPTZ,
    created_by  UUID,
    updated_by  UUID,
    deleted_by  UUID,
    status      BOOLEAN       NOT NULL DEFAULT TRUE
);

CREATE TABLE payment (
    id                UUID          PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_id        UUID          NOT NULL REFERENCES invoice(id),
    method_payment_id UUID          NOT NULL REFERENCES method_payment(id),
    amount            NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    payment_date      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    created_at        TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ,
    deleted_at        TIMESTAMPTZ,
    created_by        UUID,
    updated_by        UUID,
    deleted_by        UUID,
    status            BOOLEAN       NOT NULL DEFAULT TRUE
);

-- TRIGGER: valida que la suma de pagos no supere el total de la factura
CREATE OR REPLACE FUNCTION fn_payment_amount_check()
RETURNS TRIGGER AS $$
DECLARE
    v_total_pagado NUMERIC(12,2);
    v_total_factura NUMERIC(12,2);
BEGIN
    SELECT COALESCE(SUM(amount), 0) INTO v_total_pagado
    FROM payment
    WHERE invoice_id = NEW.invoice_id
      AND deleted_at IS NULL;

    SELECT total INTO v_total_factura
    FROM invoice WHERE id = NEW.invoice_id;

    IF (v_total_pagado + NEW.amount) > v_total_factura THEN
        RAISE EXCEPTION 'El monto total de pagos (%) supera el total de la factura (%).',
            v_total_pagado + NEW.amount, v_total_factura;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_payment_amount_check
BEFORE INSERT ON payment
FOR EACH ROW EXECUTE FUNCTION fn_payment_amount_check();


-- ÍNDICES EN CLAVES FORÁNEAS PRINCIPALES

CREATE INDEX idx_person_type_document   ON person(type_document_id);
CREATE INDEX idx_file_person            ON file(person_id);
CREATE INDEX idx_user_person            ON "user"(person_id);
CREATE INDEX idx_user_role_user         ON user_role(user_id);
CREATE INDEX idx_user_role_role         ON user_role(role_id);
CREATE INDEX idx_role_module_role       ON role_module(role_id);
CREATE INDEX idx_role_module_module     ON role_module(module_id);
CREATE INDEX idx_module_view_module     ON module_view(module_id);
CREATE INDEX idx_module_view_view       ON module_view(view_id);
CREATE INDEX idx_product_category       ON product(category_id);
CREATE INDEX idx_product_supplier       ON product(supplier_id);
CREATE INDEX idx_inventory_product      ON inventory(product_id);
CREATE INDEX idx_supplier_person        ON supplier(person_id);
CREATE INDEX idx_customer_person        ON customer(person_id);
CREATE INDEX idx_order_customer         ON "order"(customer_id);
CREATE INDEX idx_order_method_payment   ON "order"(method_payment_id);
CREATE INDEX idx_order_item_order       ON order_item(order_id);
CREATE INDEX idx_order_item_product     ON order_item(product_id);
CREATE INDEX idx_invoice_order          ON invoice(order_id);
CREATE INDEX idx_invoice_customer       ON invoice(customer_id);
CREATE INDEX idx_invoice_item_invoice   ON invoice_item(invoice_id);
CREATE INDEX idx_invoice_item_product   ON invoice_item(product_id);
CREATE INDEX idx_payment_invoice        ON payment(invoice_id);
CREATE INDEX idx_payment_method         ON payment(method_payment_id);