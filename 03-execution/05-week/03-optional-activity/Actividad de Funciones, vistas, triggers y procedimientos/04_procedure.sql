-- Creamos un procedimiento almacenado llamado 'actualizar_categoria'
CREATE OR REPLACE PROCEDURE actualizar_categoria(
    -- Definimos que debe recibir un parámetro llamado 'p_id' de tipo UUID (el identificador único)
    p_id UUID,
    -- Definimos que debe recibir un parámetro llamado 'p_nueva_descripcion' de tipo TEXT (texto largo)
    p_nueva_descripcion TEXT
)
-- Especificamos que este procedimiento usará el lenguaje PL/pgSQL
LANGUAGE plpgsql
-- Inicia el código del procedimiento
AS $$
-- Marca el comienzo de las acciones a realizar
BEGIN
    -- Ejecutamos la orden de actualizar (UPDATE) en la tabla 'category' (categoría)
    UPDATE category
    -- Asignamos (SET) a la columna 'description' el valor del parámetro 'p_nueva_descripcion' que recibimos
    SET description = p_nueva_descripcion
    -- Filtramos con WHERE para que solo cambie la categoría cuyo 'id' coincida con el parámetro 'p_id'
    WHERE id = p_id;
    
    -- Aplicamos y guardamos permanentemente la transacción en la base de datos
    COMMIT;
-- Termina el bloque de acciones
END;
-- Cerramos el cuerpo del procedimiento
$$;
