-- Función del trigger
CREATE OR REPLACE FUNCTION verificar_precio()
RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.unit_price < 0 THEN
        RAISE EXCEPTION 'El precio no puede ser negativo';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
DROP TRIGGER IF EXISTS trigger_verificar_precio ON product;

CREATE TRIGGER trigger_verificar_precio
BEFORE INSERT OR UPDATE
ON product
FOR EACH ROW
EXECUTE FUNCTION verificar_precio();

-- Inserción correcta (precio positivo)
INSERT INTO product (category_id, name, unit_price, unit)
VALUES (
    'ae000000-0000-0000-0000-000000000001', -- Bebidas Calientes
    'Café Americano',
    5000.00,
    'unidad'
);






-- id generado automáticamente, categoría válida, precio positivo
INSERT INTO product (category_id, name, unit_price, unit)
VALUES (
    'ae000000-0000-0000-0000-000000000001', -- Bebidas Calientes
    'Té Verde',
    3000.00,
    'unidad'
);

-- Ahora lo actualizas con un precio válido
UPDATE product
SET unit_price = 3500.00
WHERE name = 'Té Verde';

-- Se actualiza sin problema

-- Ahora lo actualizas con un precio inválido
UPDATE product
SET unit_price = -1000.00
WHERE name = 'Té Verde';

--El trigger se dispara y lanza:
-- ERROR: El precio no puede ser negativo


--Hacemos un SELECT sobre la tabla aver si se modifico el precio
SELECT name, unit_price
FROM product
WHERE name = 'Té Verde';

