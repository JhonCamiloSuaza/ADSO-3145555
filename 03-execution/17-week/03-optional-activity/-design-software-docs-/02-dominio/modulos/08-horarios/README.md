# M08 - Horarios

## Que significa

Este modulo es el nucleo operativo del proyecto. Cruza fichas, instructores, aprendices, ambientes, disponibilidad y actividades para construir horarios y registrar observaciones o incidencias.

## Por que va despues de actores

El horario necesita datos previos: estructura institucional, ambientes, programas, fichas y actores. Por eso no debe documentarse como primer modulo.

## Alcance inicial

- Asignacion de horarios.
- Validacion de conflictos.
- Observaciones.
- Incidencias.
- Relacion con ambientes, fichas e instructores.

## No incluye

- Seguimiento completo de proyectos.
- Eventos institucionales independientes.
- Automatizacion real del motor de horarios.

## Entidades principales

| Entidad | Descripcion |
|---------|-------------|
| Horario | Programacion de una actividad |
| Franja | Bloque de tiempo |
| Asignacion | Relacion entre horario, ambiente, ficha e instructor |
| Observacion | Nota sobre una programacion |
| Incidencia | Problema o situacion que afecta el horario |

## Requisitos relacionados

- RF-009: asignar horarios y validar conflictos.
- RF-010: registrar observaciones e incidencias.

## Servicio propuesto

`scheduling-service`

## Siguiente modulo

Despues se documenta `09-proyectos-formativos`, porque los horarios generan informacion que puede afectar seguimiento, alertas y KPIs.
