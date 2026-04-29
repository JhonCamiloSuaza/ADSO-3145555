-- Creamos (o reemplazamos si ya existe) una vista llamada 'vista_clientes'
CREATE OR REPLACE VIEW vista_clientes AS
-- Indicamos qué columnas queremos mostrar en la vista
SELECT 
    -- Tomamos el primer nombre de la tabla de personas (a la cual llamaremos 'p')
    p.first_name,
    -- Tomamos el apellido de la tabla de personas
    p.last_name,
    -- Tomamos el correo electrónico de la tabla de personas
    p.email
-- Decimos que la tabla principal de donde sacamos datos es 'customer' (cliente) y le damos el alias 'c'
FROM customer c
-- Unimos (JOIN) la tabla de clientes con la tabla 'person' (persona) y le damos el alias 'p'
JOIN person p 
-- Establecemos la regla para unirlas: que el 'person_id' del cliente sea exactamente igual al 'id' de la persona
ON c.person_id = p.id;
