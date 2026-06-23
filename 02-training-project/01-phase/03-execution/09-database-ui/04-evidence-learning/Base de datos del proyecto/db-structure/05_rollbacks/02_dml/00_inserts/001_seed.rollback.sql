DELETE FROM RegistroAuditoria
WHERE Accion IN ('ASIGNACION_ROL', 'LOGIN_FALLIDO');

DELETE FROM RegistroActividad
WHERE UsuarioID IN (
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333'
);

DELETE FROM SesionUsuario
WHERE UsuarioID IN (
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333'
);

DELETE FROM ReciboNotificacion
WHERE UsuarioID IN (
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222'
);

DELETE FROM Notificacion
WHERE TipoEvento IN ('INICIO_TRAYECTO', 'LLEGADA', 'RETRASO', 'ALERTA_ZONA');

DELETE FROM Coordenada
WHERE TrayectoID IN (
    '11111111-aaaa-1111-aaaa-111111111111',
    '22222222-bbbb-2222-bbbb-222222222222'
);

DELETE FROM Trayecto
WHERE ID IN (
    '11111111-aaaa-1111-aaaa-111111111111',
    '22222222-bbbb-2222-bbbb-222222222222',
    '33333333-cccc-3333-cccc-333333333333'
);

DELETE FROM ConfiguracionNotificacion
WHERE UsuarioID IN (
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    '33333333-3333-3333-3333-333333333333'
);

DELETE FROM ZonaSegura
WHERE EstudianteID IN (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    'cccccccc-cccc-cccc-cccc-cccccccccccc'
);

DELETE FROM Parada
WHERE RutaID IN (
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee'
);

DELETE FROM Estudiante_Ruta
WHERE EstudianteID IN (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    'cccccccc-cccc-cccc-cccc-cccccccccccc'
);

DELETE FROM ContactoEmergencia
WHERE EstudianteID IN (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'cccccccc-cccc-cccc-cccc-cccccccccccc'
);

DELETE FROM Estudiante
WHERE ID IN (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    'cccccccc-cccc-cccc-cccc-cccccccccccc'
);

DELETE FROM Ruta
WHERE ID IN (
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
    'ffffffff-ffff-ffff-ffff-ffffffffffff'
);

DELETE FROM Usuario_Rol
WHERE UsuarioID IN (
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    '33333333-3333-3333-3333-333333333333'
);

DELETE FROM Usuario
WHERE ID IN (
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    '33333333-3333-3333-3333-333333333333'
);

DELETE FROM Rol_Permiso;

DELETE FROM ConfiguracionSeguridad
WHERE NombreConfig IN (
    'TIEMPO_SESION_MINUTOS',
    'MAX_INTENTOS_LOGIN',
    'TIEMPO_BLOQUEO_MINUTOS',
    'FRECUENCIA_GPS_SEGUNDOS',
    'TIEMPO_INACTIVIDAD_ALERTA_MINUTOS'
);

DELETE FROM PoliticaContrasena
WHERE LongitudMinima = 10
  AND LongitudMaxima = 128
  AND DiasExpiracion = 90;

DELETE FROM Permiso
WHERE NombrePermiso IN (
    'USUARIO_CREAR',
    'USUARIO_LEER',
    'USUARIO_ACTUALIZAR',
    'USUARIO_ELIMINAR',
    'ESTUDIANTE_CREAR',
    'ESTUDIANTE_LEER',
    'ESTUDIANTE_ACTUALIZAR',
    'ESTUDIANTE_ELIMINAR',
    'RUTA_CREAR',
    'RUTA_LEER',
    'RUTA_ACTUALIZAR',
    'RUTA_ELIMINAR',
    'VER_UBICACION',
    'ZONA_CREAR',
    'ZONA_LEER',
    'ZONA_ACTUALIZAR',
    'ZONA_ELIMINAR',
    'ENVIAR_NOTIFICACION',
    'VER_REPORTES',
    'VER_AUDITORIA'
);

DELETE FROM Rol
WHERE NombreRol IN ('ADMIN', 'PADRE');
