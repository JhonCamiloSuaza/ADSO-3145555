/*
=============================================================================
                          DIAGRAMA DE RELACIONES 
=============================================================================

TABLAS PIVOTE (N:N):
===================

1. USER_ROLE (N:N)
   ┌─────────────────────────────────────┐
   │        USER_ROLE (Pivote)           │
   ├──────────────┬──────────────────────┤
   │  user_id (FK)│ → USER(id)           │
   │  role_id (FK)│ → ROLE(id)           │
   │  PRIMARY KEY │ (user_id, role_id)   │
   └─────────────────────────────────────┘
   Un usuario puede tener múltiples roles y viceversa.


2. ROLE_MODULE (N:N)
   ┌─────────────────────────────────────┐
   │      ROLE_MODULE (Pivote)           │
   ├──────────────┬──────────────────────┤
   │  role_id (FK)│ → ROLE(id)           │
   │ module_id(FK)│ → MODULE(id)         │
   │  PRIMARY KEY │ (role_id, module_id) │
   └─────────────────────────────────────┘
   Un rol puede acceder a múltiples módulos y viceversa.


3. MODULE_VIEW (N:N)
   ┌─────────────────────────────────────┐
   │      MODULE_VIEW (Pivote)           │
   ├──────────────┬──────────────────────┤
   │ module_id(FK)│ → MODULE(id)         │
   │  view_id (FK)│ → VIEWW(id)          │
   │  PRIMARY KEY │ (module_id, view_id) │
   └─────────────────────────────────────┘
   Un módulo muestra múltiples vistas y viceversa.


4. ORDER_ITEM (N:N - Con Detalles)
   ┌──────────────────────────────────────┐
   │      ORDER_ITEM (Pivote Detalle)     │
   ├──────────────┬───────────────────────┤
   │  order_id(FK)│ → ORDER(id)           │
   │ product_id(FK)│ → PRODUCT(id)        │
   │  quantity    │ (cantidad)            │
   │  unit_price  │ (precio)              │
   │  PRIMARY KEY │ (order_id, product_id)│
   └──────────────────────────────────────┘
   Un pedido tiene muchos productos y viceversa.


5. INVOICE_ITEM (N:N - Con Detalles)
   ┌──────────────────────────────────────┐
   │     INVOICE_ITEM (Pivote Detalle)    │
   ├──────────────┬───────────────────────┤
   │ invoice_id(FK)│ → INVOICE(id)        │
   │ product_id(FK)│ → PRODUCT(id)        │
   │  quantity    │ (cantidad)            │
   │  unit_price  │ (precio)              │
   │  PRIMARY KEY │ (invoice_id,product_id)
   └──────────────────────────────────────┘
   Una factura tiene múltiples productos y viceversa.


RELACIONES 1:N (Las más comunes):
=================================
TYPE_DOCUMENT   → PERSON (1:N)   [1 Tipo Doc → N Personas]
PERSON          → FILE (1:N)     [1 Persona → N Archivos]
PERSON          → USER (1:N)     [1 Persona → N Usuarios]
PERSON          → SUPPLIER (1:N) [1 Persona → N Proveedores]
PERSON          → CUSTOMER (1:N) [1 Persona → N Clientes]
CATEGORY        → PRODUCT (1:N)  [1 Categoría → N Productos]
SUPPLIER        → PRODUCT (1:N)  [1 Proveedor → N Productos]
PRODUCT         → INVENTORY (1:N)[1 Producto → N Registros Inventario]
CUSTOMER        → ORDER (1:N)    [1 Cliente → N Pedidos]
USER (Vendedor) → ORDER (1:N)    [1 Usuario → N Pedidos atendidos]
ORDER           → INVOICE (1:N)  [1 Pedido → N Facturas]
INVOICE         → PAYMENT (1:N)  [1 Factura → N Pagos]
METHOD_PAYMENT  → PAYMENT (1:N)  [1 Método Pago → N Pagos]


CAMPOS DE AUDITORÍA (USER → TODAS LAS TABLAS):
==============================================
Casi todas las tablas (product, inventory, order, invoice, etc.)
tienen campos de auditoría que referencian a USER:
   │  created_by → USER(id)  (Quién lo creó)
   │  updated_by → USER(id)  (Quién lo editó)
   │  deleted_by → USER(id)  (Quién lo borró)

=============================================================================
                          CÓDIGO SQL (FOREIGN KEYS)
=============================================================================
*/

-- Módulo Parámetros y Personas
ALTER TABLE person ADD CONSTRAINT fk_person_typedoc FOREIGN KEY (type_document_id) REFERENCES type_document(id);
ALTER TABLE file ADD CONSTRAINT fk_file_person FOREIGN KEY (person_id) REFERENCES person(id);

-- Módulo Seguridad
ALTER TABLE "user" ADD CONSTRAINT fk_user_person FOREIGN KEY (person_id) REFERENCES person(id);

ALTER TABLE user_role ADD CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE;
ALTER TABLE user_role ADD CONSTRAINT fk_ur_role FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE;

ALTER TABLE role_module ADD CONSTRAINT fk_rm_role FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE;
ALTER TABLE role_module ADD CONSTRAINT fk_rm_module FOREIGN KEY (module_id) REFERENCES module(id) ON DELETE CASCADE;

ALTER TABLE module_view ADD CONSTRAINT fk_mv_module FOREIGN KEY (module_id) REFERENCES module(id) ON DELETE CASCADE;
ALTER TABLE module_view ADD CONSTRAINT fk_mv_view FOREIGN KEY (view_id) REFERENCES vieww(id) ON DELETE CASCADE;

-- Módulo Inventario
ALTER TABLE supplier ADD CONSTRAINT fk_supplier_person FOREIGN KEY (person_id) REFERENCES person(id);

ALTER TABLE product ADD CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category(id);
ALTER TABLE product ADD CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(id);

ALTER TABLE inventory ADD CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES product(id);

-- Módulo Ventas
ALTER TABLE customer ADD CONSTRAINT fk_customer_person FOREIGN KEY (person_id) REFERENCES person(id);

ALTER TABLE "order" ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customer(id);
ALTER TABLE "order" ADD CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES "user"(id);

ALTER TABLE order_item ADD CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES "order"(id) ON DELETE CASCADE;
ALTER TABLE order_item ADD CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES product(id);

-- Módulo Facturación y Pagos
ALTER TABLE invoice ADD CONSTRAINT fk_invoice_order FOREIGN KEY (order_id) REFERENCES "order"(id);

ALTER TABLE invoice_item ADD CONSTRAINT fk_ii_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id) ON DELETE CASCADE;
ALTER TABLE invoice_item ADD CONSTRAINT fk_ii_product FOREIGN KEY (product_id) REFERENCES product(id);

ALTER TABLE payment ADD CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id);
ALTER TABLE payment ADD CONSTRAINT fk_payment_method FOREIGN KEY (method_payment_id) REFERENCES method_payment(id);
