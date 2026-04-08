-- Rollback: Drop new tables
DROP TABLE IF EXISTS inventory.product_review CASCADE;
DROP TABLE IF EXISTS inventory.brand CASCADE;
DROP TABLE IF EXISTS bill.payment_method CASCADE;
