# Historias de usuario

Estas historias describen necesidades desde la perspectiva de quienes usaran o revisaran el sistema. Son una base inicial para entender flujos; pueden crecer cuando el equipo tenga mas detalle.

## Historias por modulo

| ID | Historia | Modulo | Criterio de aceptacion |
|----|----------|--------|------------------------|
| HU-001 | Como responsable del sistema, quiero definir permisos para controlar que acciones puede realizar cada perfil. | M01 | Los permisos se relacionan con perfiles y quedan auditables |
| HU-002 | Como usuario autorizado, quiero consultar regionales y centros para ubicar correctamente la informacion academica. | M02 | Cada centro esta asociado a una regional |
| HU-003 | Como responsable de ambientes, quiero registrar ambientes e inventario para conocer recursos disponibles. | M03 | Cada ambiente tiene ubicacion y disponibilidad |
| HU-004 | Como administrador funcional, quiero mantener catalogos base para evitar datos repetidos. | M04 | Los catalogos pueden ser reutilizados por otros modulos |
| HU-005 | Como equipo academico, quiero registrar programas, competencias y RAP para estructurar la formacion. | M05 | Cada RAP esta asociado a una competencia |
| HU-006 | Como coordinador academico, quiero crear fichas y proyectos formativos para organizar la oferta. | M06 | Cada ficha se relaciona con un programa |
| HU-007 | Como responsable academico, quiero asociar aprendices e instructores para usarlos en horarios y seguimiento. | M07 | Los actores pueden relacionarse con fichas, proyectos u horarios |
| HU-008 | Como coordinador, quiero asignar horarios validando conflictos de ambiente e instructor. | M08 | El sistema identifica conflictos antes de aceptar la asignacion |
| HU-009 | Como equipo de seguimiento, quiero registrar avances y KPIs de proyectos formativos. | M09 | Cada seguimiento queda asociado a un proyecto |
| HU-010 | Como coordinador, quiero programar eventos academicos con participantes definidos. | M10 | El evento registra fecha, objetivo y participantes |

## Regla

Cada historia debe poder enlazarse con un requisito funcional y un modulo de dominio. Si no se puede enlazar, la historia todavia esta incompleta.
