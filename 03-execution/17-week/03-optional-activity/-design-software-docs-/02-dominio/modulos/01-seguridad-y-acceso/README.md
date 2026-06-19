# M01 - Seguridad y Acceso

## Que significa

Este modulo define como se controla el ingreso al sistema, que puede hacer cada persona y como se deja evidencia de acciones importantes. Es la base para que los demas modulos operen con trazabilidad.

## Por que va primero

Va primero porque antes de administrar centros, programas, horarios o proyectos se debe saber quien entra, con que permisos y que acciones deben auditarse.

## Alcance inicial

- Multi-tenant o separacion conceptual por contexto institucional cuando aplique.
- Perfiles y permisos.
- Sesiones.
- Auditoria de acceso.
- Reglas para no exponer credenciales ni datos sensibles.

## No incluye

- Usuarios reales.
- Correos reales.
- Contrasenas, tokens o secretos.
- Configuracion real de proveedores de identidad.

## Entidades principales

| Entidad | Descripcion |
|---------|-------------|
| Usuario | Persona que puede interactuar con el sistema |
| Perfil | Agrupacion de permisos por responsabilidad |
| Permiso | Accion permitida sobre una funcionalidad |
| Sesion | Registro de ingreso o actividad |
| Auditoria | Evidencia de una accion relevante |

## Requisitos relacionados

- RF-001: autenticacion, autorizacion y permisos.
- RF-002: registro de acciones relevantes para auditoria.

## Servicio propuesto

`iam-service`

## Siguiente modulo

Despues de definir acceso, se documenta `02-estructura-institucional`, porque el sistema necesita saber sobre que regionales, centros y ubicaciones se trabajara.
