# Modelos de datos

Este documento presenta un modelo conceptual inicial. Sirve para entender grupos de datos, no para imponer una base de datos definitiva.

## Modelo conceptual por modulo

| Modulo | Datos principales | Relacion clave |
|--------|------------------|----------------|
| M01 Seguridad y Acceso | usuarios, perfiles, permisos, sesiones, auditoria | Usuario tiene perfiles y permisos |
| M02 Estructura Institucional | regionales, centros, ubicaciones | Regional contiene centros |
| M03 Infraestructura | ambientes, recursos, inventario, disponibilidad | Ambiente pertenece a ubicacion |
| M04 Parametrizacion | catalogos, parametros, valores | Catalogo contiene valores |
| M05 Programas de Formacion | programas, disenos, competencias, RAP | Programa contiene diseno curricular |
| M06 Oferta y Programas | fichas, proyectos, entregables | Ficha se asocia a programa |
| M07 Actores | instructores, aprendices, directivos | Actor participa en procesos academicos |
| M08 Horarios | horarios, franjas, asignaciones, incidencias | Horario cruza ambiente, ficha e instructor |
| M09 Proyectos Formativos | seguimientos, KPIs, alertas, notificaciones | Seguimiento pertenece a proyecto |
| M10 Coordinacion y Eventos | eventos, agenda, participantes | Evento tiene participantes |

## Reglas

- Un dato compartido debe tener un responsable conceptual.
- Los datos maestros deben evitar duplicidad.
- La informacion sensible debe minimizarse.
- Los modelos fisicos se definen cuando exista implementacion.

## Relacion con microservicios

La propiedad conceptual de datos se detalla en `09-microservicios/matriz-propiedad-datos.md`.
