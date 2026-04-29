-- Creamos o reemplazamos una función llamada 'contar_usuarios'
CREATE OR REPLACE FUNCTION contar_usuarios()
-- Esta función nos va a devolver un número entero (INTEGER)
RETURNS INTEGER AS $$
-- Sección para declarar variables internas
DECLARE
    -- Creamos una variable llamada 'total' que será de tipo numérico entero
    total INTEGER;
-- Aquí inicia el código real de la función
BEGIN
    -- Contamos cuántos registros (filas) existen en total usando COUNT(*)
    SELECT COUNT(*) 
    -- Guardamos ese número resultante dentro de nuestra variable 'total'
    INTO total 
    -- Indicamos que vamos a contar los datos de la tabla "user" (usuarios)
    FROM "user";
    
    -- Hacemos que la función entregue como resultado final el valor de 'total'
    RETURN total;
-- Aquí termina el bloque de código de la función
END;
-- Le indicamos al sistema que estamos usando el lenguaje PL/pgSQL
$$ LANGUAGE plpgsql;
