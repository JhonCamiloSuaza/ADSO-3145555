-- =============================================
-- VISTAS MATERIALIZADAS OPERATIVAS
-- =============================================

-- Resumen por estudiante para pantallas de monitoreo y reportes.
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_estudiantes_operacion AS
SELECT
    e.ID AS EstudianteID,
    e.NombreCompleto AS EstudianteNombre,
    e.GradoEscolar,
    e.EstaActivo AS EstudianteActivo,
    u.ID AS UsuarioID,
    u.NombreCompleto AS ResponsableNombre,
    u.Correo AS ResponsableCorreo,
    COUNT(DISTINCT er.RutaID) FILTER (WHERE er.EstaActivo IS TRUE) AS TotalRutasActivas,
    COUNT(DISTINCT t.ID) AS TotalTrayectos,
    COUNT(DISTINCT t.ID) FILTER (WHERE t.Estado = 'EN_CURSO') AS TrayectosEnCurso,
    COUNT(DISTINCT t.ID) FILTER (WHERE t.TuvoDesvio IS TRUE) AS TotalDesvios,
    MAX(c.RegistradoEn) AS UltimaCoordenadaEn
FROM Estudiante e
JOIN Usuario u ON u.ID = e.UsuarioID
LEFT JOIN Estudiante_Ruta er ON er.EstudianteID = e.ID
LEFT JOIN Trayecto t ON t.EstudianteID = e.ID AND t.EliminadoEn IS NULL
LEFT JOIN Coordenada c ON c.TrayectoID = t.ID
WHERE e.EliminadoEn IS NULL
GROUP BY
    e.ID,
    e.NombreCompleto,
    e.GradoEscolar,
    e.EstaActivo,
    u.ID,
    u.NombreCompleto,
    u.Correo
WITH NO DATA;

CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_estudiantes_operacion_estudiante
    ON mv_estudiantes_operacion(EstudianteID);

-- Resumen por ruta para reportes de operacion.
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_rutas_operacion AS
SELECT
    r.ID AS RutaID,
    r.NombreRuta,
    r.Descripcion,
    COUNT(DISTINCT p.ID) AS TotalParadas,
    COUNT(DISTINCT er.EstudianteID) FILTER (WHERE er.EstaActivo IS TRUE) AS TotalEstudiantesActivos,
    COUNT(DISTINCT t.ID) AS TotalTrayectos,
    COUNT(DISTINCT t.ID) FILTER (WHERE t.Estado = 'EN_CURSO') AS TrayectosEnCurso,
    COUNT(DISTINCT t.ID) FILTER (WHERE t.TuvoDesvio IS TRUE) AS TotalDesvios,
    MAX(t.InicioTrayecto) AS UltimoInicioTrayecto
FROM Ruta r
LEFT JOIN Parada p ON p.RutaID = r.ID
LEFT JOIN Estudiante_Ruta er ON er.RutaID = r.ID
LEFT JOIN Trayecto t ON t.RutaID = r.ID AND t.EliminadoEn IS NULL
WHERE r.EliminadoEn IS NULL
GROUP BY
    r.ID,
    r.NombreRuta,
    r.Descripcion
WITH NO DATA;

CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_rutas_operacion_ruta
    ON mv_rutas_operacion(RutaID);

-- Resumen de notificaciones por usuario receptor.
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_notificaciones_usuario_resumen AS
SELECT
    u.ID AS UsuarioID,
    u.NombreCompleto,
    u.Correo,
    COUNT(rn.ID) AS TotalRecibidas,
    COUNT(rn.ID) FILTER (WHERE rn.FueLeida IS FALSE) AS TotalNoLeidas,
    COUNT(n.ID) FILTER (WHERE n.FueEnviada IS TRUE) AS TotalEnviadas,
    MAX(n.FechaHoraEvento) AS UltimoEventoEn,
    MAX(rn.LeidoEn) AS UltimaLecturaEn
FROM Usuario u
LEFT JOIN ReciboNotificacion rn ON rn.UsuarioID = u.ID
LEFT JOIN Notificacion n ON n.ID = rn.NotificacionID
WHERE u.EliminadoEn IS NULL
GROUP BY
    u.ID,
    u.NombreCompleto,
    u.Correo
WITH NO DATA;

CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_notificaciones_usuario_resumen_usuario
    ON mv_notificaciones_usuario_resumen(UsuarioID);
