# Matriz de trazabilidad

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Esta es la matriz canonica de trazabilidad del repositorio. Relaciona requisitos, modulos de dominio, servicios propuestos y documentos tecnicos.

## Matriz inicial

| Requisito | Modulo | Dominio | Servicio propuesto | API / Evento | Documento relacionado | Estado |
|-----------|--------|---------|--------------------|--------------|-----------------------|--------|
| RF-001 | M01 | Seguridad y Acceso | `iam-service` | API de identidad | `09-microservicios/catalogo-servicios.md` | En progreso |
| RF-002 | M01 | Auditoria | `audit-service` | Evento de auditoria | `09-microservicios/catalogo-eventos.md` | En progreso |
| RF-003 | M02 | Estructura Institucional | `reference-data-service` | API de datos maestros | `02-dominio/mapa-dominio.md` | En progreso |
| RF-004 | M03 | Infraestructura | `training-environment-service` | API de ambientes | `09-microservicios/matriz-propiedad-datos.md` | En progreso |
| RF-005 | M04 | Parametrizacion | `reference-data-service` | API de catalogos | `09-microservicios/matriz-propiedad-datos.md` | En progreso |
| RF-006 | M05 | Programas de Formacion | `academic-management-service` | API academica | `02-dominio/mapa-dominio.md` | En progreso |
| RF-007 | M06 | Oferta y Programas | `academic-management-service` | Evento `TrainingProjectCreated` | `09-microservicios/catalogo-eventos.md` | En progreso |
| RF-008 | M07 | Actores | `actors-service` | API de actores | `09-microservicios/mapa-dependencias.md` | En progreso |
| RF-009 | M08 | Horarios | `scheduling-service` | Evento `ScheduleAssigned` | `09-microservicios/catalogo-eventos.md` | En progreso |
| RF-010 | M08 | Horarios | `scheduling-service` | Evento `ScheduleIncidentReported` | `09-microservicios/catalogo-eventos.md` | En progreso |
| RF-011 | M09 | Proyectos Formativos | `monitoring-service` | KPIs / alertas | `15-control-proyecto/riesgos.md` | En progreso |
| RF-012 | M10 | Coordinacion y Eventos | `coordination-service` | Evento `CoordinationEventScheduled` | `09-microservicios/catalogo-eventos.md` | En progreso |
| RF-013 | Transversal | Documentos | `document-service` | Evento `DocumentGenerated` | `09-microservicios/almacenamiento-documentos.md` | En progreso |

## Como mantenerla

- Cada requisito nuevo debe tener ID unico.
- Cada requisito debe apuntar a un modulo o indicar que es transversal.
- Si afecta arquitectura, debe enlazar una decision ADR.
- Si afecta integracion, debe enlazar API o evento.
- Si afecta datos, debe revisar la matriz de propiedad en `09-microservicios/matriz-propiedad-datos.md`.

## Fuente de verdad

La trazabilidad operativa vive aqui. Los documentos de gobierno pueden explicar la regla, pero no deben mantener una segunda matriz paralela.
