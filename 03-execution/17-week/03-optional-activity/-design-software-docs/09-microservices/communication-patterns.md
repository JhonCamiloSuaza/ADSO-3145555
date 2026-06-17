# Communication patterns

> Estado: 🔴 | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Arquitectura

Este documento define los patrones de comunicación preferidos para la arquitectura de Horarios SENA, equilibrando integridad de negocio, rendimiento y resiliencia.

## Síncrona (REST / gRPC)

- Los APIs de borde deben definirse con contratos OpenAPI.
- Se recomienda REST para integraciones externas y gRPC para comunicación de bajo latencia entre servicios internos.
- Cada API debe incluir versiones claras y un esquema de descomisión controlada.
- Las APIs de consulta deben ser idempotentes y estar orientadas a recursos del dominio.

## Asíncrona (eventos)

- Los servicios publican eventos de dominio para cambios relevantes (ej. `InscripcionActualizada`, `HorarioAsignado`, `NotificacionEmitida`).
- Se usa un bus de eventos para desacoplar productores y consumidores y mejorar la escalabilidad.
- Los eventos se diseñan para ser auto-descriptivos y versionables.
- La integración con sistemas oficiales también debe soportar eventos de sincronización y confirmación.

## Resiliencia

- Circuit breaker: proteger los servicios frente a fallas repetidas de dependencias.
- Retry: aplicar reintentos con backoff exponencial en llamadas temporales.
- Timeout: definir límites de tiempo claros en cada llamada remota.
- Bulkhead: aislar recursos por dominio para evitar propagación de fallas.
- Backpressure: el bus de eventos y los gateways deben soportar control de carga para evitar saturación.

## Patrones adicionales

- Saga de compensación para operaciones distribuidas de larga duración.
- API Gateway como punto único de entrada y validación de seguridad.
- Anti-corruption layer para aislar la lógica de integración con sistemas externos.
- Observabilidad integrada: todos los patrones deben incluir metadata de trazabilidad y métricas.
