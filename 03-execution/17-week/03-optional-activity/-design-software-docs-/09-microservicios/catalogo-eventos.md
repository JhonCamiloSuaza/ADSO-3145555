# Catalogo de eventos

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este catalogo registra eventos de dominio candidatos. En esta etapa son eventos documentales; no implican que exista una cola, broker o implementacion tecnica.

| Evento | Productor candidato | Consumidores candidatos | Motivo |
|--------|---------------------|-------------------------|--------|
| `InstitutionalStructureUpdated` | `reference-data-service` | `academic-management-service`, `training-environment-service` | Cambios en regionales, centros o ubicaciones |
| `ProgramStructureUpdated` | `academic-management-service` | `scheduling-service`, `monitoring-service` | Cambios en programas, competencias o RAP |
| `TrainingProjectCreated` | `academic-management-service` | `monitoring-service`, `document-service` | Inicio de seguimiento y documentos |
| `LearnerAssignedToProject` | `academic-management-service` | `actors-service`, `monitoring-service` | Asociacion de aprendices a proyecto |
| `EnvironmentAvailabilityChanged` | `training-environment-service` | `scheduling-service` | Disponibilidad de ambientes o inventario |
| `ScheduleAssigned` | `scheduling-service` | `monitoring-service`, `coordination-service`, `audit-service` | Asignacion de horario |
| `ScheduleIncidentReported` | `scheduling-service` | `monitoring-service`, `audit-service` | Incidencia u observacion de horario |
| `TrainingProjectUpdated` | `monitoring-service` | `document-service`, `audit-service` | Avance o cambio de seguimiento |
| `CoordinationEventScheduled` | `coordination-service` | `actors-service`, `scheduling-service` | Evento academico programado |
| `DocumentGenerated` | `document-service` | `audit-service`, servicios solicitantes | Evidencia o reporte generado |

## Campos minimos de un evento

- Nombre del evento.
- Productor.
- Consumidores.
- Motivo de negocio.
- Datos minimos.
- Requisito relacionado.
- Version.
