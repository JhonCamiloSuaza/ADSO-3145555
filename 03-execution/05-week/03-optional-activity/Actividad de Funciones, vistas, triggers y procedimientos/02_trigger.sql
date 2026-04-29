-- Primero, creamos una función que será ejecutada por el trigger
CREATE OR REPLACE FUNCTION actualizar_fecha()
-- Esta función tiene que devolver un objeto de tipo TRIGGER
RETURNS TRIGGER AS $$
-- Empezamos el cuerpo de la función
BEGIN
    -- 'NEW' representa la fila que se está actualizando. Le asignamos la fecha/hora actual (NOW) a su campo 'updated_at'
    NEW.updated_at = NOW();
    -- Devolvemos la fila 'NEW' ya modificada con la nueva fecha
    RETURN NEW;
-- Terminamos el cuerpo de la función
END;
-- Indicamos que usamos el lenguaje PL/pgSQL
$$ LANGUAGE plpgsql;


-- Ahora creamos el trigger en sí, llamado 'trigger_actualizar_producto'
CREATE TRIGGER trigger_actualizar_producto
-- Le decimos que se active automáticamente ANTES (BEFORE) de hacer una actualización (UPDATE)
BEFORE UPDATE 
-- Le indicamos que vigile la tabla 'product' (producto)
ON product
-- Le decimos que se ejecute fila por fila (por cada registro que se modifique)
FOR EACH ROW
-- Finalmente, le ordenamos ejecutar la función 'actualizar_fecha' que creamos arriba
EXECUTE FUNCTION actualizar_fecha();
