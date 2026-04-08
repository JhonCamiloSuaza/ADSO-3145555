-- Rollback: Delete new data
DELETE FROM inventory.brand WHERE name IN ('Apple', 'Samsung', 'Sony', 'Nike', 'Adidas');
DELETE FROM bill.payment_method WHERE name IN ('EFECTIVO', 'DAVIVIENDA', 'DAVIPLATA', 'BBVA', 'BANCO_DE_BOGOTA', 'BANCO_AGRARIO');
