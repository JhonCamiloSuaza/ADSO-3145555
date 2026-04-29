-- ================================================
-- SCRIPT AVANZADO DE LIMPIEZA DE DATOS (DELETE)
-- ================================================
-- Mejora: Se ejecuta dentro de un bloque DO (Transacción segura).
-- Si ocurre algún error a mitad del proceso (por ejemplo,
-- olvidamos una llave foránea), ninguna tabla se borrará,
-- protegiendo la integridad de tu base de datos.
-- ================================================

DO $$ 
BEGIN
    RAISE NOTICE 'Iniciando limpieza de la base de datos (Eliminando registros)...';

    -- 1. Módulo: Facturación y Pagos
    RAISE NOTICE 'Limpiando módulo de Facturación...';
    DELETE FROM payment;
    DELETE FROM invoice_item;
    DELETE FROM invoice;

    -- 2. Módulo: Ventas
    RAISE NOTICE 'Limpiando módulo de Ventas...';
    DELETE FROM order_item;
    DELETE FROM "order";
    DELETE FROM customer;

    -- 3. Módulo: Inventario
    RAISE NOTICE 'Limpiando módulo de Inventario...';
    DELETE FROM inventory;
    DELETE FROM product;
    DELETE FROM supplier;
    DELETE FROM category;

    -- 4. Módulo: Seguridad (Accesos y Roles)
    RAISE NOTICE 'Limpiando módulo de Seguridad...';
    DELETE FROM module_view;
    DELETE FROM role_module;
    DELETE FROM user_role;
    DELETE FROM "user";
    DELETE FROM vieww;
    DELETE FROM module;
    DELETE FROM role;

    -- 5. Módulo: Personas y Parámetros
    RAISE NOTICE 'Limpiando módulo de Personas y Parámetros...';
    DELETE FROM file;
    DELETE FROM person;
    DELETE FROM type_document;
    DELETE FROM method_payment;

    