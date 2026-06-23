-- =============================================
-- VISTAS DE LECTURA POR DOMINIO
-- =============================================

-- Estudiantes con sus rutas asignadas.
CREATE OR REPLACE VIEW vw_estudiantes_rutas AS
SELECT
    e.ID AS EstudianteID,
    e.NombreCompleto AS EstudianteNombre,
    e.GradoEscolar,
    u.ID AS UsuarioID,
    u.NombreCompleto AS ResponsableNombre,
    u.Correo AS ResponsableCorreo,
    r.ID AS RutaID,
    r.NombreRuta,
    er.EstaActivo AS AsignacionActiva,
    er.AsignadoEn
FROM Estudiante e
JOIN Usuario u ON u.ID = e.UsuarioID
LEFT JOIN Estudiante_Ruta er ON er.EstudianteID = e.ID
LEFT JOIN Ruta r ON r.ID = er.RutaID
WHERE e.EliminadoEn IS NULL;

-- Resumen de trayectos para historial y reportes.
CREATE OR REPLACE VIEW vw_trayectos_resumen AS
SELECT
    t.ID AS TrayectoID,
    t.EstudianteID,
    e.NombreCompleto AS EstudianteNombre,
    e.UsuarioID,
    u.Correo AS ResponsableCorreo,
    t.RutaID,
    r.NombreRuta,
    t.InicioTrayecto,
    t.FinTrayecto,
    t.Estado,
    t.TuvoDesvio,
    COUNT(c.ID)::INTEGER AS TotalCoordenadas,
    MAX(c.RegistradoEn) AS UltimaCoordenadaEn
FROM Trayecto t
JOIN Estudiante e ON e.ID = t.EstudianteID
JOIN Usuario u ON u.ID = e.UsuarioID
JOIN Ruta r ON r.ID = t.RutaID
LEFT JOIN Coordenada c ON c.TrayectoID = t.ID
WHERE t.EliminadoEn IS NULL
GROUP BY
    t.ID,
    t.EstudianteID,
    e.NombreCompleto,
    e.UsuarioID,
    u.Correo,
    t.RutaID,
    r.NombreRuta,
    t.InicioTrayecto,
    t.FinTrayecto,
    t.Estado,
    t.TuvoDesvio;

-- Notificaciones por usuario receptor.
CREATE OR REPLACE VIEW vw_notificaciones_usuario AS
SELECT
    rn.ID AS ReciboID,
    rn.UsuarioID,
    u.Correo,
    n.ID AS NotificacionID,
    n.TrayectoID,
    n.ZonaSeguraID,
    n.TipoEvento,
    n.Mensaje,
    n.FechaHoraEvento,
    n.FueEnviada,
    rn.FueLeida,
    rn.RecibidoEn,
    rn.LeidoEn
FROM ReciboNotificacion rn
JOIN Usuario u ON u.ID = rn.UsuarioID
JOIN Notificacion n ON n.ID = rn.NotificacionID;
