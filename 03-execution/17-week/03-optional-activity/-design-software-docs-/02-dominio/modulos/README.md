# Modulos funcionales del proyecto

Esta carpeta representa los 10 modulos funcionales definidos para Horarios SENA. El orden no es decorativo: muestra como se recomienda entender y construir el dominio.

## Orden recomendado

| Orden | Modulo | Por que va ahi |
|-------|--------|----------------|
| 1 | [Seguridad y Acceso](./01-seguridad-y-acceso/) | Define acceso, permisos y auditoria antes de operar informacion |
| 2 | [Estructura Institucional](./02-estructura-institucional/) | Define regionales, centros y ubicaciones usadas por todo el sistema |
| 3 | [Parametrizacion](./04-parametrizacion/) | Define catalogos base para evitar datos repetidos |
| 4 | [Infraestructura](./03-infraestructura/) | Usa estructura institucional y catalogos para definir ambientes e inventario |
| 5 | [Programas de Formacion](./05-programas-de-formacion/) | Define la base academica: programas, competencias y RAP |
| 6 | [Oferta y Programas](./06-oferta-y-programas/) | Convierte programas en fichas, proyectos formativos y entregables |
| 7 | [Actores](./07-actores/) | Define instructores, aprendices y directivos que participan en la operacion |
| 8 | [Horarios](./08-horarios/) | Cruza actores, ambientes y oferta academica para asignar tiempo |
| 9 | [Proyectos Formativos](./09-proyectos-formativos/) | Hace seguimiento, KPIs y notificaciones sobre la ejecucion |
| 10 | [Coordinacion y Eventos](./10-coordinacion-y-eventos/) | Organiza eventos y coordinacion sobre lo ya planeado |

## Idea central

Primero se documentan las bases; despues se documenta la operacion academica; al final se documentan seguimiento, coordinacion y mejora.

## Relacion con microservicios

Estos modulos son funcionales. No significa que cada modulo sea un microservicio real. La vista tecnica se documenta en `09-microservicios/catalogo-servicios.md`.
