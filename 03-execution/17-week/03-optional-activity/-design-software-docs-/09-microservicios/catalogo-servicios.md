# Catalogo de servicios

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este catalogo alinea los 10 modulos funcionales del proyecto con una propuesta inicial de servicios. La propuesta evita crear microservicios ficticios y permite iniciar como monolito modular o monolito distribuido con limites claros.

## Servicios propuestos

| Servicio documental | Modulos cubiertos | Responsabilidad principal | Estado |
|---------------------|-------------------|---------------------------|--------|
| `iam-service` | M01 Seguridad y Acceso | Autenticacion, autorizacion, permisos, sesiones y auditoria de acceso | Propuesto |
| `reference-data-service` | M02 Estructura Institucional, M04 Parametrizacion | Regionales, centros, ubicaciones, catalogos base y parametros generales | Propuesto |
| `training-environment-service` | M03 Infraestructura | Ambientes de formacion, inventario y disponibilidad de recursos | Propuesto |
| `academic-management-service` | M05 Programas de Formacion, M06 Oferta y Programas | Programas, diseno curricular, competencias, RAP, fichas y proyectos formativos | Propuesto |
| `actors-service` | M07 Actores | Instructores, aprendices, directivos y relaciones academicas | Propuesto |
| `scheduling-service` | M08 Horarios | Asignacion de horarios, observaciones, incidencias y validacion de conflictos | Propuesto |
| `monitoring-service` | M09 Proyectos Formativos | Seguimiento, alertas, KPIs y notificaciones de avance | Propuesto |
| `coordination-service` | M10 Coordinacion y Eventos | Eventos academicos, coordinacion y agenda institucional | Propuesto |
| `document-service` | Transversal | Plantillas, adjuntos, evidencias, PDF y ciclo de vida documental | Propuesto |
| `audit-service` | Transversal | Registro append-only de cambios relevantes y trazabilidad tecnica | Propuesto |

## Criterio de agrupacion

- M02 y M04 se agrupan porque comparten datos maestros y catalogos.
- M05 y M06 se agrupan porque pertenecen al nucleo academico de programas, fichas y proyectos formativos.
- M08 se mantiene separado porque el motor de horarios sera una capacidad critica.
- Auditoria y documentos quedan como servicios transversales.

## Estados permitidos

| Estado | Significado |
|--------|-------------|
| Propuesto | Existe como limite documental, aun sin implementacion real |
| Aprobado | Tiene decision registrada y puede crear carpeta en `servicios/` |
| En documentacion | Ya tiene carpeta y plantilla en proceso |
| Estable | Documentacion revisada y trazable |
| Deprecado | Fue reemplazado o fusionado |

## Relacion con carpetas reales

La carpeta `servicios/` permanece vacia hasta que un servicio este aprobado. Cuando eso ocurra, se copia `_plantilla/` y se completa la documentacion minima.
