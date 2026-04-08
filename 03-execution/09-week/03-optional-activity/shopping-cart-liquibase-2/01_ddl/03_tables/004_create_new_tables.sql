-- Table: inventory.brand
CREATE TABLE inventory.brand (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
);

-- Table: inventory.product_review
CREATE TABLE inventory.product_review (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id)
        REFERENCES inventory.product(id),
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES security."user"(id)
);

-- Table: bill.payment_method
CREATE TABLE bill.payment_method (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMP,
    updated_by VARCHAR(100),
    state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
);
