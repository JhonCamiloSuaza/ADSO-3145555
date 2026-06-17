# Cross-cutting concerns

> Estado: 🔴 | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Arquitectura

## Propósito

Establecer los principios y estándares transversales que se aplican a toda la plataforma Horarios SENA: seguridad, observabilidad, resiliencia, calidad, datos y gobernanza.

## Seguridad

- Autenticación centralizada con SSO federado y tokens JWT.
- Autorización basada en roles y atributos para personal SENA, instructores, aprendices y sistemas integrados.
- Cifrado en tránsito (TLS 1.2/1.3) y en reposo para datos sensibles.
- Clasificación de la información: PII, datos sensibles y públicos.
- Revisión de dependencias y escaneo de vulnerabilidades por cada release.

## Observabilidad y auditoría

- Correlación de transacciones con `correlation-id` en todos los flujos.
- Registro centralizado de logs con retención ajustable para cumplimiento.
- Auditoría de acciones críticas: cambios de estado de formación, notificaciones, sincronización con sistemas oficiales.
- Métricas de salud: disponibilidad, latencia, errores y saturación.
- Trazabilidad distribuida para solicitudes transversales entre microservicios.

## Resiliencia y calidad de servicio

- Circuit breakers y retries con backoff exponencial.
- Timeouts estrictos en llamadas externas y definiciones de bulkhead en servicios críticos.
- Validación de contratos API antes de despliegue.
- Pruebas de carga y pruebas de humo en cada entorno.

## Datos y gestión de información

- Persistencia transaccional para operaciones de negocio.
- Persistencia de auditoría separada para trazabilidad.
- Consistencia eventual en patrones de event sourcing y mensajería.
- Estrategias de respaldo y restauración para datos de negocio y configuración.

## Gobernanza de documentación

- Cada cambio arquitectónico se formaliza en un ADR.
- La documentación técnica se mantiene en este repositorio como fuente de verdad.
- Las decisiones se revisan en cada iteración y se vinculan a los artefactos entregables.

## Equipos y responsabilidades

- Arquitectura: define principios, ADR, vistas y lineamientos.
- DevOps/Infraestructura: implementa despliegue, entornos y observabilidad.
- Seguridad: valida controles de acceso, cifrado y auditoría.
- QA: valida cumplimiento de calidad y pruebas de integración.

## Estándares de entrega

- Todos los servicios deben documentar contratos, eventos y operaciones.
- Las decisiones de seguridad y resiliencia se documentan aquí y en los ADRs.
- La visibilidad operativa se considera tan importante como las funciones del negocio.
