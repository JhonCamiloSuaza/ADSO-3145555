# Catálogo de servicios

> Estado: 🔴 | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Arquitectura

Este catálogo presenta los servicios principales de la plataforma Horarios SENA y su clasificación de dominio.

| Servicio | Descripción | Dominio | Owner | Repo | Estado |
|----------|-------------|---------|-------|------|--------|
| `trazabilidad-formacion-api` | API central de gestión de proyectos formativos, seguimiento de etapas y estados. | Dominio de formación | Arquitectura SENA | `repo/trazabilidad-formacion-api` | 🔴 |
| `ficha-api` | Servicio de consulta y actualización de fichas de aprendiz y programas. | Dominio de datos de ficha | Arquitectura SENA | `repo/ficha-api` | 🔴 |
| `programa-formacion-api` | API de gestión de programas, jornadas, horarios y asignaciones. | Dominio de programa | Arquitectura SENA | `repo/programa-formacion-api` | 🔴 |
| `integracion-sena-api` | Capa de integración con sistemas oficiales SENA (SOFIA Plus, BETOWA, servicios externos). | Integración | Arquitectura SENA | `repo/integracion-sena-api` | 🔴 |
| `auditoria-api` | Registro de eventos de auditoría, cambios de estado y trazabilidad de decisiones. | Plataforma | Arquitectura SENA | `repo/auditoria-api` | 🔴 |
| `notification-service` | Servicio de notificaciones y alertas transversales para aprendices, instructores y administradores. | Plataforma | Arquitectura SENA | `repo/notification-service` | 🔴 |

## Categorías de servicio

- Dominio de formación: servicios que representan el negocio de SENA.
- Integración: servicios que aíslan la comunicación con sistemas externos.
- Plataforma: servicios transversales de auditoría y notificaciones.

## Uso del catálogo

- El catálogo sirve como fuente única para priorizar documentación de servicios.
- Cada servicio debe tener su propia documentación en `09-microservices/services/`.
- El detalle de contratos, eventos y dependencias se publica en la carpeta de cada servicio.
