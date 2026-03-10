-- =============================================================================
-- SCRIPT DE PRUEBAS DE INTEGRIDAD REFERENCIAL
-- GPS Guardian Escolar v3 - PostgreSQL
-- Cada prueba incluye: descripción, SQL de prueba y resultado esperado
-- =============================================================================

-- ═══════════════════════════════════════════════════════════════════════════
-- BLOQUE A: PRUEBAS QUE DEBEN FALLAR (violan restricciones)
-- Resultado esperado: ERROR de PostgreSQL ✅ (el sistema protege correctamente)
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- A1. FK VIOLATION: Insertar estudiante con usuario inexistente
-- Esperado: ERROR - violación de FK fk_estudiante_usuario
-- ─────────────────────────────────────────────────────────────
INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar, fechanacimiento)
VALUES (nextval('seq_estudiante'), 9999, 1, 'Estudiante Fantasma', 'Grado 1°', '2015-01-01');
-- >> RESULTADO ESPERADO: ERROR: insert or update on table "estudiante" violates foreign key constraint "fk_estudiante_usuario"

-- ─────────────────────────────────────────────────────────────
-- A2. FK VIOLATION: Insertar trayecto con ruta inexistente
-- Esperado: ERROR - violación de FK fk_trayecto_ruta
-- ─────────────────────────────────────────────────────────────
INSERT INTO trayecto (trayectoid, rutaid, estudianteid, fechainicio, estadotrayecto)
VALUES (nextval('seq_trayecto'), 9999, 1, NOW(), 'En Progreso');
-- >> RESULTADO ESPERADO: ERROR: insert or update on table "trayecto" violates foreign key constraint "fk_trayecto_ruta"

-- ─────────────────────────────────────────────────────────────
-- A3. FK VIOLATION: Insertar coordenada con trayecto inexistente
-- Esperado: ERROR - violación de FK fk_coord_trayecto
-- ─────────────────────────────────────────────────────────────
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud)
VALUES (nextval('seq_coordenadas'), 9999, 4.711099, -74.072092);
-- >> RESULTADO ESPERADO: ERROR: insert or update on table "coordenadas" violates foreign key constraint "fk_coord_trayecto"

-- ─────────────────────────────────────────────────────────────
-- A4. CHECK VIOLATION: TipoUsuario inválido
-- Esperado: ERROR - violación de CHECK chk_usuario_tipo
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuario (usuarioid, nombrecompleto, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Test Inválido', 'test@test.com', 'pass123', 'Conductor');
-- >> RESULTADO ESPERADO: ERROR: new row for relation "usuario" violates check constraint "chk_usuario_tipo"

-- ─────────────────────────────────────────────────────────────
-- A5. CHECK VIOLATION: EstadoTrayecto inválido
-- Esperado: ERROR - violación de CHECK chk_trayecto_estado
-- ─────────────────────────────────────────────────────────────
INSERT INTO trayecto (trayectoid, rutaid, estudianteid, fechainicio, estadotrayecto)
VALUES (nextval('seq_trayecto'), 1, 1, NOW(), 'Desconocido');
-- >> RESULTADO ESPERADO: ERROR: new row for relation "trayecto" violates check constraint "chk_trayecto_estado"

-- ─────────────────────────────────────────────────────────────
-- A6. CHECK VIOLATION: Coordenadas GPS fuera de rango
-- Esperado: ERROR - violación de CHECK chk_coord_latitud
-- ─────────────────────────────────────────────────────────────
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud)
VALUES (nextval('seq_coordenadas'), 1, 200.000000, -74.072092);
-- >> RESULTADO ESPERADO: ERROR: new row for relation "coordenadas" violates check constraint "chk_coord_latitud"

-- ─────────────────────────────────────────────────────────────
-- A7. CHECK VIOLATION: Velocidad negativa
-- Esperado: ERROR - violación de CHECK chk_coord_velocidad
-- ─────────────────────────────────────────────────────────────
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, velocidad)
VALUES (nextval('seq_coordenadas'), 1, 4.711099, -74.072092, -50.00);
-- >> RESULTADO ESPERADO: ERROR: new row for relation "coordenadas" violates check constraint "chk_coord_velocidad"

-- ─────────────────────────────────────────────────────────────
-- A8. UNIQUE VIOLATION: Email duplicado en usuario
-- Esperado: ERROR - violación de UNIQUE uq_usuario_email
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuario (usuarioid, nombrecompleto, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Otro Usuario', 'laura.martinez@gmail.com', 'pass456', 'Padre');
-- >> RESULTADO ESPERADO: ERROR: duplicate key value violates unique constraint "uq_usuario_email"

-- ─────────────────────────────────────────────────────────────
-- A9. UNIQUE VIOLATION: Configuración duplicada por usuario (1:1)
-- Esperado: ERROR - violación de UNIQUE uq_confignotif_usuario
-- ─────────────────────────────────────────────────────────────
INSERT INTO confignotificacion (configid, usuarioid, alertaretraso, alertacambioruta, alertallegada)
VALUES (nextval('seq_confignotif'), 2, TRUE, TRUE, TRUE);
-- >> RESULTADO ESPERADO: ERROR: duplicate key value violates unique constraint "uq_confignotif_usuario"

-- ─────────────────────────────────────────────────────────────
-- A10. CHECK VIOLATION: Fechas incoherentes en trayecto
-- Esperado: ERROR - violación de CHECK chk_trayecto_fechas
-- ─────────────────────────────────────────────────────────────
INSERT INTO trayecto (trayectoid, rutaid, estudianteid, fechainicio, fechafin, estadotrayecto)
VALUES (nextval('seq_trayecto'), 1, 1, '2025-06-02 08:00:00', '2025-06-02 07:00:00', 'Finalizado');
-- >> RESULTADO ESPERADO: ERROR: new row for relation "trayecto" violates check constraint "chk_trayecto_fechas"

-- ─────────────────────────────────────────────────────────────
-- A11. FK VIOLATION: Eliminar ruta que tiene estudiantes asignados
-- Esperado: ERROR - violación de FK fk_estudiante_ruta
-- ─────────────────────────────────────────────────────────────
DELETE FROM ruta WHERE rutaid = 1;
-- >> RESULTADO ESPERADO: ERROR: update or delete on table "ruta" violates foreign key constraint "fk_estudiante_ruta"

-- ─────────────────────────────────────────────────────────────
-- A12. FK VIOLATION: Eliminar usuario padre con estudiantes
-- Esperado: ERROR - violación de FK fk_estudiante_usuario
-- ─────────────────────────────────────────────────────────────
DELETE FROM usuario WHERE usuarioid = 2;
-- >> RESULTADO ESPERADO: ERROR: update or delete on table "usuario" violates foreign key constraint "fk_estudiante_usuario"

-- ─────────────────────────────────────────────────────────────
-- A13. NOT NULL VIOLATION: Insertar estudiante sin nombre
-- Esperado: ERROR - violación de NOT NULL en nombreestudiante
-- ─────────────────────────────────────────────────────────────
INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar)
VALUES (nextval('seq_estudiante'), 2, 1, NULL, 'Grado 1°');
-- >> RESULTADO ESPERADO: ERROR: null value in column "nombreestudiante" violates not-null constraint

-- ─────────────────────────────────────────────────────────────
-- A14. CHECK VIOLATION: Tipo de evento de notificación inválido
-- Esperado: ERROR - violación de CHECK chk_notif_tipoevento
-- ─────────────────────────────────────────────────────────────
INSERT INTO notificacion (notificacionid, trayectoid, tipoevento, mensaje)
VALUES (nextval('seq_notificacion'), 1, 'EventoDesconocido', 'Mensaje de prueba');
-- >> RESULTADO ESPERADO: ERROR: new row for relation "notificacion" violates check constraint "chk_notif_tipoevento"

-- ═══════════════════════════════════════════════════════════════════════════
-- BLOQUE B: PRUEBAS QUE DEBEN PASAR (operaciones válidas)
-- Resultado esperado: INSERT/UPDATE exitoso ✅
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- B1. INSERT válido: Nuevo padre con estudiante en ruta existente
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuario (usuarioid, nombrecompleto, telefono, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Ana Ramírez Peña', '3112223344', 'ana.ramirez@gmail.com', '$2b$10$hashprueba', 'Padre');

INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar, fechanacimiento)
VALUES (nextval('seq_estudiante'),
        (SELECT usuarioid FROM usuario WHERE email = 'ana.ramirez@gmail.com'),
        1, 'Lucas Ramírez', 'Grado 2°', '2017-04-12');
-- >> RESULTADO ESPERADO: INSERT exitoso ✅

-- ─────────────────────────────────────────────────────────────
-- B2. UPDATE válido: Cambiar estado de trayecto
-- ─────────────────────────────────────────────────────────────
UPDATE trayecto
SET estadotrayecto = 'Finalizado',
    fechafin       = '2025-06-02 07:30:00',
    modificado_en  = CURRENT_TIMESTAMP
WHERE trayectoid = 3;
-- >> RESULTADO ESPERADO: UPDATE exitoso ✅

-- ─────────────────────────────────────────────────────────────
-- B3. UPDATE válido: Desactivar un estudiante (borrado lógico)
-- ─────────────────────────────────────────────────────────────
UPDATE estudiante
SET estado = FALSE, modificado_en = CURRENT_TIMESTAMP
WHERE estudianteid = 6;
-- >> RESULTADO ESPERADO: UPDATE exitoso ✅

-- ─────────────────────────────────────────────────────────────
-- B4. INSERT válido: Notificación sin trayecto (NULL permitido)
-- ─────────────────────────────────────────────────────────────
INSERT INTO notificacion (notificacionid, trayectoid, reportadopor, tipoevento, mensaje)
VALUES (nextval('seq_notificacion'), NULL, 1, 'Otro', 'Mantenimiento programado del sistema');
-- >> RESULTADO ESPERADO: INSERT exitoso ✅ (trayectoid admite NULL)

-- ─────────────────────────────────────────────────────────────
-- B5. DELETE válido: Eliminar ruta sin dependencias (Oriente=4)
-- ─────────────────────────────────────────────────────────────
DELETE FROM ruta WHERE rutaid = 4 AND NOT EXISTS (
    SELECT 1 FROM estudiante WHERE rutaid = 4
    UNION ALL
    SELECT 1 FROM trayecto   WHERE rutaid = 4
    UNION ALL
    SELECT 1 FROM parada     WHERE rutaid = 4
);
-- >> RESULTADO ESPERADO: DELETE exitoso ✅ (Ruta Oriente no tiene dependencias)

-- ═══════════════════════════════════════════════════════════════════════════
-- BLOQUE C: CONSULTAS DE VERIFICACIÓN POST-PRUEBA
-- ═══════════════════════════════════════════════════════════════════════════

-- C1. Ver todos los estudiantes con sus padres y rutas asignadas
SELECT
    e.estudianteid,
    e.nombreestudiante,
    e.gradoescolar,
    u.nombrecompleto   AS padre,
    r.nombreruta       AS ruta,
    e.estado           AS activo
FROM estudiante e
JOIN usuario u ON e.usuarioid = u.usuarioid
LEFT JOIN ruta r ON e.rutaid = r.rutaid
ORDER BY e.estudianteid;

-- C2. Ver trayectos con estudiante y estado
SELECT
    t.trayectoid,
    e.nombreestudiante,
    r.nombreruta,
    t.fechainicio,
    t.fechafin,
    t.estadotrayecto,
    COUNT(c.coordenadaid) AS total_coordenadas
FROM trayecto t
JOIN estudiante e ON t.estudianteid = e.estudianteid
JOIN ruta r       ON t.rutaid       = r.rutaid
LEFT JOIN coordenadas c ON c.trayectoid = t.trayectoid
GROUP BY t.trayectoid, e.nombreestudiante, r.nombreruta, t.fechainicio, t.fechafin, t.estadotrayecto
ORDER BY t.trayectoid;

-- C3. Ver notificaciones con receptor
SELECT
    n.notificacionid,
    n.tipoevento,
    n.mensaje,
    u.nombrecompleto   AS receptor,
    nr.receptortipo,
    nr.leida,
    n.estadoenvio
FROM notificacion n
JOIN notificacion_recibe nr ON n.notificacionid = nr.notificacionid
JOIN usuario u              ON nr.receptorid    = u.usuarioid
ORDER BY n.fechahora DESC;

-- C4. Resumen: total de registros por tabla principal
SELECT 'usuario'          AS tabla, COUNT(*) AS total FROM usuario
UNION ALL SELECT 'estudiante',     COUNT(*) FROM estudiante
UNION ALL SELECT 'ruta',           COUNT(*) FROM ruta
UNION ALL SELECT 'parada',         COUNT(*) FROM parada
UNION ALL SELECT 'trayecto',       COUNT(*) FROM trayecto
UNION ALL SELECT 'coordenadas',    COUNT(*) FROM coordenadas
UNION ALL SELECT 'notificacion',   COUNT(*) FROM notificacion;

-- =============================================================================
-- FIN SCRIPT DE PRUEBAS DE INTEGRIDAD REFERENCIAL
-- =============================================================================
