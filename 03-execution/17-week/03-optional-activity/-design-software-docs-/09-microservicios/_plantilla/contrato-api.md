# Contrato API del servicio

Esta plantilla se usa cuando un servicio aprobado necesite documentar endpoints, errores y eventos relacionados. No debe incluir tokens, credenciales, URLs privadas ni datos reales sensibles.

## Informacion general

| Campo | Guia |
|-------|------|
| Servicio | Nombre del servicio aprobado |
| Modulos relacionados | Modulos funcionales que atiende |
| Requisitos | IDs de requisitos funcionales o no funcionales |
| Estado del contrato | Borrador, en revision o estable |

## Endpoints

| Metodo | Ruta | Proposito | Requisito |
|--------|------|-----------|-----------|
| GET | `/recurso` | Consultar informacion del recurso | RF-XXX |
| POST | `/recurso` | Crear un nuevo registro del recurso | RF-XXX |
| PUT | `/recurso/{id}` | Actualizar un registro existente | RF-XXX |

## Errores esperados

| Codigo | Significado | Accion recomendada |
|--------|-------------|--------------------|
| 400 | Solicitud invalida | Revisar campos enviados |
| 401 | No autenticado | Validar acceso |
| 403 | Sin permiso | Revisar perfil o permisos |
| 404 | Recurso no encontrado | Confirmar identificador |

## Eventos relacionados

| Evento | Publica o consume | Requisito |
|--------|-------------------|-----------|
| EventoDeDominio | Publica | RF-XXX |
| EventoExterno | Consume | RF-XXX |

## Regla

Cada endpoint debe tener requisito asociado. Si no existe requisito, primero se actualiza `04-requisitos/matriz-trazabilidad.md`.
