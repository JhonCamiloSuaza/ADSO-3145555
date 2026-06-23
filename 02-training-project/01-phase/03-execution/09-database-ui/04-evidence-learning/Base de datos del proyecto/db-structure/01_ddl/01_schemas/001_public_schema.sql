-- Schema principal del proyecto.
-- PostgreSQL crea public por defecto, pero se declara en el changelog para
-- dejar trazabilidad explicita de la decision de usar un solo schema.
CREATE SCHEMA IF NOT EXISTS public;

COMMENT ON SCHEMA public IS 'Schema principal de GPS Guardian Escolar';
