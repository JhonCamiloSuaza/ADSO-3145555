-- Rollback de Auditoría (Tablas y Funciones)
DROP FUNCTION IF EXISTS audit_trigger_func() CASCADE;
DROP TABLE IF EXISTS audit_log CASCADE;
