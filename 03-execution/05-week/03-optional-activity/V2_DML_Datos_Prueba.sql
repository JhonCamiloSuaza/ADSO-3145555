
-- Nicolás Estid Ruiz Sastoque
 -- Jhon Camilo Suaza Sánchez, 
 -- Kevin Andrey Culma Gómez
-- SENA - Análisis y Desarrollo de Software — Ficha 3145555
-- =============================================================================
--   + Tabla conductor: 3 perfiles con licencias colombianas
--   + Tabla vehiculo: 4 buses asignados a rutas
--   ~ Trayectos: ahora incluyen conductorid y vehiculoid
--   + Tabla trayecto_estudiante: pasajeros por trayecto (N:M)
--   ~ confignotificacion: incluye las 5 alertas nuevas
--   + Notificaciones: ejemplos de todos los tipos nuevos
--   ~ politicas_contrasenas: corregido typo en intentosfallidosmax
-- =============================================================================

-- =============================================================================
-- 1. ROLES Y PERMISOS
-- =============================================================================

INSERT INTO roles (rolid, nombrerol, descripcion) VALUES
(nextval('seq_roles'), 'Administrador', 'Acceso total al sistema'),
(nextval('seq_roles'), 'Padre',         'Visualización de rutas y notificaciones de sus hijos'),
(nextval('seq_roles'), 'Conductor',     'Gestión de trayectos y envío de coordenadas GPS');

INSERT INTO permisos (permisoid, nombrepermiso, descripcion) VALUES
(nextval('seq_permisos'), 'VER_RUTAS',           'Ver rutas disponibles'),
(nextval('seq_permisos'), 'GESTIONAR_RUTAS',      'Crear y editar rutas'),
(nextval('seq_permisos'), 'VER_NOTIFICACIONES',   'Recibir y ver notificaciones'),
(nextval('seq_permisos'), 'GESTIONAR_USUARIOS',   'Administrar usuarios del sistema'),
(nextval('seq_permisos'), 'VER_TRAYECTOS',        'Ver trayectos en tiempo real'),
(nextval('seq_permisos'), 'GESTIONAR_TRAYECTOS',  'Iniciar, actualizar y finalizar trayectos'),
(nextval('seq_permisos'), 'ENVIAR_GPS',           'Enviar coordenadas GPS desde dispositivo móvil'),
(nextval('seq_permisos'), 'MARCAR_PASAJEROS',     'Marcar estado de pasajeros durante el trayecto');

INSERT INTO rol_permiso (rolid, permisoid) VALUES
(1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),  -- Admin: todos los permisos
(2, 1),(2, 3),(2, 5),                         -- Padre: ver rutas, notif, trayectos
(3, 1),(3, 3),(3, 5),(3, 6),(3, 7),(3, 8);   -- Conductor: ver rutas, enviar GPS, marcar pasajeros


-- 2. USUARIOS — Administradores, Padres y Conductores

INSERT INTO usuario (usuarioid, nombrecompleto, telefono, email, contrasena, tipousuario) VALUES
-- Administradores (IDs 1, 6)
(nextval('seq_usuario'), 'Carlos Admin Gómez',      '3001234567', 'admin@guardianescolar.com',   '$2b$10$hashadmin001', 'Admin'),
(nextval('seq_usuario'), 'Laura Martínez López',    '3109876543', 'laura.martinez@gmail.com',    '$2b$10$hashpadre01',  'Padre'),
(nextval('seq_usuario'), 'Pedro Suárez Vargas',     '3204567890', 'pedro.suarez@hotmail.com',    '$2b$10$hashpadre02',  'Padre'),
(nextval('seq_usuario'), 'Sandra Gómez Rivera',     '3156781234', 'sandra.gomez@gmail.com',      '$2b$10$hashpadre03',  'Padre'),
(nextval('seq_usuario'), 'Miguel Torres Cano',      '3007654321', 'miguel.torres@yahoo.com',     '$2b$10$hashpadre04',  'Padre'),
(nextval('seq_usuario'), 'Admin Sistema',           '3001111111', 'sistema@guardianescolar.com', '$2b$10$hashadmin002', 'Admin'),
-- Conductores (IDs 7, 8, 9)
(nextval('seq_usuario'), 'Carlos Andrés Medina',    '3001112233', 'conductor1@guardian.com',     '$2b$10$hashcond001',  'Conductor'),
(nextval('seq_usuario'), 'Luis Fernando Ríos',      '3002223344', 'conductor2@guardian.com',     '$2b$10$hashcond002',  'Conductor'),
(nextval('seq_usuario'), 'Mauricio Henao Gómez',    '3003334455', 'conductor3@guardian.com',     '$2b$10$hashcond003',  'Conductor');

-- Asignar roles a usuarios
INSERT INTO usuario_rol (usuarioid, rolid) VALUES
(1, 1), -- Carlos Admin    → Administrador
(2, 2), -- Laura           → Padre
(3, 2), -- Pedro           → Padre
(4, 2), -- Sandra          → Padre
(5, 2), -- Miguel          → Padre
(6, 1), -- Admin Sistema   → Administrador
(7, 3), -- Carlos Medina   → Conductor
(8, 3), -- Luis Ríos       → Conductor
(9, 3); -- Mauricio Henao  → Conductor


-- 3. RUTAS


INSERT INTO ruta (rutaid, nombreruta, descripcion, horariosalida, estadoruta, originlatitud, originlongitud, creado_por) VALUES
(nextval('seq_ruta'), 'Ruta Norte',   'Recorrido sector norte de la ciudad',  '06:30:00', 'Activa',     4.711099, -74.072092, 1),
(nextval('seq_ruta'), 'Ruta Sur',     'Recorrido sector sur de la ciudad',    '06:45:00', 'Activa',     4.598889, -74.075833, 1),
(nextval('seq_ruta'), 'Ruta Centro',  'Recorrido por el centro urbano',       '07:00:00', 'Activa',     4.653400, -74.083500, 1),
(nextval('seq_ruta'), 'Ruta Oriente', 'Recorrido sector oriental',            '07:15:00', 'Suspendida', 4.680200, -74.050100, 1);


-- 4. PARADAS POR RUTA


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


-- 5. PERFILES CONDUCTOR
--  Cada conductor referencia su usuarioid (7, 8, 9)

INSERT INTO conductor (conductorid, usuarioid, numerolicencia, categoriaLicencia, fechavencimiento, documentoidentidad, telefono_emergencia, estado) VALUES
(nextval('seq_conductor'), 7, 'COL-LIC-001234', 'C2', '2027-06-30', '1020304050', '3109990011', TRUE),
(nextval('seq_conductor'), 8, 'COL-LIC-005678', 'C1', '2026-12-31', '1030405060', '3118881122', TRUE),
(nextval('seq_conductor'), 9, 'COL-LIC-009012', 'C2', '2028-03-15', '1040506070', '3127772233', TRUE);


-- 6. VEHÍCULOS
--    Asignados a las rutas activas. La placa sigue formato colombiano.


INSERT INTO vehiculo (vehiculoid, placa, marca, modelo, anio, capacidad, rutaid, estadovehiculo, color, estado) VALUES
(nextval('seq_vehiculo'), 'ABC123', 'Mercedes-Benz', 'Sprinter 516',    2020, 19, 1, 'En Ruta',          'Blanco',  TRUE),
(nextval('seq_vehiculo'), 'DEF456', 'Chevrolet',     'NHR 55L',         2019, 22, 2, 'En Ruta',          'Amarillo',TRUE),
(nextval('seq_vehiculo'), 'GHI789', 'Toyota',        'HiAce Commuter',  2021, 15, 3, 'En Ruta',          'Blanco',  TRUE),
(nextval('seq_vehiculo'), 'JKL012', 'Ford',          'Transit 350',     2018, 15, NULL, 'En Mantenimiento','Gris',  TRUE);


-- 7. ESTUDIANTES

INSERT INTO estudiante (estudianteid, usuarioid, rutaid, nombreestudiante, gradoescolar, contactoemergencia, fechanacimiento, creado_por) VALUES
(nextval('seq_estudiante'), 2, 1, 'Sofía Martínez',   'Grado 5°', '3109876543', '2014-03-15', 1),
(nextval('seq_estudiante'), 2, 1, 'Tomás Martínez',   'Grado 3°', '3109876543', '2016-07-22', 1),
(nextval('seq_estudiante'), 3, 2, 'Valentina Suárez', 'Grado 7°', '3204567890', '2012-11-08', 1),
(nextval('seq_estudiante'), 4, 3, 'Diego Gómez',      'Grado 9°', '3156781234', '2010-05-30', 1),
(nextval('seq_estudiante'), 5, 2, 'Isabella Torres',  'Grado 6°', '3007654321', '2013-09-18', 1),
(nextval('seq_estudiante'), 5, 1, 'Sebastián Torres', 'Grado 4°', '3007654321', '2015-01-25', 1);


-- 8. CONFIGURACIÓN DE NOTIFICACIONES
--    Incluye las 5 alertas

INSERT INTO confignotificacion (
    configid, usuarioid,
    alertaretraso, alertacambioruta, alertallegada,
    alertatrafico, alertabusvarado, alertaproximollegada,
    alertaestudianteabordo, alertaestudianteausente,
    creado_por
) VALUES
(nextval('seq_confignotif'), 2, TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  1), -- Laura: todas activas
(nextval('seq_confignotif'), 3, TRUE,  FALSE, TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  1), -- Pedro: sin cambio ruta
(nextval('seq_confignotif'), 4, TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  1), -- Sandra: todas activas
(nextval('seq_confignotif'), 5, FALSE, TRUE,  TRUE,  TRUE,  FALSE, TRUE,  TRUE,  TRUE,  1); -- Miguel: sin retraso ni varado


-- 9. TRAYECTOS
--    Ahora incluyen conductorid y vehiculoid
--    estudianteid queda NULL — los pasajeros van en trayecto_estudiante

INSERT INTO trayecto (trayectoid, rutaid, conductorid, vehiculoid, estudianteid, fechainicio, fechafin, estadotrayecto, duracionestimada, creado_por) VALUES
-- Trayecto 1: Ruta Norte — Carlos Medina (conductor 1) — Bus ABC123 — FINALIZADO
(nextval('seq_trayecto'), 1, 1, 1, NULL, '2025-06-02 06:30:00', '2025-06-02 06:58:00', 'Finalizado',  28, 1),
-- Trayecto 2: Ruta Sur — Luis Ríos (conductor 2) — Bus DEF456 — FINALIZADO
(nextval('seq_trayecto'), 2, 2, 2, NULL, '2025-06-02 06:45:00', '2025-06-02 07:12:00', 'Finalizado',  27, 1),
-- Trayecto 3: Ruta Centro — Mauricio Henao (conductor 3) — Bus GHI789 — EN PROGRESO
(nextval('seq_trayecto'), 3, 3, 3, NULL, '2025-06-02 07:00:00', NULL,                  'En Progreso', 25, 1),
-- Trayecto 4: Ruta Norte — Carlos Medina — Bus ABC123 — día anterior, FINALIZADO
(nextval('seq_trayecto'), 1, 1, 1, NULL, '2025-06-01 06:30:00', '2025-06-01 07:00:00', 'Finalizado',  30, 1),
-- Trayecto 5: Ruta Sur — Luis Ríos — Bus DEF456 — EN PROGRESO
(nextval('seq_trayecto'), 2, 2, 2, NULL, '2025-06-02 06:45:00', NULL,                  'En Progreso', 27, 1);


-- 10. TRAYECTO_ESTUDIANTE — Pasajeros por trayecto
--     El conductor marca el estado de cada estudiante en tiempo real
--     parada_subida y parada_bajada referencian paradaid de la tabla parada

-- Trayecto 1 — Ruta Norte (FINALIZADO)
-- Sofía (est 1): subió en parada 1, bajó en parada 3 (colegio) ✓ Entregada
-- Tomás (est 2): subió en parada 2, bajó en parada 3 (colegio) ✓ Entregado
-- Sebastián (est 6): subió en parada 1, bajó en parada 3 (colegio) ✓ Entregado
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero, parada_subida, parada_bajada, hora_subida, hora_bajada) VALUES
(1, 1, 'Entregado', 1, 3, '2025-06-02 06:35:00', '2025-06-02 06:58:00'),
(1, 2, 'Entregado', 2, 3, '2025-06-02 06:42:00', '2025-06-02 06:58:00'),
(1, 6, 'Entregado', 1, 3, '2025-06-02 06:35:00', '2025-06-02 06:58:00');

-- Trayecto 2 — Ruta Sur (FINALIZADO)
-- Valentina (est 3): ✓ Entregada
-- Isabella (est 5): ✓ Entregada
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero, parada_subida, parada_bajada, hora_subida, hora_bajada) VALUES
(2, 3, 'Entregado', 4, 6, '2025-06-02 06:50:00', '2025-06-02 07:12:00'),
(2, 5, 'Entregado', 5, 6, '2025-06-02 06:58:00', '2025-06-02 07:12:00');

-- Trayecto 3 — Ruta Centro (EN PROGRESO)
-- Diego (est 4): ya subió — A Bordo
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero, parada_subida, hora_subida) VALUES
(3, 4, 'A Bordo', 7, '2025-06-02 07:05:00');

-- Trayecto 4 — Ruta Norte día anterior (FINALIZADO)
-- Sofía (est 1): ✓ Entregada
-- Tomás (est 2): ✗ Ausente — no se presentó en la parada
-- Sebastián (est 6): ✓ Entregado
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero, parada_subida, parada_bajada, hora_subida, hora_bajada, observacion) VALUES
(4, 1, 'Entregado', 1, 3, '2025-06-01 06:35:00', '2025-06-01 07:00:00', NULL),
(4, 2, 'Ausente',   NULL, NULL, NULL, NULL, 'No se presentó en Parada Calle 140. Padre notificado.'),
(4, 6, 'Entregado', 1, 3, '2025-06-01 06:35:00', '2025-06-01 07:00:00', NULL);

-- Trayecto 5 — Ruta Sur EN PROGRESO
-- Valentina (est 3): A Bordo
-- Isabella (est 5): Pendiente — el bus va en camino a su parada
INSERT INTO trayecto_estudiante (trayectoid, estudianteid, estado_pasajero, parada_subida, hora_subida) VALUES
(5, 3, 'A Bordo',  4, '2025-06-02 06:50:00'),
(5, 5, 'Pendiente', NULL, NULL);


-- 11. COORDENADAS GPS
--     velocidad: solo la consume el Admin para monitoreo

-- Trayecto 1 — Ruta Norte (completo, finalizado)
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 1, 4.711099, -74.072092, '2025-06-02 06:30:00', 0.00),
(nextval('seq_coordenadas'), 1, 4.715200, -74.070500, '2025-06-02 06:35:00', 35.50),
(nextval('seq_coordenadas'), 1, 4.722100, -74.067800, '2025-06-02 06:42:00', 40.20),
(nextval('seq_coordenadas'), 1, 4.733800, -74.063200, '2025-06-02 06:50:00', 38.70),
(nextval('seq_coordenadas'), 1, 4.740500, -74.060100, '2025-06-02 06:58:00', 0.00);

-- Trayecto 2 — Ruta Sur (completo, finalizado)
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 2, 4.598889, -74.075833, '2025-06-02 06:45:00', 0.00),
(nextval('seq_coordenadas'), 2, 4.592100, -74.078200, '2025-06-02 06:52:00', 33.10),
(nextval('seq_coordenadas'), 2, 4.581500, -74.083600, '2025-06-02 07:02:00', 37.80),
(nextval('seq_coordenadas'), 2, 4.570100, -74.088900, '2025-06-02 07:12:00', 0.00);

-- Trayecto 3 — Ruta Centro (en progreso — últimas 2 coordenadas)
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 3, 4.653400, -74.083500, '2025-06-02 07:00:00', 0.00),
(nextval('seq_coordenadas'), 3, 4.657800, -74.081200, '2025-06-02 07:08:00', 28.50);

-- Trayecto 5 — Ruta Sur en progreso (bus varado — demo detección Admin)
-- Velocidad = 0 por varias filas seguidas → Admin detecta bus varado
INSERT INTO coordenadas (coordenadaid, trayectoid, latitud, longitud, fechahora, velocidad) VALUES
(nextval('seq_coordenadas'), 5, 4.598889, -74.075833, '2025-06-02 06:45:00', 0.00),
(nextval('seq_coordenadas'), 5, 4.601200, -74.074100, '2025-06-02 06:48:00', 25.00),
(nextval('seq_coordenadas'), 5, 4.601250, -74.074090, '2025-06-02 06:53:00', 0.00),  -- se detuvo
(nextval('seq_coordenadas'), 5, 4.601250, -74.074090, '2025-06-02 06:56:00', 0.00),  -- sigue detenido
(nextval('seq_coordenadas'), 5, 4.601250, -74.074090, '2025-06-02 06:59:00', 0.00);  -- >5 min → alerta BusVarado


-- 12. NOTIFICACIONES — Todos los tipos representados


INSERT INTO notificacion (notificacionid, trayectoid, reportadopor, tipoevento, mensaje, esdesvioruta, estadoenvio, creado_por) VALUES
-- Notificaciones de pasajero (trayecto 1 finalizado)
(nextval('seq_notificacion'), 1, 7, 'EstudianteABordo',   'Sofía Martínez subió al bus en Parada Calle 127',         FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 1, 7, 'EstudianteABordo',   'Tomás Martínez subió al bus en Parada Calle 140',         FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 1, 7, 'Llegada',            'Bus Ruta Norte llegó al Colegio San Andrés',              FALSE, 'Enviado',  1),
-- Trayecto 4 — día anterior: Tomás estuvo ausente
(nextval('seq_notificacion'), 4, 7, 'EstudianteAusente',  'Tomás Martínez no se presentó en Parada Calle 140',       FALSE, 'Enviado',  1),
-- Trayecto 2 — ruta sur finalizado
(nextval('seq_notificacion'), 2, 8, 'EstudianteABordo',   'Valentina Suárez subió al bus en Parada Calle 40 Sur',    FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 2, 8, 'Llegada',            'Bus Ruta Sur llegó al Colegio San Marcos',                FALSE, 'Enviado',  1),
-- Trayecto 3 — en progreso: desvío y trancón
(nextval('seq_notificacion'), 3, 9, 'ViaObstruida',       'Vía obstruida en Carrera 7 por obras. Desviando ruta.',   TRUE,  'Enviado',  1),
(nextval('seq_notificacion'), 3, 9, 'Trafico',            'Trancón en Av. Jiménez. Posible retraso de 10 min.',      FALSE, 'Enviado',  1),
(nextval('seq_notificacion'), 3, 9, 'Retraso',            'El bus de Ruta Centro llega 10 min tarde al colegio',     FALSE, 'Enviado',  1),
-- Trayecto 5 — bus varado detectado por sistema
(nextval('seq_notificacion'), 5, 1, 'BusVarado',          'Bus DEF456 Ruta Sur lleva más de 5 min sin movimiento',   FALSE, 'Enviado',  1),
-- Alerta de proximidad — sistema detectó bus cerca
(nextval('seq_notificacion'), 3, 1, 'ProximoLlegar',      'El bus de Diego Gómez está a menos de 300m de su parada', FALSE, 'Enviado',  1);

-- Receptores de notificaciones
INSERT INTO notificacion_recibe (notificacionid, receptorid, receptortipo) VALUES
(1,  2, 'Padre'),   -- Laura recibe: Sofía subió al bus
(2,  2, 'Padre'),   -- Laura recibe: Tomás subió al bus
(3,  2, 'Padre'),   -- Laura recibe: bus llegó al colegio (Sofía)
(3,  5, 'Padre'),   -- Miguel recibe: bus llegó al colegio (Sebastián)
(4,  2, 'Padre'),   -- Laura recibe: Tomás ausente
(4,  1, 'Admin'),   -- Admin también recibe ausencias
(5,  3, 'Padre'),   -- Pedro recibe: Valentina subió
(6,  3, 'Padre'),   -- Pedro recibe: bus llegó (Valentina)
(6,  5, 'Padre'),   -- Miguel recibe: bus llegó (Isabella)
(7,  4, 'Padre'),   -- Sandra recibe: vía obstruida (Diego)
(7,  1, 'Admin'),   -- Admin recibe: vía obstruida
(8,  4, 'Padre'),   -- Sandra recibe: trancón
(8,  1, 'Admin'),   -- Admin recibe: trancón
(9,  4, 'Padre'),   -- Sandra recibe: retraso Diego
(10, 3, 'Padre'),   -- Pedro recibe: bus varado (Valentina en ese bus)
(10, 5, 'Padre'),   -- Miguel recibe: bus varado (Isabella en ese bus)
(10, 1, 'Admin'),   -- Admin recibe: bus varado SIEMPRE
(10, 8, 'Conductor'),-- Conductor Luis Ríos también recibe alerta de su bus
(11, 4, 'Padre');   -- Sandra recibe: próximo llegar Diego


-- 13. SEGURIDAD Y AUDITORÍA

INSERT INTO configuracion_seguridad (configuracionid, nombreconfiguracion, valorconfiguracion, descripcion) VALUES
(nextval('seq_config_seguridad'), 'TIEMPO_SESION',           '3600',  'Duración máxima de sesión en segundos'),
(nextval('seq_config_seguridad'), 'MAX_INTENTOS',            '5',     'Intentos fallidos antes de bloqueo de cuenta'),
(nextval('seq_config_seguridad'), 'TOKEN_EXPIRACION',        '86400', 'Tiempo de expiración de tokens JWT en segundos'),
(nextval('seq_config_seguridad'), 'URL_BASE',                'https://guardianescolar.com', 'URL base del sistema'),
(nextval('seq_config_seguridad'), 'GPS_INTERVALO_SEGUNDOS',  '30',    'Intervalo de envío de coordenadas GPS en segundos'),
(nextval('seq_config_seguridad'), 'BUS_VARADO_MINUTOS',      '5',     'Minutos sin movimiento para disparar alerta BusVarado'),
(nextval('seq_config_seguridad'), 'PROXIMO_LLEGAR_METROS',   '300',   'Distancia en metros para disparar alerta ProximoLlegar');

-- CORRECCIÓN v2.0: el DML anterior tenía un carácter cirílico en "intentosfallidosmax"
-- La columna correcta en la tabla es: intentosfallidosmax (todo ASCII)
INSERT INTO politicas_contrasenas (politicaid, minlongitud, maxlongitud, requieremayusculas, requiereminusculas, requirenumeros, requieresimbolos, caducidaddias, intentosfallidosmax) VALUES
(nextval('seq_politicas'), 8, 20, TRUE, TRUE, TRUE, TRUE, 90, 5);

INSERT INTO sesion_usuario (sesionid, usuarioid, fechainicio, fechafin, ip_origen, estadosesion) VALUES
(nextval('seq_sesion_usuario'), 1, '2025-06-02 06:00:00', '2025-06-02 08:00:00', '192.168.1.10', 'Cerrada'),
(nextval('seq_sesion_usuario'), 2, '2025-06-02 06:25:00', NULL,                  '192.168.1.20', 'Activa'),
(nextval('seq_sesion_usuario'), 3, '2025-06-02 06:40:00', NULL,                  '192.168.1.21', 'Activa'),
(nextval('seq_sesion_usuario'), 7, '2025-06-02 06:15:00', NULL,                  '192.168.1.30', 'Activa'),  -- Conductor 1
(nextval('seq_sesion_usuario'), 8, '2025-06-02 06:30:00', NULL,                  '192.168.1.31', 'Activa'),  -- Conductor 2
(nextval('seq_sesion_usuario'), 9, '2025-06-02 06:45:00', NULL,                  '192.168.1.32', 'Activa');  -- Conductor 3

INSERT INTO registro (registroid, usuarioid, tipoaccion, descripcion, ip_origen, dispositivo, estadoaccion) VALUES
(nextval('seq_registro'), 1, 'LOGIN',             'Inicio de sesión administrador',             '192.168.1.10', 'PC-Admin',    'Exitoso'),
(nextval('seq_registro'), 2, 'LOGIN',             'Inicio de sesión padre Laura',               '192.168.1.20', 'Mobile-iOS',  'Exitoso'),
(nextval('seq_registro'), 3, 'LOGIN',             'Inicio de sesión padre Pedro',               '192.168.1.21', 'Mobile-And',  'Exitoso'),
(nextval('seq_registro'), 7, 'LOGIN',             'Inicio de sesión conductor Carlos Medina',   '192.168.1.30', 'Mobile-And',  'Exitoso'),
(nextval('seq_registro'), 8, 'LOGIN',             'Inicio de sesión conductor Luis Ríos',       '192.168.1.31', 'Mobile-And',  'Exitoso'),
(nextval('seq_registro'), 1, 'CREAR_RUTA',        'Creación de Ruta Norte',                     '192.168.1.10', 'PC-Admin',    'Exitoso'),
(nextval('seq_registro'), 1, 'CREAR_ESTUDIANTE',  'Registro de Sofía Martínez',                 '192.168.1.10', 'PC-Admin',    'Exitoso'),
(nextval('seq_registro'), 7, 'INICIAR_TRAYECTO',  'Conductor inició trayecto Ruta Norte',       '192.168.1.30', 'Mobile-And',  'Exitoso'),
(nextval('seq_registro'), 7, 'MARCAR_PASAJERO',   'Sofía Martínez marcada A Bordo',             '192.168.1.30', 'Mobile-And',  'Exitoso'),
(nextval('seq_registro'), 6, 'LOGIN',             'Intento fallido de acceso no autorizado',    '10.0.0.99',    'Desconocido', 'Fallido');

INSERT INTO auditoria (auditoriaid, usuarioid, accion, descripcion, ip_origen, aplicacion) VALUES
(nextval('seq_auditoria'), 1, 'INSERT', 'Se insertaron 4 rutas nuevas',                 '192.168.1.10', 'GPS Guardian v3'),
(nextval('seq_auditoria'), 1, 'INSERT', 'Se registraron 6 estudiantes',                 '192.168.1.10', 'GPS Guardian v3'),
(nextval('seq_auditoria'), 1, 'UPDATE', 'Ruta Oriente cambió estado a Suspendida',      '192.168.1.10', 'GPS Guardian v3'),
(nextval('seq_auditoria'), 1, 'INSERT', 'Se registraron 3 conductores con licencias',   '192.168.1.10', 'GPS Guardian v3'),
(nextval('seq_auditoria'), 1, 'INSERT', 'Se registraron 4 vehículos en el sistema',     '192.168.1.10', 'GPS Guardian v3');

INSERT INTO log_errores (errorid, usuarioid, tipoerror, descripcion, ip_origen) VALUES
(nextval('seq_log_errores'), 6,    'AUTH_ERROR', 'Credenciales incorrectas — 3 intentos fallidos', '10.0.0.99'),
(nextval('seq_log_errores'), NULL, 'GPS_ERROR',  'Señal GPS perdida en trayecto 3 por 45 seg',     '192.168.1.32');


SELECT 'usuario'              AS tabla, COUNT(*) AS registros FROM usuario
UNION ALL SELECT 'conductor',            COUNT(*) FROM conductor
UNION ALL SELECT 'vehiculo',             COUNT(*) FROM vehiculo
UNION ALL SELECT 'ruta',                 COUNT(*) FROM ruta
UNION ALL SELECT 'parada',               COUNT(*) FROM parada
UNION ALL SELECT 'estudiante',           COUNT(*) FROM estudiante
UNION ALL SELECT 'trayecto',             COUNT(*) FROM trayecto
UNION ALL SELECT 'trayecto_estudiante',  COUNT(*) FROM trayecto_estudiante
UNION ALL SELECT 'coordenadas',          COUNT(*) FROM coordenadas
UNION ALL SELECT 'notificacion',         COUNT(*) FROM notificacion
UNION ALL SELECT 'notificacion_recibe',  COUNT(*) FROM notificacion_recibe
UNION ALL SELECT 'confignotificacion',   COUNT(*) FROM confignotificacion
UNION ALL SELECT 'roles',                COUNT(*) FROM roles
UNION ALL SELECT 'permisos',             COUNT(*) FROM permisos
ORDER BY tabla;
