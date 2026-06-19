# Patrones de comunicacion

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este documento define como deben comunicarse los modulos o servicios cuando el proyecto evolucione. En la etapa actual se mantiene una vision simple: limites claros, dependencias visibles y contratos documentados.

## Principios

- Preferir comunicacion simple mientras no exista una necesidad real de distribucion.
- Documentar toda dependencia entre servicios en [mapa-dependencias.md](./mapa-dependencias.md).
- No duplicar reglas de negocio entre servicios.
- Mantener trazabilidad desde requisitos hacia APIs, eventos y datos.

## Comunicacion sincronica

Usar llamadas sincronicas cuando:

- El usuario necesita una respuesta inmediata.
- La operacion es de consulta.
- La dependencia es estable y facil de observar.

Ejemplos:

- Consultar catalogos institucionales desde `reference-data-service`.
- Validar disponibilidad de ambientes desde `training-environment-service`.
- Consultar actores academicos desde `actors-service`.

## Comunicacion asincronica

Usar eventos cuando:

- Un cambio debe notificar a varios modulos.
- La respuesta no necesita ser inmediata.
- Se quiere reducir acoplamiento entre capacidades.

Ejemplos:

- `ScheduleAssigned`
- `TrainingProjectUpdated`
- `EnvironmentAvailabilityChanged`
- `NotificationRequested`

Los eventos candidatos se registran en [catalogo-eventos.md](./catalogo-eventos.md).

## Regla para este proyecto

Mientras no exista implementacion distribuida, los eventos pueden documentarse como eventos de dominio internos. No se debe asumir bus de eventos, colas o tecnologia especifica hasta que exista una decision arquitectonica.
