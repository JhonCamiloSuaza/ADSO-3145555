# Requisitos funcionales

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Los requisitos funcionales se organizan por modulo para conservar trazabilidad entre dominio, arquitectura, APIs y servicios.

## Requisitos base

| ID | Modulo | Requisito | Servicio propuesto |
|----|--------|-----------|--------------------|
| RF-001 | M01 Seguridad y Acceso | El sistema debe permitir autenticacion, autorizacion y control de permisos por rol o perfil. | `iam-service` |
| RF-002 | M01 Seguridad y Acceso | El sistema debe registrar acciones relevantes para auditoria documental y tecnica. | `audit-service` |
| RF-003 | M02 Estructura Institucional | El sistema debe administrar regionales, centros de formacion y ubicaciones especificas. | `reference-data-service` |
| RF-004 | M03 Infraestructura | El sistema debe registrar ambientes de formacion, inventario y disponibilidad. | `training-environment-service` |
| RF-005 | M04 Parametrizacion | El sistema debe gestionar catalogos base y parametros reutilizables. | `reference-data-service` |
| RF-006 | M05 Programas de Formacion | El sistema debe registrar lineas, redes, tipos de formacion, disenos curriculares, competencias y RAP. | `academic-management-service` |
| RF-007 | M06 Oferta y Programas | El sistema debe gestionar proyectos formativos, fichas, entregables y asociacion de aprendices. | `academic-management-service` |
| RF-008 | M07 Actores | El sistema debe administrar instructores, aprendices y directivos vinculados a procesos academicos. | `actors-service` |
| RF-009 | M08 Horarios | El sistema debe permitir asignar horarios y validar conflictos de disponibilidad. | `scheduling-service` |
| RF-010 | M08 Horarios | El sistema debe registrar observaciones e incidencias asociadas a horarios. | `scheduling-service` |
| RF-011 | M09 Proyectos Formativos | El sistema debe permitir seguimiento de proyectos formativos, alertas y KPIs. | `monitoring-service` |
| RF-012 | M10 Coordinacion y Eventos | El sistema debe gestionar eventos academicos y actividades de coordinacion. | `coordination-service` |
| RF-013 | Transversal | El sistema debe generar, asociar y consultar documentos, evidencias y reportes. | `document-service` |

## Regla de redaccion

Cada requisito debe expresar que debe hacer el sistema, no como se implementa. La implementacion se documenta en arquitectura, APIs o microservicios.
