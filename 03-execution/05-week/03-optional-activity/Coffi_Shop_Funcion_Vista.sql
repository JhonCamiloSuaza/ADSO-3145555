
-- Fecha y hora actual
SELECT NOW();

-- Sumar precios de productos
SELECT SUM(unit_price) FROM product;



--Funcion

CREATE OR REPLACE FUNCTION ver_producto(id_producto UUID)
RETURNS TABLE(nombre TEXT, precio NUMERIC)
AS $$
BEGIN
RETURN QUERY
SELECT 
p.name::TEXT,
p.unit_price
FROM product p
INNER JOIN category c
ON p.category_id = c.id
WHERE p.id = id_producto;
END;
$$ LANGUAGE plpgsql;

SELECT id FROM product;
SELECT * 
FROM ver_producto('b0000000-0000-0000-0000-000000000001');


-- VISTA
-- Creamos una vista llamada vista_productos_categoria
CREATE VIEW vista_productos_categoria AS
SELECT
p.name AS producto,
c.name AS categoria,
p.unit_price AS precio
FROM product p
-- INNER JOIN para unir product con category
INNER JOIN category c
ON p.category_id = c.id;

SELECT * FROM vista_productos_categoria;