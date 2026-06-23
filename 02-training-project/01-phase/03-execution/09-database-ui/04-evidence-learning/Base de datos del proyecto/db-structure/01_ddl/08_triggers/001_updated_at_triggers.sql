-- =============================================
-- TRIGGERS PARA ACTUALIZADOEN
-- =============================================

CREATE TRIGGER trg_usuario_actualizadoen
BEFORE UPDATE ON Usuario
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_estudiante_actualizadoen
BEFORE UPDATE ON Estudiante
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_contactoemergencia_actualizadoen
BEFORE UPDATE ON ContactoEmergencia
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_ruta_actualizadoen
BEFORE UPDATE ON Ruta
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_parada_actualizadoen
BEFORE UPDATE ON Parada
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_rol_actualizadoen
BEFORE UPDATE ON Rol
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_permiso_actualizadoen
BEFORE UPDATE ON Permiso
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_sesionusuario_actualizadoen
BEFORE UPDATE ON SesionUsuario
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_politicacontrasena_actualizadoen
BEFORE UPDATE ON PoliticaContrasena
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_configuracionseguridad_actualizadoen
BEFORE UPDATE ON ConfiguracionSeguridad
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_zonasegura_actualizadoen
BEFORE UPDATE ON ZonaSegura
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_trayecto_actualizadoen
BEFORE UPDATE ON Trayecto
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_coordenada_actualizadoen
BEFORE UPDATE ON Coordenada
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_configuracionnotificacion_actualizadoen
BEFORE UPDATE ON ConfiguracionNotificacion
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();

CREATE TRIGGER trg_recibonotificacion_actualizadoen
BEFORE UPDATE ON ReciboNotificacion
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_actualizado_en();
