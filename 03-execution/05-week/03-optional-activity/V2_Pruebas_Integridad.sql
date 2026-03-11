
-- Nicolás Estid Ruiz Sastoque
-- Jhon Camilo Suaza Sánchez
 --  Andrey Culma Gómez
-- SENA - Análisis y Desarrollo de Software — Ficha 3145555
-- ============================================================================
--   ~ A2, A5, A10: corregidos — trayecto ya no requiere estudianteid
--   ~ A4: corregida — 'Conductor' ahora ES válido; se prueba con 'Operador'
--   + A15–A26: pruebas nuevas para conductor, vehiculo, trayecto_estudiante
--   ~ B1: INSERT de trayecto ya no necesita estudianteid
--   + B6–B9: pruebas positivas nuevas para tablas v2.0
--   ~ C2: consulta actualizada usando trayecto_estudiante
--   + C5–C6: consultas nuevas de verificación del modelo completo
-- =============================================================================
-- INSTRUCCIONES:
--   Ejecutar prueba por prueba para ver el resultado esperado
--   Las pruebas NEGATIVAS (A) deben generar ERROR — eso es correcto ✅
--   Las pruebas POSITIVAS (B) deben ejecutarse sin error ✅
-- =============================================================================


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOQUE A: PRUEBAS NEGATIVAS — DEBEN GENERAR ERROR
-- El error confirma que la BD está protegiendo correctamente los datos
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- A1. FK VIOLATION: Estudiante con usuario inexistente
-- Esperado: ERROR — fk_estudiante_usuario
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar, fechanacimiento)
VALUES (nextval('seq_estudiante'), 9999, 1, 'Estudiante Fantasma', 'Grado 1°', '2015-01-01');
ROLLBACK;
-- >> ERROR: insert or update on table "estudiante" violates foreign key constraint "fk_estudiante_usuario"

-- ─────────────────────────────────────────────────────────────
-- A2. FK VIOLATION: Trayecto con ruta inexistente
-- CORRECCIÓN v2.0: estudianteid ya no es requerido (NULL)
-- Esperado: ERROR — fk_trayecto_ruta
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO trayecto (trayectoid, rutaid, fechainicio, estadotrayecto)
VALUES (nextval('seq_trayecto'), 9999, NOW(), 'En Progreso');
ROLLBACK;
-- >> ERROR: insert or update on table "trayecto" violates foreign key constraint "fk_trayecto_ruta"

-- ─────────────────────────────────────────────────────────────
-- A3. FK VIOLATION: Coordenada con trayecto inexistente
-- Esperado: ERROR — fk_coord_trayecto
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud)
VALUES (nextval('seq_coordenadas'), 9999, 4.711099, -74.072092);
ROLLBACK;
-- >> ERROR: insert or update on table "coordenadas" violates foreign key constraint "fk_coord_trayecto"

-- ─────────────────────────────────────────────────────────────
-- A4. CHECK VIOLATION: tipousuario con valor no permitido
-- CORRECCIÓN v2.0: 'Conductor' ahora ES válido — se prueba con 'Operador'
-- Esperado: ERROR — chk_usuario_tipo
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO usuario (usuarioid, nombrecompleto, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Test Inválido', 'test.invalido@test.com', 'pass123', 'Operador');
ROLLBACK;
-- >> ERROR: new row for relation "usuario" violates check constraint "chk_usuario_tipo"

-- ─────────────────────────────────────────────────────────────
-- A4b. VERIFICACIÓN POSITIVA: 'Conductor' SÍ es válido en v2.0
-- Esperado: INSERT exitoso ✅ (confirma que el constraint fue actualizado)
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO usuario (usuarioid, nombrecompleto, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Conductor Test', 'conductor.test@test.com', 'hash999', 'Conductor');
-- >> INSERT exitoso ✅ — 'Conductor' es un tipo válido desde v2.0
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- A5. CHECK VIOLATION: estadotrayecto con valor no permitido
-- CORRECCIÓN v2.0: estudianteid ya no es requerido
-- Esperado: ERROR — chk_trayecto_estado
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO trayecto (trayectoid, rutaid, fechainicio, estadotrayecto)
VALUES (nextval('seq_trayecto'), 1, NOW(), 'Desconocido');
ROLLBACK;
-- >> ERROR: new row for relation "trayecto" violates check constraint "chk_trayecto_estado"

-- ─────────────────────────────────────────────────────────────
-- A6. CHECK VIOLATION: Latitud GPS fuera de rango (> 90)
-- Esperado: ERROR — chk_coord_latitud
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud)
VALUES (nextval('seq_coordenadas'), 1, 200.000000, -74.072092);
ROLLBACK;
-- >> ERROR: new row for relation "coordenadas" violates check constraint "chk_coord_latitud"

-- ─────────────────────────────────────────────────────────────
-- A7. CHECK VIOLATION: Velocidad negativa
-- Esperado: ERROR — chk_coord_velocidad
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, velocidad)
VALUES (nextval('seq_coordenadas'), 1, 4.711099, -74.072092, -50.00);
ROLLBACK;
-- >> ERROR: new row for relation "coordenadas" violates check constraint "chk_coord_velocidad"

-- ─────────────────────────────────────────────────────────────
-- A8. UNIQUE VIOLATION: Email duplicado en usuario
-- Esperado: ERROR — uq_usuario_email
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO usuario (usuarioid, nombrecompleto, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Otro Usuario', 'laura.martinez@gmail.com', 'pass456', 'Padre');
ROLLBACK;
-- >> ERROR: duplicate key value violates unique constraint "uq_usuario_email"

-- ─────────────────────────────────────────────────────────────
-- A9. UNIQUE VIOLATION: Configuración de notificación duplicada (relación 1:1)
-- Esperado: ERROR — uq_confignotif_usuario
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO confignotificacion (configid, usuarioid, alertaretraso, alertacambioruta, alertallegada)
VALUES (nextval('seq_confignotif'), 2, TRUE, TRUE, TRUE);
ROLLBACK;
-- >> ERROR: duplicate key value violates unique constraint "uq_confignotif_usuario"

-- ─────────────────────────────────────────────────────────────
-- A10. CHECK VIOLATION: Fechas incoherentes en trayecto (fin < inicio)
-- CORRECCIÓN v2.0: estudianteid ya no es requerido
-- Esperado: ERROR — chk_trayecto_fechas
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO trayecto (trayectoid, rutaid, fechainicio, fechafin, estadotrayecto)
VALUES (nextval('seq_trayecto'), 1, '2025-06-02 08:00:00', '2025-06-02 07:00:00', 'Finalizado');
ROLLBACK;
-- >> ERROR: new row for relation "trayecto" violates check constraint "chk_trayecto_fechas"

-- ─────────────────────────────────────────────────────────────
-- A11. FK VIOLATION: Eliminar ruta con estudiantes asignados
-- Esperado: ERROR — fk_estudiante_ruta
-- ─────────────────────────────────────────────────────────────
BEGIN;
DELETE FROM ruta WHERE rutaid = 1;
ROLLBACK;
-- >> ERROR: update or delete on table "ruta" violates foreign key constraint "fk_estudiante_ruta"

-- ─────────────────────────────────────────────────────────────
-- A12. FK VIOLATION: Eliminar usuario padre con estudiantes registrados
-- Esperado: ERROR — fk_estudiante_usuario
-- ─────────────────────────────────────────────────────────────
BEGIN;
DELETE FROM usuario WHERE usuarioid = 2;
ROLLBACK;
-- >> ERROR: update or delete on table "usuario" violates foreign key constraint "fk_estudiante_usuario"

-- ─────────────────────────────────────────────────────────────
-- A13. NOT NULL VIOLATION: Estudiante sin nombre
-- Esperado: ERROR — NOT NULL en nombreestudiante
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar)
VALUES (nextval('seq_estudiante'), 2, 1, NULL, 'Grado 1°');
ROLLBACK;
-- >> ERROR: null value in column "nombreestudiante" violates not-null constraint

-- ─────────────────────────────────────────────────────────────
-- A14. CHECK VIOLATION: Tipo de evento de notificación inválido
-- Esperado: ERROR — chk_notif_tipoevento
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO notificacion (notificacionid, trayectoid, tipoevento, mensaje)
VALUES (nextval('seq_notificacion'), 1, 'EventoDesconocido', 'Mensaje de prueba');
ROLLBACK;
-- >> ERROR: new row for relation "notificacion" violates check constraint "chk_notif_tipoevento"

-- ═══════════════════════════════════════════════════════════════════════════
-- PRUEBAS NUEVAS — CONDUCTOR
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- A15. FK VIOLATION: Conductor con usuarioid inexistente
-- Esperado: ERROR — fk_conductor_usuario
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO conductor (conductorid, usuarioid, numerolicencia, categoriaLicencia, fechavencimiento, documentoidentidad)
VALUES (nextval('seq_conductor'), 9999, 'LIC-FAKE-001', 'C1', '2028-01-01', '0000000000');
ROLLBACK;
-- >> ERROR: insert or update on table "conductor" violates foreign key constraint "fk_conductor_usuario"

-- ─────────────────────────────────────────────────────────────
-- A16. CHECK VIOLATION: Categoría de licencia no válida en Colombia
-- Esperado: ERROR — chk_conductor_categoria
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO conductor (conductorid, usuarioid, numerolicencia, categoriaLicencia, fechavencimiento, documentoidentidad)
VALUES (nextval('seq_conductor'), 7, 'LIC-FAKE-002', 'Z9', '2028-01-01', '1111111111');
ROLLBACK;
-- >> ERROR: new row for relation "conductor" violates check constraint "chk_conductor_categoria"

-- ─────────────────────────────────────────────────────────────
-- A17. CHECK VIOLATION: Licencia ya vencida al momento del registro
-- Esperado: ERROR — chk_conductor_licencia
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO conductor (conductorid, usuarioid, numerolicencia, categoriaLicencia, fechavencimiento, documentoidentidad)
VALUES (nextval('seq_conductor'), 8, 'LIC-FAKE-003', 'C1', '2020-01-01', '2222222222');
ROLLBACK;
-- >> ERROR: new row for relation "conductor" violates check constraint "chk_conductor_licencia"

-- ─────────────────────────────────────────────────────────────
-- A18. UNIQUE VIOLATION: Número de licencia duplicado
-- Esperado: ERROR — uq_conductor_licencia
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO usuario (usuarioid, nombrecompleto, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Conductor Duplicado', 'cond.dup@test.com', 'hash000', 'Conductor');
INSERT INTO conductor (conductorid, usuarioid, numerolicencia, categoriaLicencia, fechavencimiento, documentoidentidad)
VALUES (nextval('seq_conductor'),
       (SELECT usuarioid FROM usuario WHERE email = 'cond.dup@test.com'),
       'COL-LIC-001234',  -- ya existe en los datos de prueba
       'C2', '2028-01-01', '9999999991');
ROLLBACK;
-- >> ERROR: duplicate key value violates unique constraint "uq_conductor_licencia"

-- ─────────────────────────────────────────────────────────────
-- A19. FK VIOLATION: Eliminar conductor con trayectos asignados
-- Esperado: ERROR — fk_trayecto_conductor
-- ─────────────────────────────────────────────────────────────
BEGIN;
DELETE FROM conductor WHERE conductorid = 1;
ROLLBACK;
-- >> ERROR: update or delete on table "conductor" violates foreign key constraint "fk_trayecto_conductor"

-- ═══════════════════════════════════════════════════════════════════════════
-- PRUEBAS NUEVAS v2.0 — VEHÍCULO
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- A20. CHECK VIOLATION: Capacidad del vehículo = 0
-- Esperado: ERROR — chk_vehiculo_capacidad
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO vehiculo (vehiculoid, placa, capacidad, estadovehiculo)
VALUES (nextval('seq_vehiculo'), 'ZZZ001', 0, 'Disponible');
ROLLBACK;
-- >> ERROR: new row for relation "vehiculo" violates check constraint "chk_vehiculo_capacidad"

-- ─────────────────────────────────────────────────────────────
-- A21. CHECK VIOLATION: Capacidad del vehículo > 80
-- Esperado: ERROR — chk_vehiculo_capacidad
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO vehiculo (vehiculoid, placa, capacidad, estadovehiculo)
VALUES (nextval('seq_vehiculo'), 'ZZZ002', 100, 'Disponible');
ROLLBACK;
-- >> ERROR: new row for relation "vehiculo" violates check constraint "chk_vehiculo_capacidad"

-- ─────────────────────────────────────────────────────────────
-- A22. CHECK VIOLATION: Estado del vehículo no permitido
-- Esperado: ERROR — chk_vehiculo_estado
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO vehiculo (vehiculoid, placa, capacidad, estadovehiculo)
VALUES (nextval('seq_vehiculo'), 'ZZZ003', 15, 'Activo');
ROLLBACK;
-- >> ERROR: new row for relation "vehiculo" violates check constraint "chk_vehiculo_estado"

-- ─────────────────────────────────────────────────────────────
-- A23. UNIQUE VIOLATION: Placa de vehículo duplicada
-- Esperado: ERROR — uq_vehiculo_placa
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO vehiculo (vehiculoid, placa, capacidad, estadovehiculo)
VALUES (nextval('seq_vehiculo'), 'ABC123', 15, 'Disponible');  -- ABC123 ya existe
ROLLBACK;
-- >> ERROR: duplicate key value violates unique constraint "uq_vehiculo_placa"

-- ─────────────────────────────────────────────────────────────
-- A24. FK VIOLATION: Eliminar vehículo con trayectos asignados
-- Esperado: ERROR — fk_trayecto_vehiculo
-- ─────────────────────────────────────────────────────────────
BEGIN;
DELETE FROM vehiculo WHERE vehiculoid = 1;
ROLLBACK;
-- >> ERROR: update or delete on table "vehiculo" violates foreign key constraint "fk_trayecto_vehiculo"

-- ═══════════════════════════════════════════════════════════════════════════
-- PRUEBAS NUEVAS v2.0 — TRAYECTO_ESTUDIANTE
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- A25. UNIQUE VIOLATION: Estudiante duplicado en el mismo trayecto
-- Sofía (est 1) ya está en trayecto 1 — no puede aparecer dos veces
-- Esperado: ERROR — uq_trayecto_estudiante
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero)
VALUES (1, 1, 'A Bordo');
ROLLBACK;
-- >> ERROR: duplicate key value violates unique constraint "uq_trayecto_estudiante"

-- ─────────────────────────────────────────────────────────────
-- A26. CHECK VIOLATION: Estado de pasajero no válido
-- Esperado: ERROR — chk_pasajero_estado
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero)
VALUES (3, 4, 'Extraviado');  -- 'Extraviado' no es un estado válido
ROLLBACK;
-- >> ERROR: new row for relation "trayecto_estudiante" violates check constraint "chk_pasajero_estado"


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOQUE B: PRUEBAS POSITIVAS — DEBEN EJECUTARSE SIN ERROR ✅
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- B1. INSERT válido: Nuevo padre con estudiante en ruta existente
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO usuario (usuarioid, nombrecompleto, telefono, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Ana Ramírez Peña', '3112223344', 'ana.ramirez@gmail.com', '$2b$10$hashprueba', 'Padre');

INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar, fechanacimiento)
VALUES (nextval('seq_estudiante'),
        (SELECT usuarioid FROM usuario WHERE email = 'ana.ramirez@gmail.com'),
        1, 'Lucas Ramírez', 'Grado 2°', '2017-04-12');
-- >> INSERT exitoso ✅
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B2. UPDATE válido: Finalizar trayecto en progreso
-- ─────────────────────────────────────────────────────────────
BEGIN;
UPDATE trayecto
SET estadotrayecto = 'Finalizado',
    fechafin       = '2025-06-02 07:30:00',
    modificado_en  = CURRENT_TIMESTAMP
WHERE trayectoid = 3;
-- >> UPDATE exitoso ✅
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B3. UPDATE válido: Desactivar estudiante (borrado lógico)
-- ─────────────────────────────────────────────────────────────
BEGIN;
UPDATE estudiante
SET estado = FALSE, modificado_en = CURRENT_TIMESTAMP
WHERE estudianteid = 6;
-- >> UPDATE exitoso ✅
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B4. INSERT válido: Notificación sin trayecto (trayectoid NULL permitido)
-- Útil para avisos generales del sistema que no van ligados a un viaje
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO notificacion (notificacionid, trayectoid, reportadopor, tipoevento, mensaje)
VALUES (nextval('seq_notificacion'), NULL, 1, 'Otro', 'Mantenimiento programado del sistema esta noche');
-- >> INSERT exitoso ✅ (trayectoid admite NULL)
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B5. DELETE válido: Eliminar ruta sin dependencias (Ruta Oriente = rutaid 4)
-- ─────────────────────────────────────────────────────────────
BEGIN;
DELETE FROM ruta WHERE rutaid = 4
  AND NOT EXISTS (SELECT 1 FROM estudiante WHERE rutaid = 4)
  AND NOT EXISTS (SELECT 1 FROM trayecto   WHERE rutaid = 4)
  AND NOT EXISTS (SELECT 1 FROM parada     WHERE rutaid = 4)
  AND NOT EXISTS (SELECT 1 FROM vehiculo   WHERE rutaid = 4);
-- >> DELETE exitoso ✅ (Ruta Oriente suspendida no tiene dependencias)
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B6. INSERT válido: Nuevo conductor correctamente registrado
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO usuario (usuarioid, nombrecompleto, telefono, email, contrasena, tipousuario)
VALUES (nextval('seq_usuario'), 'Ana Lucía Torres', '3115556677', 'ana.torres.cond@guardian.com', 'hashana', 'Conductor');

INSERT INTO conductor (conductorid, usuarioid, numerolicencia, categoriaLicencia, fechavencimiento, documentoidentidad)
VALUES (nextval('seq_conductor'),
        (SELECT usuarioid FROM usuario WHERE email = 'ana.torres.cond@guardian.com'),
        'COL-LIC-NEW001', 'B2', '2029-12-31', '7788990011');
-- >> INSERT exitoso ✅
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B7. INSERT válido: Nuevo vehículo sin ruta asignada (rutaid NULL)
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO vehiculo (vehiculoid, placa, marca, modelo, anio, capacidad, rutaid, estadovehiculo, color)
VALUES (nextval('seq_vehiculo'), 'MNO345', 'Renault', 'Master', 2022, 17, NULL, 'Disponible', 'Blanco');
-- >> INSERT exitoso ✅ (rutaid NULL significa disponible sin asignar)
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B8. UPDATE válido: Conductor marca estudiante como 'Entregado'
-- Simula el momento en que el bus llega al colegio y el conductor marca ✓
-- ─────────────────────────────────────────────────────────────
BEGIN;
UPDATE trayecto_estudiante
SET estado_pasajero = 'Entregado',
    hora_bajada     = CURRENT_TIMESTAMP,
    parada_bajada   = 9   -- Colegio Central (paradaid=9, ruta centro)
WHERE trayectoid = 3 AND estudianteid = 4;
-- >> UPDATE exitoso ✅
ROLLBACK;

-- ─────────────────────────────────────────────────────────────
-- B9. INSERT válido: Notificaciones con todos los tipos nuevos
-- Verifica que el CHECK chk_notif_tipoevento acepta los tipos v2.0
-- ─────────────────────────────────────────────────────────────
BEGIN;
INSERT INTO notificacion (notificacionid, trayectoid, reportadopor, tipoevento, mensaje) VALUES
(nextval('seq_notificacion'), 1, 7, 'EstudianteABordo',  'Prueba: estudiante a bordo'),
(nextval('seq_notificacion'), 5, 1, 'BusVarado',         'Prueba: bus varado detectado'),
(nextval('seq_notificacion'), 3, 9, 'ViaObstruida',      'Prueba: vía obstruida'),
(nextval('seq_notificacion'), 3, 9, 'DesvioTemporal',    'Prueba: desvío temporal'),
(nextval('seq_notificacion'), 3, 1, 'ProximoLlegar',     'Prueba: próximo a llegar'),
(nextval('seq_notificacion'), 4, 7, 'EstudianteAusente', 'Prueba: estudiante ausente');
-- >> INSERT exitoso ✅ — todos los tipos nuevos son válidos
ROLLBACK;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOQUE C: CONSULTAS DE VERIFICACIÓN POST-PRUEBA
-- ═══════════════════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- C1. Estudiantes con sus padres y rutas asignadas
-- ─────────────────────────────────────────────────────────────
SELECT
    e.estudianteid,
    e.nombreestudiante,
    e.gradoescolar,
    u.nombrecompleto   AS padre,
    r.nombreruta       AS ruta,
    e.estado           AS activo
FROM estudiante e
JOIN usuario u    ON e.usuarioid = u.usuarioid
LEFT JOIN ruta r  ON e.rutaid    = r.rutaid
ORDER BY e.estudianteid;

-- ─────────────────────────────────────────────────────────────
-- C2. Trayectos con conductor, vehículo y cantidad de pasajeros
-- ACTUALIZACIÓN  usa trayecto_estudiante (N:M)
-- ─────────────────────────────────────────────────────────────
SELECT
    t.trayectoid,
    r.nombreruta,
    u.nombrecompleto          AS conductor,
    v.placa                   AS vehiculo,
    t.estadotrayecto,
    t.fechainicio,
    t.fechafin,
    COUNT(te.estudianteid)    AS total_pasajeros,
    COUNT(te.estudianteid) FILTER (WHERE te.estado_pasajero = 'Entregado') AS entregados,
    COUNT(te.estudianteid) FILTER (WHERE te.estado_pasajero = 'Ausente')   AS ausentes,
    COUNT(c.coordenadaid)     AS puntos_gps
FROM trayecto t
JOIN ruta r ON r.rutaid = t.rutaid
LEFT JOIN conductor  cd ON cd.conductorid = t.conductorid
LEFT JOIN usuario    u  ON u.usuarioid    = cd.usuarioid
LEFT JOIN vehiculo   v  ON v.vehiculoid   = t.vehiculoid
LEFT JOIN trayecto_estudiante te ON te.trayectoid = t.trayectoid
LEFT JOIN coordenadas c  ON c.trayectoid  = t.trayectoid
GROUP BY t.trayectoid, r.nombreruta, u.nombrecompleto, v.placa,
         t.estadotrayecto, t.fechainicio, t.fechafin
ORDER BY t.trayectoid;

-- ─────────────────────────────────────────────────────────────
-- C3. Notificaciones con receptor y tipo
-- ─────────────────────────────────────────────────────────────
SELECT
    n.notificacionid,
    n.tipoevento,
    LEFT(n.mensaje, 55)    AS mensaje,
    u.nombrecompleto       AS receptor,
    nr.receptortipo,
    nr.leida,
    n.estadoenvio
FROM notificacion n
JOIN notificacion_recibe nr ON n.notificacionid = nr.notificacionid
JOIN usuario u              ON nr.receptorid    = u.usuarioid
ORDER BY n.fechahora DESC, n.notificacionid;

-- ─────────────────────────────────────────────────────────────
-- C4. Resumen: total de registros por tabla principal
-- ─────────────────────────────────────────────────────────────
SELECT 'usuario'             AS tabla, COUNT(*) AS total FROM usuario
UNION ALL SELECT 'conductor',            COUNT(*) FROM conductor
UNION ALL SELECT 'vehiculo',             COUNT(*) FROM vehiculo
UNION ALL SELECT 'estudiante',           COUNT(*) FROM estudiante
UNION ALL SELECT 'ruta',                 COUNT(*) FROM ruta
UNION ALL SELECT 'parada',               COUNT(*) FROM parada
UNION ALL SELECT 'trayecto',             COUNT(*) FROM trayecto
UNION ALL SELECT 'trayecto_estudiante',  COUNT(*) FROM trayecto_estudiante
UNION ALL SELECT 'coordenadas',          COUNT(*) FROM coordenadas
UNION ALL SELECT 'notificacion',         COUNT(*) FROM notificacion
UNION ALL SELECT 'notificacion_recibe',  COUNT(*) FROM notificacion_recibe
ORDER BY tabla;

-- ─────────────────────────────────────────────────────────────
-- C5. Vista completa: pasajeros por trayecto con estado individual
-- Muestra lo que ve el conductor en su lista de estudiantes
-- ─────────────────────────────────────────────────────────────
SELECT
    t.trayectoid,
    r.nombreruta,
    e.nombreestudiante,
    te.estado_pasajero,
    p_sub.nombreparada     AS parada_subida,
    te.hora_subida,
    p_baj.nombreparada     AS parada_bajada,
    te.hora_bajada,
    te.observacion
FROM trayecto_estudiante te
JOIN trayecto   t     ON t.trayectoid    = te.trayectoid
JOIN estudiante e     ON e.estudianteid  = te.estudianteid
JOIN ruta       r     ON r.rutaid        = t.rutaid
LEFT JOIN parada p_sub ON p_sub.paradaid = te.parada_subida
LEFT JOIN parada p_baj ON p_baj.paradaid = te.parada_bajada
ORDER BY t.trayectoid, te.estado_pasajero, e.nombreestudiante;

-- ─────────────────────────────────────────────────────────────
-- C6. Detección de buses varados: trayectos activos con velocidad = 0
-- Muestra lo que ve el Administrador en su panel de monitoreo
-- ─────────────────────────────────────────────────────────────
SELECT
    t.trayectoid,
    r.nombreruta,
    v.placa                AS bus,
    u.nombrecompleto       AS conductor,
    c.velocidad            AS vel_km_h,
    c.fechahora            AS ultima_posicion,
    c.latitud,
    c.longitud,
    ROUND(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - c.fechahora)) / 60, 1) AS min_sin_movimiento
FROM trayecto t
JOIN ruta r ON r.rutaid = t.rutaid
LEFT JOIN conductor  cd ON cd.conductorid = t.conductorid
LEFT JOIN usuario    u  ON u.usuarioid    = cd.usuarioid
LEFT JOIN vehiculo   v  ON v.vehiculoid   = t.vehiculoid
JOIN coordenadas c ON c.trayectoid = t.trayectoid
WHERE t.estadotrayecto = 'En Progreso'
  AND c.velocidad = 0
  AND c.fechahora = (
      SELECT MAX(c2.fechahora)
      FROM coordenadas c2
      WHERE c2.trayectoid = t.trayectoid
  )
ORDER BY min_sin_movimiento DESC;
