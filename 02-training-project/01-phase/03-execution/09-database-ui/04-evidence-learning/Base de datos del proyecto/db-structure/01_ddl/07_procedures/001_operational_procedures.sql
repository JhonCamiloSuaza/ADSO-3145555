-- =============================================
-- PROCEDIMIENTOS OPERATIVOS
-- =============================================

-- Registro estandarizado de actividad funcional.
CREATE OR REPLACE PROCEDURE sp_registrar_actividad(
    p_usuario_id UUID,
    p_tipo_accion VARCHAR,
    p_descripcion TEXT,
    p_ip_origen INET DEFAULT NULL,
    p_metadatos JSONB DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO RegistroActividad (
        UsuarioID,
        TipoAccion,
        Descripcion,
        IpOrigen,
        Metadatos,
        CreadoEn
    )
    VALUES (
        p_usuario_id,
        p_tipo_accion,
        p_descripcion,
        p_ip_origen,
        p_metadatos,
        NOW()
    );
END;
$$;

-- Marca una notificacion como leida para un usuario especifico.
CREATE OR REPLACE PROCEDURE sp_marcar_notificacion_leida(
    p_recibo_id UUID,
    p_usuario_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ReciboNotificacion
    SET
        FueLeida = true,
        LeidoEn = COALESCE(LeidoEn, NOW())
    WHERE ID = p_recibo_id
      AND UsuarioID = p_usuario_id;
END;
$$;
