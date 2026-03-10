-- =============================================================================
-- SCRIPT DML - DATOS DE PRUEBA
-- GPS Guardian Escolar v3 - PostgreSQL
-- Nicolás Estid Ruiz Sastoque, Jhon Camilo Suaza Sánchez, Kevin Andrey Culma Gómez
-- SENA - Análisis y Desarrollo de Software
-- =============================================================================

-- =============================================================================
-- 1. ROLES Y PERMISOS
-- =============================================================================

INSERT INTO roles (rolid, nombrerol, descripcion) VALUES
(nextval('seq_roles'), 'Administrador', 'Acceso total al sistema'),
(nextval('seq_roles'), 'Padre',         'Visualización de rutas y notificaciones'),
(nextval('seq_roles'), 'Monitor',       'Gestión de rutas y trayectos');

INSERT INTO permisos (permisoid, nombrepermiso, descripcion) VALUES
(nextval('seq_permisos'), 'VER_RUTAS',          'Ver rutas disponibles'),
(nextval('seq_permisos'), 'GESTIONAR_RUTAS',     'Crear y editar rutas'),
(nextval('seq_permisos'), 'VER_NOTIFICACIONES',  'Recibir y ver notificaciones'),
(nextval('seq_permisos'), 'GESTIONAR_USUARIOS',  'Administrar usuarios del sistema'),
(nextval('seq_permisos'), 'VER_TRAYECTOS',       'Ver trayectos en tiempo real');

INSERT INTO rol_permiso (rolid, permisoid) VALUES
(1, 1),(1, 2),(1, 3),(1, 4),(1, 5),  -- Admin: todos los permisos
(2, 1),(2, 3),(2, 5),                 -- Padre: ver rutas, notif, trayectos
(3, 1),(3, 2),(3, 5);                 -- Monitor: ver/gestionar rutas y trayectos

-- =============================================================================
-- 2. USUARIOS (Administradores y Padres)
-- =============================================================================

INSERT INTO usuario (usuarioid, nombrecompleto, telefono, email, contrasena, tipousuario) VALUES
(nextval('seq_usuario'), 'Carlos Admin Gómez',    '3001234567', 'admin@guardianescolar.com',  '$2b$10$hashadmin001', 'Admin'),
(nextval('seq_usuario'), 'Laura Martínez López',  '3109876543', 'laura.martinez@gmail.com',   '$2b$10$hashpadre01', 'Padre'),
(nextval('seq_usuario'), 'Pedro Suárez Vargas',   '3204567890', 'pedro.suarez@hotmail.com',   '$2b$10$hashpadre02', 'Padre'),
(nextval('seq_usuario'), 'Sandra Gómez Rivera',   '3156781234', 'sandra.gomez@gmail.com',     '$2b$10$hashpadre03', 'Padre'),
(nextval('seq_usuario'), 'Miguel Torres Cano',    '3007654321', 'miguel.torres@yahoo.com',    '$2b$10$hashpadre04', 'Padre'),
(nextval('seq_usuario'), 'Admin Sistema',         '3001111111', 'sistema@guardianescolar.com','$2b$10$hashadmin002', 'Admin');

-- Asignar roles a usuarios
INSERT INTO usuario_rol (usuarioid, rolid) VALUES
(1, 1), -- Carlos → Administrador
(2, 2), -- Laura  → Padre
(3, 2), -- Pedro  → Padre
(4, 2), -- Sandra → Padre
(5, 2), -- Miguel → Padre
(6, 1); -- Admin Sistema → Administrador

-- =============================================================================
-- 3. RUTAS
-- =============================================================================

INSERT INTO ruta (rutaid, nombreruta, descripcion, horariosalida, estadoruta, originlatitud, originlongitud, creado_por) VALUES
(nextval('seq_ruta'), 'Ruta Norte',   'Recorrido sector norte de la ciudad',  '06:30:00', 'Activa',    4.711099, -74.072092, 1),
(nextval('seq_ruta'), 'Ruta Sur',     'Recorrido sector sur de la ciudad',    '06:45:00', 'Activa',    4.598889, -74.075833, 1),
(nextval('seq_ruta'), 'Ruta Centro',  'Recorrido por el centro urbano',       '07:00:00', 'Activa',    4.653400, -74.083500, 1),
(nextval('seq_ruta'), 'Ruta Oriente', 'Recorrido sector oriental',            '07:15:00', 'Suspendida',4.680200, -74.050100, 1);

-- =============================================================================
-- 4. PARADAS POR RUTA
-- =============================================================================

-- Ruta Norte (rutaid=1)
INSERT INTO parada (paradaid, rutaid, nombreparada, latitud, longitud, horarioestimado, creado_por) VALUES
(nextval('seq_parada'), 1, 'Parada Calle 127',   4.711099, -74.072092, '06:35:00', 1),
(nextval('seq_parada'), 1, 'Parada Calle 140',   4.725300, -74.068400, '06:42:00', 1),
(nextval('seq_parada'), 1, 'Colegio San Andrés', 4.740500, -74.060100, '06:55:00', 1);

-- Ruta Sur (rutaid=2)
INSERT INTO parada (paradaid, rutaid, nombreparada, latitud, longitud, horarioestimado, creado_por) VALUES
(nextval('seq_parada'), 2, 'Parada Calle 40 Sur', 4.598889, -74.075833, '06:50:00', 1),
(nextval('seq_parada'), 2, 'Parada Calle 53 Sur', 4.585200, -74.081200, '06:58:00', 1),
(nextval('seq_parada'), 2, 'Colegio San Marcos',  4.570100, -74.088900, '07:10:00', 1);

-- Ruta Centro (rutaid=3)
INSERT INTO parada (paradaid, rutaid, nombreparada, latitud, longitud, horarioestimado, creado_por) VALUES
(nextval('seq_parada'), 3, 'Parada Av. Jiménez',  4.653400, -74.083500, '07:05:00', 1),
(nextval('seq_parada'), 3, 'Parada Carrera 7',    4.660200, -74.079800, '07:12:00', 1),
(nextval('seq_parada'), 3, 'Colegio Central',     4.668900, -74.074300, '07:25:00', 1);

-- =============================================================================
-- 5. ESTUDIANTES
-- =============================================================================

INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar, contactoemergencia, fechanacimiento, creado_por) VALUES
(nextval('seq_estudiante'), 2, 1, 'Sofía Martínez',  'Grado 5°',  '3109876543', '2014-03-15', 1),
(nextval('seq_estudiante'), 2, 1, 'Tomás Martínez',  'Grado 3°',  '3109876543', '2016-07-22', 1),
(nextval('seq_estudiante'), 3, 2, 'Valentina Suárez','Grado 7°',  '3204567890', '2012-11-08', 1),
(nextval('seq_estudiante'), 4, 3, 'Diego Gómez',     'Grado 9°',  '3156781234', '2010-05-30', 1),
(nextval('seq_estudiante'), 5, 2, 'Isabella Torres', 'Grado 6°',  '3007654321', '2013-09-18', 1),
(nextval('seq_estudiante'), 5, 1, 'Sebastián Torres','Grado 4°',  '3007654321', '2015-01-25', 1);

-- =============================================================================
-- 6. CONFIGURACIÓN DE NOTIFICACIONES
-- =============================================================================

INSERT INTO confignotificacion (configid, usuarioid, alertaretraso, alertacambioruta, alertallegada, creado_por) VALUES
(nextval('seq_confignotif'), 2, TRUE,  TRUE,  TRUE,  1),
(nextval('seq_confignotif'), 3, TRUE,  FALSE, TRUE,  1),
(nextval('seq_confignotif'), 4, TRUE,  TRUE,  TRUE,  1),
(nextval('seq_confignotif'), 5, FALSE, TRUE,  TRUE,  1);

-- =============================================================================
-- 7. TRAYECTOS
-- =============================================================================

INSERT INTO trayecto (trayectoid, rutaid, estudianteid, fechainicio, fechafin, estadotrayecto, duracionestimada, creado_por) VALUES
(nextval('seq_trayecto'), 1, 1, '2025-06-02 06:30:00', '2025-06-02 06:58:00', 'Finalizado',   28, 1),
(nextval('seq_trayecto'), 2, 3, '2025-06-02 06:45:00', '2025-06-02 07:12:00', 'Finalizado',   27, 1),
(nextval('seq_trayecto'), 3, 4, '2025-06-02 07:00:00', NULL,                  'En Progreso',  25, 1),
(nextval('seq_trayecto'), 1, 2, '2025-06-02 06:30:00', '2025-06-02 07:00:00', 'Finalizado',   30, 1),
(nextval('seq_trayecto'), 2, 5, '2025-06-02 06:45:00', NULL,                  'En Progreso',  27, 1);

-- =============================================================================
-- 8. COORDENADAS GPS
-- =============================================================================

-- Trayecto 1 - Ruta Norte (Sofía Martínez)
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 1, 4.711099, -74.072092, '2025-06-02 06:30:00', 0.00),
(nextval('seq_coordenadas'), 1, 4.715200, -74.070500, '2025-06-02 06:35:00', 35.50),
(nextval('seq_coordenadas'), 1, 4.722100, -74.067800, '2025-06-02 06:42:00', 40.20),
(nextval('seq_coordenadas'), 1, 4.733800, -74.063200, '2025-06-02 06:50:00', 38.70),
(nextval('seq_coordenadas'), 1, 4.740500, -74.060100, '2025-06-02 06:58:00', 0.00);

-- Trayecto 2 - Ruta Sur (Valentina Suárez)
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 2, 4.598889, -74.075833, '2025-06-02 06:45:00', 0.00),
(nextval('seq_coordenadas'), 2, 4.592100, -74.078200, '2025-06-02 06:52:00', 33.10),
(nextval('seq_coordenadas'), 2, 4.581500, -74.083600, '2025-06-02 07:02:00', 37.80),
(nextval('seq_coordenadas'), 2, 4.570100, -74.088900, '2025-06-02 07:12:00', 0.00);

-- Trayecto 3 - Ruta Centro (Diego Gómez - en progreso)
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 3, 4.653400, -74.083500, '2025-06-02 07:00:00', 0.00),
(nextval('seq_coordenadas'), 3, 4.657800, -74.081200, '2025-06-02 07:08:00', 28.50);

-- =============================================================================
-- 9. NOTIFICACIONES
-- =============================================================================

INSERT INTO notificacion (notificacionid, trayectoid, reportadopor, tipoevento, mensaje, esdesvioruta, estadoenvio, creado_por) VALUES
(nextval('seq_notificacion'), 1, 1, 'Llegada',    'Sofía Martínez llegó al colegio a las 06:58',           FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 2, 1, 'Llegada',    'Valentina Suárez llegó al colegio a las 07:12',         FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 3, 1, 'Retraso',    'El trayecto de Diego Gómez presenta demora de 5 min',   FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 3, 1, 'CambioRuta', 'Desvío detectado en Carrera 7 por obras',               TRUE,  'Enviado',  1),
(nextval('seq_notificacion'), 5, 1, 'Retraso',    'Trayecto de Isabella Torres con retraso por tráfico',   FALSE, 'Pendiente',1);

-- Receptores de notificaciones
INSERT INTO notificacion_recibe (notificacionid, receptorid, receptortipo) VALUES
(1, 2, 'Padre'),  -- Laura recibe llegada de Sofía
(2, 3, 'Padre'),  -- Pedro recibe llegada de Valentina
(3, 4, 'Padre'),  -- Sandra recibe retraso de Diego
(3, 1, 'Admin'),  -- Admin también recibe el retraso
(4, 4, 'Padre'),  -- Sandra recibe cambio de ruta
(4, 1, 'Admin'),  -- Admin recibe cambio de ruta
(5, 5, 'Padre');  -- Miguel recibe retraso de Isabella

-- =============================================================================
-- 10. SEGURIDAD Y AUDITORÍA
-- =============================================================================

INSERT INTO configuracion_seguridad (configuracionid, nombreconfiguracion, valorconfiguracion, descripcion) VALUES
(nextval('seq_config_seguridad'), 'TIEMPO_SESION',     '3600',  'Duración máxima de sesión en segundos'),
(nextval('seq_config_seguridad'), 'MAX_INTENTOS',      '5',     'Intentos fallidos antes de bloqueo'),
(nextval('seq_config_seguridad'), 'TOKEN_EXPIRACION',  '86400', 'Tiempo de expiración de tokens JWT'),
(nextval('seq_config_seguridad'), 'URL_BASE',          'https://guardianescolar.com', 'URL base del sistema');

INSERT INTO politicas_contrasenas (politicaid, minlongitud, maxlongitud, requieremayusculas, requiereminusculas, requirenumeros, requieresimbolos, caducidaddias, intentosfалlidosmax) VALUES
(nextval('seq_politicas'), 8, 20, TRUE, TRUE, TRUE, TRUE, 90, 5);

INSERT INTO sesion_usuario (sesionid, usuarioid, fechainicio, fechafin, ip_origen, estadosesion) VALUES
(nextval('seq_sesion_usuario'), 1, '2025-06-02 06:00:00', '2025-06-02 08:00:00', '192.168.1.10', 'Cerrada'),
(nextval('seq_sesion_usuario'), 2, '2025-06-02 06:25:00', NULL,                  '192.168.1.20', 'Activa'),
(nextval('seq_sesion_usuario'), 3, '2025-06-02 06:40:00', NULL,                  '192.168.1.21', 'Activa');

INSERT INTO registro (registroid, usuarioid, tipoaccion, descripcion, ip_origen, dispositivo, estadoaccion) VALUES
(nextval('seq_registro'), 1, 'LOGIN',           'Inicio de sesión administrador',     '192.168.1.10', 'PC-Admin',   'Exitoso'),
(nextval('seq_registro'), 2, 'LOGIN',           'Inicio de sesión padre Laura',       '192.168.1.20', 'Mobile-iOS', 'Exitoso'),
(nextval('seq_registro'), 3, 'LOGIN',           'Inicio de sesión padre Pedro',       '192.168.1.21', 'Mobile-And', 'Exitoso'),
(nextval('seq_registro'), 1, 'CREAR_RUTA',      'Creación de Ruta Norte',             '192.168.1.10', 'PC-Admin',   'Exitoso'),
(nextval('seq_registro'), 1, 'CREAR_ESTUDIANTE','Registro de Sofía Martínez',         '192.168.1.10', 'PC-Admin',   'Exitoso'),
(nextval('seq_registro'), 6, 'LOGIN',           'Intento fallido de acceso',          '10.0.0.99',    'Desconocido','Fallido');

INSERT INTO auditoria (auditoriaid, usuarioid, accion, descripcion, ip_origen, aplicacion) VALUES
(nextval('seq_auditoria'), 1, 'INSERT', 'Se insertaron 4 rutas nuevas',        '192.168.1.10', 'GPS Guardian v3'),
(nextval('seq_auditoria'), 1, 'INSERT', 'Se registraron 6 estudiantes',        '192.168.1.10', 'GPS Guardian v3'),
(nextval('seq_auditoria'), 1, 'UPDATE', 'Ruta Oriente cambió a Suspendida',    '192.168.1.10', 'GPS Guardian v3');

INSERT INTO log_errores (errorid, usuarioid, tipoerror, descripcion, ip_origen) VALUES
(nextval('seq_log_errores'), 6,    'AUTH_ERROR',  'Credenciales incorrectas - 3 intentos', '10.0.0.99'),
(nextval('seq_log_errores'), NULL, 'GPS_ERROR',   'Señal GPS perdida en trayecto 3',        '192.168.1.10');

-- =============================================================================
-- FIN SCRIPT DML
-- =============================================================================
