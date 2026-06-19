# M07 - Actores

## Que significa

Este modulo describe las personas que participan en los procesos academicos: instructores, aprendices y directivos. Permite relacionar personas con fichas, proyectos, horarios y eventos.

## Por que va antes de horarios

Los horarios necesitan actores. No se puede asignar una franja sin saber que instructor, aprendiz, directivo o grupo participa.

## Alcance inicial

- Instructores.
- Aprendices.
- Directivos.
- Relaciones academicas basicas.

## No incluye

- Credenciales reales.
- Datos personales sensibles innecesarios.
- Gestion laboral o contractual.

## Entidades principales

| Entidad | Descripcion |
|---------|-------------|
| Instructor | Persona que orienta actividades formativas |
| Aprendiz | Persona en proceso de formacion |
| Directivo | Persona con responsabilidad de coordinacion o revision |
| Rol academico | Participacion funcional dentro del proyecto |

## Requisitos relacionados

- RF-008: administrar instructores, aprendices y directivos.

## Servicio propuesto

`actors-service`

## Siguiente modulo

Despues se documenta `08-horarios`, porque ya existen programas, fichas, ambientes y actores.
