# Autenticacion y autorizacion

Este documento define criterios conceptuales de seguridad para APIs. No contiene proveedores reales, secretos ni configuraciones sensibles.

## Alcance

- Identificar usuarios.
- Validar permisos.
- Registrar acciones relevantes.
- Proteger recursos segun perfil.

## Reglas

- Ningun endpoint debe asumir acceso libre si consulta o modifica informacion del proyecto.
- Las acciones sensibles deben generar auditoria.
- No se documentan tokens, llaves, usuarios reales ni contrasenas.
- Los permisos se relacionan con M01 Seguridad y Acceso.

## Ejemplo conceptual

| Accion | Validacion esperada |
|--------|---------------------|
| Consultar catalogos | Usuario autenticado |
| Crear horario | Permiso sobre M08 Horarios |
| Registrar incidencia | Permiso sobre M08 y auditoria |
| Consultar KPIs | Permiso sobre M09 Seguimiento |
