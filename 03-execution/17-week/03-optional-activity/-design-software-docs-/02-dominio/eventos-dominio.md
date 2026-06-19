# Eventos de dominio

Este documento describe eventos importantes del negocio. Un evento de dominio significa que algo relevante ocurrio en el sistema o en el proceso academico. No implica todavia que exista una cola, broker o tecnologia de eventos.

## Para que sirven

Los eventos ayudan a entender dependencias entre modulos. Por ejemplo, cuando se asigna un horario, pueden verse afectados seguimiento, auditoria, notificaciones y coordinacion.

## Eventos principales

| Evento | Modulo origen | Que significa | Modulos interesados |
|--------|---------------|---------------|---------------------|
| `UsuarioAutenticado` | M01 | Una persona ingreso al sistema | Auditoria |
| `PermisoActualizado` | M01 | Cambio una regla de acceso | Auditoria, Gobernanza |
| `EstructuraInstitucionalActualizada` | M02 | Cambio una regional, centro o ubicacion | M03, M05, M08 |
| `CatalogoActualizado` | M04 | Cambio un catalogo o parametro base | Todos |
| `AmbienteActualizado` | M03 | Cambio informacion de un ambiente | M08, M10 |
| `DisponibilidadAmbienteCambiada` | M03 | Cambio la disponibilidad de un ambiente | M08 |
| `ProgramaFormacionActualizado` | M05 | Cambio un programa, competencia o RAP | M06, M08, M09 |
| `FichaCreada` | M06 | Se creo una ficha asociada a un programa | M07, M08, M09 |
| `ProyectoFormativoCreado` | M06 | Se creo un proyecto formativo | M09, Documentos |
| `AprendizAsociadoProyecto` | M06 | Un aprendiz quedo asociado a un proyecto | M07, M09 |
| `ActorAcademicoActualizado` | M07 | Cambio informacion de aprendiz, instructor o directivo | M08, M10 |
| `HorarioAsignado` | M08 | Se asigno una franja de horario | M09, M10, Auditoria |
| `IncidenciaHorarioRegistrada` | M08 | Se reporto una situacion sobre un horario | M09, Auditoria |
| `SeguimientoProyectoActualizado` | M09 | Cambio el avance o estado de seguimiento | M10, Documentos |
| `NotificacionSolicitada` | M09 | Se debe informar un cambio relevante | Actores |
| `EventoCoordinacionProgramado` | M10 | Se programo una actividad de coordinacion | M07, M08 |

## Formato recomendado

Cada evento debe documentarse con:

- Nombre del evento.
- Modulo que lo origina.
- Motivo de negocio.
- Datos minimos.
- Modulos que lo consumen o consultan.
- Requisito relacionado.

## Regla de madurez

En esta etapa los eventos son conceptuales. Se convierten en eventos tecnicos solo cuando arquitectura lo apruebe y exista una decision documentada.
