-- =============================================
-- DML - GPS GUARDIAN ESCOLAR
-- Datos de ejemplo para pruebas
-- =============================================

-- 1. ROLES
INSERT INTO Rol (NombreRol, Descripcion) VALUES
('ADMIN', 'Administrador del sistema - control total'),
('PADRE', 'Padre de familia - acceso a ubicación de hijos');

-- 2. PERMISOS
INSERT INTO Permiso (NombrePermiso, Descripcion) VALUES
('USUARIO_CREAR', 'Crear nuevos usuarios'),
('USUARIO_LEER', 'Leer información de usuarios'),
('USUARIO_ACTUALIZAR', 'Actualizar usuarios'),
('USUARIO_ELIMINAR', 'Eliminar usuarios'),
('ESTUDIANTE_CREAR', 'Registrar nuevos estudiantes'),
('ESTUDIANTE_LEER', 'Ver información de estudiantes'),
('ESTUDIANTE_ACTUALIZAR', 'Actualizar estudiantes'),
('ESTUDIANTE_ELIMINAR', 'Eliminar estudiantes'),
('RUTA_CREAR', 'Crear rutas escolares'),
('RUTA_LEER', 'Ver rutas'),
('RUTA_ACTUALIZAR', 'Actualizar rutas'),
('RUTA_ELIMINAR', 'Eliminar rutas'),
('VER_UBICACION', 'Ver ubicación en tiempo real'),
('ZONA_CREAR', 'Crear zonas seguras'),
('ZONA_LEER', 'Ver zonas seguras'),
('ZONA_ACTUALIZAR', 'Actualizar zonas seguras'),
('ZONA_ELIMINAR', 'Eliminar zonas seguras'),
('ENVIAR_NOTIFICACION', 'Enviar notificaciones'),
('VER_REPORTES', 'Ver reportes y estadísticas'),
('VER_AUDITORIA', 'Ver logs de auditoría');

-- Asignar Permisos a Rol ADMIN
INSERT INTO Rol_Permiso (RolID, PermisoID)
SELECT r.ID, p.ID FROM Rol r, Permiso p WHERE r.NombreRol = 'ADMIN';

-- Asignar Permisos a Rol PADRE
INSERT INTO Rol_Permiso (RolID, PermisoID)
SELECT r.ID, p.ID FROM Rol r, Permiso p 
WHERE r.NombreRol = 'PADRE' 
AND p.NombrePermiso IN (
    'ESTUDIANTE_CREAR', 'ESTUDIANTE_LEER', 'ESTUDIANTE_ACTUALIZAR',
    'RUTA_CREAR', 'RUTA_LEER', 'RUTA_ACTUALIZAR',
    'VER_UBICACION',
    'ZONA_CREAR', 'ZONA_LEER', 'ZONA_ACTUALIZAR', 'ZONA_ELIMINAR',
    'ENVIAR_NOTIFICACION', 'VER_REPORTES'
);

-- 3. CONFIGURACIONES
INSERT INTO PoliticaContrasena (LongitudMinima, LongitudMaxima, RequiereMayusculas, RequiereNumeros, RequiereSimbolos, DiasExpiracion)
VALUES (10, 128, true, true, true, 90);

INSERT INTO ConfiguracionSeguridad (NombreConfig, ValorConfig, Descripcion) VALUES
('TIEMPO_SESION_MINUTOS', '30', 'Tiempo máximo de inactividad de sesión en minutos'),
('MAX_INTENTOS_LOGIN', '5', 'Número máximo de intentos de login fallidos'),
('TIEMPO_BLOQUEO_MINUTOS', '15', 'Tiempo de bloqueo tras exceder intentos fallidos'),
('FRECUENCIA_GPS_SEGUNDOS', '30', 'Frecuencia de actualización GPS en segundos'),
('TIEMPO_INACTIVIDAD_ALERTA_MINUTOS', '10', 'Tiempo de inactividad para alerta en minutos');

-- 4. USUARIOS
INSERT INTO Usuario (ID, NombreCompleto, Correo, Telefono, HashContrasena, EstaActivo, CorreoVerificado, CreadoEn) VALUES
('11111111-1111-1111-1111-111111111111', 'Carlos Rodríguez', 'carlos.rodriguez@email.com', '+56912345678', 
 '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr/.cZH.hJ8hF4vX9s7qXqXqXqXqXq', true, true, NOW()),
('22222222-2222-2222-2222-222222222222', 'Ana Martínez', 'ana.martinez@email.com', '+56987654321', 
 '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr/.cZH.hJ8hF4vX9s7qXqXqXqXqXq', true, true, NOW()),
('33333333-3333-3333-3333-333333333333', 'Admin Sistema', 'admin@gpsguardian.com', '+56911111111', 
 '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr/.cZH.hJ8hF4vX9s7qXqXqXqXqXq', true, true, NOW());

-- Asignar Roles a Usuarios
INSERT INTO Usuario_Rol (UsuarioID, RolID) VALUES
('11111111-1111-1111-1111-111111111111', (SELECT ID FROM Rol WHERE NombreRol = 'PADRE')),
('22222222-2222-2222-2222-222222222222', (SELECT ID FROM Rol WHERE NombreRol = 'PADRE')),
('33333333-3333-3333-3333-333333333333', (SELECT ID FROM Rol WHERE NombreRol = 'ADMIN'));

-- 5. ESTUDIANTES
INSERT INTO Estudiante (ID, UsuarioID, NombreCompleto, GradoEscolar, FechaNacimiento, EstaActivo) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Mateo Rodríguez Martínez', 'QUINTO', '2014-05-15', true),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', 'Valentina Rodríguez Martínez', 'SEGUNDO', '2017-08-22', true),
('cccccccc-cccc-cccc-cccc-cccccccccccc', '22222222-2222-2222-2222-222222222222', 'Sofía Martínez López', 'SEPTIMO', '2012-03-10', true);

-- 6. CONTACTOS DE EMERGENCIA
INSERT INTO ContactoEmergencia (EstudianteID, NombreCompleto, Telefono, Parentesco, EsPrincipal) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Laura Martínez', '+56922223333', 'Madre', true),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'José Rodríguez', '+56933334444', 'Padre', false),
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Miguel López', '+56944445555', 'Padre', true);

-- 7. RUTAS
INSERT INTO Ruta (ID, NombreRuta, Descripcion, LatitudOrigen, LongitudOrigen, LatitudDestino, LongitudDestino, CreadoPor) VALUES
('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Ruta Norte - Mañana', 'Recoge estudiantes zona norte hacia colegio', 
 -33.456940, -70.648270, -33.456940, -70.648270, '11111111-1111-1111-1111-111111111111'),
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Ruta Sur - Tarde', 'Regreso zona sur desde colegio', 
 -33.456940, -70.648270, -33.500000, -70.650000, '11111111-1111-1111-1111-111111111111'),
('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Ruta Oriente - Mañana', 'Servicio express zona oriente', 
 -33.456940, -70.648270, -33.440000, -70.620000, '22222222-2222-2222-2222-222222222222');

-- 8. ASIGNACIÓN ESTUDIANTES A RUTAS
INSERT INTO Estudiante_Ruta (EstudianteID, RutaID, EstaActivo) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'dddddddd-dddd-dddd-dddd-dddddddddddd', true),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', true),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'dddddddd-dddd-dddd-dddd-dddddddddddd', true),
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'ffffffff-ffff-ffff-ffff-ffffffffffff', true);

-- 9. PARADAS
INSERT INTO Parada (RutaID, OrdenParada, NombreParada, Latitud, Longitud) VALUES
('dddddddd-dddd-dddd-dddd-dddddddddddd', 1, 'Parada Los Pinos', -33.460000, -70.650000),
('dddddddd-dddd-dddd-dddd-dddddddddddd', 2, 'Parada El Golf', -33.455000, -70.648000),
('dddddddd-dddd-dddd-dddd-dddddddddddd', 3, 'Parada Centro', -33.450000, -70.647000),
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 1, 'Colegio (Salida)', -33.456940, -70.648270),
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 2, 'Parada Plaza Sur', -33.470000, -70.649000),
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 3, 'Parada Los Presidentes', -33.490000, -70.650000);

-- 10. ZONAS SEGURAS
INSERT INTO ZonaSegura (EstudianteID, NombreZona, Latitud, Longitud, RadioMetros, SegundosInactividadAlerta, CreadoPor) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Casa Familiar', -33.460000, -70.650000, 100, 600, '11111111-1111-1111-1111-111111111111'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Colegio', -33.456940, -70.648270, 50, 300, '11111111-1111-1111-1111-111111111111'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Casa Abuelos', -33.455000, -70.655000, 80, 600, '11111111-1111-1111-1111-111111111111'),
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Casa Sofía', -33.470000, -70.640000, 100, 600, '22222222-2222-2222-2222-222222222222');

-- 11. CONFIGURACIÓN DE NOTIFICACIONES
INSERT INTO ConfiguracionNotificacion (UsuarioID, AlertaRetraso, AlertaCambioRuta, AlertaLlegada, AlertaInactividad) VALUES
('11111111-1111-1111-1111-111111111111', true, true, true, true),
('22222222-2222-2222-2222-222222222222', true, false, true, true),
('33333333-3333-3333-3333-333333333333', false, true, true, false);

-- 12. TRAYECTOS (antes Viajes)
INSERT INTO Trayecto (ID, EstudianteID, RutaID, InicioTrayecto, Estado, TuvoDesvio) VALUES
('11111111-aaaa-1111-aaaa-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 
 NOW() - INTERVAL '2 hours', 'COMPLETADO', false),
('22222222-bbbb-2222-bbbb-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 
 NOW() - INTERVAL '1 hour', 'EN_CURSO', false),
('33333333-cccc-3333-cccc-333333333333', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 
 NOW() - INTERVAL '30 minutes', 'PENDIENTE', false);

-- 13. COORDENADAS
INSERT INTO Coordenada (TrayectoID, Latitud, Longitud, RegistradoEn, VelocidadKmh) VALUES
('11111111-aaaa-1111-aaaa-111111111111', -33.460000, -70.650000, NOW() - INTERVAL '2 hours', 0),
('11111111-aaaa-1111-aaaa-111111111111', -33.458000, -70.649000, NOW() - INTERVAL '1 hour 55 minutes', 30),
('11111111-aaaa-1111-aaaa-111111111111', -33.456940, -70.648270, NOW() - INTERVAL '1 hour 50 minutes', 0),
('22222222-bbbb-2222-bbbb-222222222222', -33.456940, -70.648270, NOW() - INTERVAL '55 minutes', 0),
('22222222-bbbb-2222-bbbb-222222222222', -33.460000, -70.649000, NOW() - INTERVAL '45 minutes', 25),
('22222222-bbbb-2222-bbbb-222222222222', -33.470000, -70.649000, NOW() - INTERVAL '35 minutes', 28);

-- 14. NOTIFICACIONES
INSERT INTO Notificacion (TrayectoID, ZonaSeguraID, TipoEvento, Mensaje, FueEnviada, FechaHoraEvento) VALUES
('11111111-aaaa-1111-aaaa-111111111111', NULL, 'INICIO_TRAYECTO', 'Trayecto iniciado - Mateo está en camino al colegio', true, NOW() - INTERVAL '2 hours'),
('11111111-aaaa-1111-aaaa-111111111111', NULL, 'LLEGADA', 'Mateo ha llegado al colegio', true, NOW() - INTERVAL '1 hour 50 minutes'),
('22222222-bbbb-2222-bbbb-222222222222', NULL, 'RETRASO', 'Ruta con retraso de 10 minutos - Valentina viene en camino', true, NOW() - INTERVAL '45 minutes'),
(NULL, (SELECT ID FROM ZonaSegura WHERE EstudianteID = 'cccccccc-cccc-cccc-cccc-cccccccccccc' LIMIT 1), 'ALERTA_ZONA', 'Sofía ha salido de la zona segura (Casa)', false, NOW());

-- 15. RECIBOS DE NOTIFICACIONES
INSERT INTO ReciboNotificacion (NotificacionID, UsuarioID, FueLeida, RecibidoEn, LeidoEn) 
SELECT n.ID, u.ID, false, NOW(), NULL
FROM Notificacion n, Usuario u
WHERE u.Correo IN ('carlos.rodriguez@email.com', 'ana.martinez@email.com')
LIMIT 5;

-- 16. SESIONES DE USUARIO
INSERT INTO SesionUsuario (UsuarioID, Token, IpOrigen, EstadoSesion, InicioSesion) VALUES
('11111111-1111-1111-1111-111111111111', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...', '192.168.1.100', 'ACTIVA', NOW()),
('33333333-3333-3333-3333-333333333333', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...', '10.0.0.1', 'ACTIVA', NOW());

-- 17. LOGS
INSERT INTO RegistroActividad (UsuarioID, TipoAccion, Descripcion, IpOrigen, Metadatos, CreadoEn) VALUES
('11111111-1111-1111-1111-111111111111', 'LOGIN', 'Usuario inició sesión', '192.168.1.100', '{"navegador": "Chrome", "so": "Windows"}'::jsonb, NOW()),
('11111111-1111-1111-1111-111111111111', 'VER_UBICACION', 'Visualizó ubicación de Mateo', '192.168.1.100', '{"estudiante": "Mateo Rodríguez"}'::jsonb, NOW()),
('33333333-3333-3333-3333-333333333333', 'CREAR_RUTA', 'Administrador creó nueva ruta', '10.0.0.1', '{"ruta": "Ruta Norte"}'::jsonb, NOW());

INSERT INTO RegistroAuditoria (UsuarioID, Accion, Descripcion, IpOrigen, Metadatos, CreadoEn) VALUES
('33333333-3333-3333-3333-333333333333', 'ASIGNACION_ROL', 'Asignó rol PADRE a usuario', '10.0.0.1', '{"usuario_destino": "ana.martinez@email.com"}'::jsonb, NOW()),
(NULL, 'LOGIN_FALLIDO', 'Intento de login fallido - contraseña incorrecta', '192.168.1.200', '{"correo": "invalido@email.com"}'::jsonb, NOW());

-- =============================================
-- FIN DML
-- =============================================
