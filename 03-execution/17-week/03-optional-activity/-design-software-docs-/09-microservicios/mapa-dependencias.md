# Mapa de dependencias

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este mapa muestra dependencias conceptuales entre servicios propuestos. Sirve para evitar acoplamientos ocultos y para revisar impacto cuando cambie un requisito.

## Dependencias principales

| Servicio origen | Depende de | Motivo |
|-----------------|------------|--------|
| `academic-management-service` | `reference-data-service` | Catalogos, regionales, centros y parametros |
| `academic-management-service` | `actors-service` | Asociacion de instructores y aprendices |
| `training-environment-service` | `reference-data-service` | Ubicacion institucional y catalogos de ambientes |
| `scheduling-service` | `academic-management-service` | Fichas, programas, competencias y proyectos formativos |
| `scheduling-service` | `actors-service` | Disponibilidad de instructores y aprendices |
| `scheduling-service` | `training-environment-service` | Ambientes e inventario disponible |
| `monitoring-service` | `academic-management-service` | Seguimiento de proyectos formativos |
| `monitoring-service` | `scheduling-service` | Incidencias y cumplimiento de horarios |
| `coordination-service` | `actors-service` | Participantes de eventos |
| `document-service` | Todos los servicios de negocio | Evidencias, plantillas, adjuntos y reportes |
| `audit-service` | Todos los servicios | Registro de cambios relevantes |

## Reglas

- Una dependencia debe tener motivo de negocio.
- Si una dependencia aparece en varios documentos, este archivo es la referencia principal.
- Las dependencias tecnicas reales se agregan solo cuando exista implementacion.
