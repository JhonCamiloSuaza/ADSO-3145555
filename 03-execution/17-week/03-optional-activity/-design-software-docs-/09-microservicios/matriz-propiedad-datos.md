# Matriz de propiedad de datos

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Esta matriz define que servicio propuesto seria responsable conceptual de cada grupo de datos. No crea bases de datos reales ni obliga a separar almacenamiento desde el inicio.

| Grupo de datos | Responsable conceptual | Consumidores principales |
|----------------|------------------------|--------------------------|
| Usuarios, roles, permisos y sesiones | `iam-service` | Todos |
| Regionales, centros y ubicaciones | `reference-data-service` | Todos |
| Catalogos base y parametros | `reference-data-service` | Todos |
| Ambientes, inventario y disponibilidad | `training-environment-service` | `scheduling-service`, `coordination-service` |
| Programas, competencias, RAP y diseno curricular | `academic-management-service` | `scheduling-service`, `monitoring-service` |
| Fichas, proyectos formativos y entregables | `academic-management-service` | `actors-service`, `monitoring-service` |
| Instructores, aprendices y directivos | `actors-service` | `academic-management-service`, `scheduling-service` |
| Horarios, observaciones e incidencias | `scheduling-service` | `monitoring-service`, `coordination-service` |
| Seguimiento, KPIs y notificaciones | `monitoring-service` | Coordinacion, directivos |
| Eventos academicos y coordinacion | `coordination-service` | Actores, horarios |
| Documentos, adjuntos y plantillas | `document-service` | Todos |
| Auditoria de cambios | `audit-service` | Gobierno, calidad, arquitectura |

## Regla

Un dato debe tener un responsable principal. Otros servicios pueden consultarlo o referenciarlo, pero no deben redefinir su significado.
