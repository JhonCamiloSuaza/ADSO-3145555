-- =============================================
-- 5. ÍNDICES
-- =============================================

-- Usuario
CREATE INDEX idx_usuario_correo ON Usuario(Correo);
CREATE INDEX idx_usuario_activo ON Usuario(EstaActivo);
CREATE INDEX idx_usuario_eliminado ON Usuario(EliminadoEn) WHERE EliminadoEn IS NULL;

-- Estudiante
CREATE INDEX idx_estudiante_usuario ON Estudiante(UsuarioID);
CREATE INDEX idx_estudiante_activo ON Estudiante(EstaActivo);

-- Estudiante_Ruta
CREATE INDEX idx_estudiante_ruta_estudiante ON Estudiante_Ruta(EstudianteID);
CREATE INDEX idx_estudiante_ruta_ruta ON Estudiante_Ruta(RutaID);

-- Trayecto
CREATE INDEX idx_trayecto_estudiante ON Trayecto(EstudianteID);
CREATE INDEX idx_trayecto_ruta ON Trayecto(RutaID);
CREATE INDEX idx_trayecto_estado ON Trayecto(Estado);
CREATE INDEX idx_trayecto_inicio ON Trayecto(InicioTrayecto);

-- Parada
CREATE INDEX idx_parada_ruta ON Parada(RutaID);
CREATE INDEX idx_parada_orden ON Parada(RutaID, OrdenParada);

-- ZonaSegura
CREATE INDEX idx_zona_estudiante ON ZonaSegura(EstudianteID);

-- Coordenada
CREATE INDEX idx_coordenada_trayecto ON Coordenada(TrayectoID);

-- Notificacion
CREATE INDEX idx_notificacion_trayecto ON Notificacion(TrayectoID);

-- Seguridad
CREATE INDEX idx_usuario_rol_usuario ON Usuario_Rol(UsuarioID);
CREATE INDEX idx_sesion_usuario ON SesionUsuario(UsuarioID);
CREATE INDEX idx_sesion_token ON SesionUsuario(Token);

