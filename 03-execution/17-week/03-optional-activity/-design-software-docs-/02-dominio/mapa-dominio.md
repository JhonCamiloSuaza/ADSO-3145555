# Mapa de dominio

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este mapa organiza el dominio funcional del proyecto Horarios SENA en 10 modulos. La vista de dominio no obliga a crear un microservicio por modulo; sirve para entender responsabilidades, dependencias y trazabilidad.

## Modulos

| ID | Modulo | Responsabilidad | Servicio propuesto |
|----|--------|-----------------|--------------------|
| M01 | Seguridad y Acceso | Multi-tenant, permisos, sesiones y auditoria de acceso | `iam-service` |
| M02 | Estructura Institucional | Regionales, centros de formacion y ubicacion especifica | `reference-data-service` |
| M03 | Infraestructura | Ambientes, inventario y disponibilidad de recursos | `training-environment-service` |
| M04 | Parametrizacion | Catalogos base, parametros genericos y configuraciones | `reference-data-service` |
| M05 | Programas de Formacion | Lineas, redes, tipos de formacion, diseno curricular, competencias y RAP | `academic-management-service` |
| M06 | Oferta y Programas | Proyecto formativo, fichas, entregables y asociacion de aprendices | `academic-management-service` |
| M07 | Actores | Instructores, aprendices y directivos | `actors-service` |
| M08 | Horarios | Asignacion, observaciones e incidencias | `scheduling-service` |
| M09 | Proyectos Formativos | Seguimiento, alertas, KPIs y notificaciones | `monitoring-service` |
| M10 | Coordinacion y Eventos | Eventos academicos y coordinacion institucional | `coordination-service` |

## Subdominios

| Subdominio | Modulos | Tipo |
|------------|---------|------|
| Gobierno y seguridad | M01 | Transversal |
| Datos maestros institucionales | M02, M04 | Soporte |
| Recursos de formacion | M03 | Soporte |
| Gestion academica | M05, M06 | Core |
| Comunidad academica | M07 | Core |
| Planeacion horaria | M08 | Core |
| Seguimiento y mejora | M09 | Core |
| Coordinacion institucional | M10 | Soporte |

## Reglas de dominio

- Un modulo debe tener responsabilidad entendible por negocio.
- Una entidad principal debe tener un modulo responsable.
- Las reglas de negocio se documentan en [entidades-y-reglas.md](./entidades-y-reglas.md).
- Los eventos de dominio se documentan en [eventos-dominio.md](./eventos-dominio.md) y se relacionan con [09-microservicios/catalogo-eventos.md](../09-microservicios/catalogo-eventos.md).
