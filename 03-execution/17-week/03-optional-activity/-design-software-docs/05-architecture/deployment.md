# Deployment architecture

> Estado: 🔴 | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Infraestructura

## Propósito

Definir la topología de despliegue y los ambientes operacionales para la plataforma Horarios SENA. Este documento describe la infraestructura y los patrones necesarios para soportar la arquitectura a escala nacional.

## Ambientes

- `local` — entorno de desarrollo de los equipos.
- `dev` — integración continua de documentación y prototipos.
- `staging` — validación en un entorno cercano a producción.
- `qa` — pruebas funcionales, de seguridad y de aceptación.
- `main` / `prod` — documentación estable de arquitectura y despliegue.

> En el contexto de SENA, `main` representa la versión consensuada y aprobada de la arquitectura documentada.

## Componentes de infraestructura

- API Gateway / Ingress: punto de entrada de las interfaces REST/gRPC y control de seguridad perimetral.
- Servicio de Identity / AuthN: gestión de autenticación y autorización federada con SENA.
- Servicio de integración SENA: capa de mediación que aísla sistemas externos y fuentes de datos oficiales.
- Event Mesh / Broker: bus de eventos para comunicaciones asíncronas entre servicios.
- Bases de datos: almacenes transaccionales y de auditoría con cifrado en reposo.
- Observabilidad: stack de logging, métricas y trazas distribuidas.
- Backups y recuperación: estrategias para datos críticos y configuraciones de infraestructura.

## Modelo de red y seguridad

- Zona pública controlada: API Gateway expone únicamente los endpoints autorizados y protege la entrada.
- Zona privada interna: servicios backend y brokers operan en segmentos de red aislados.
- Segmentación por confianza: cada servicio crítico de SENA debe ejecutarse en un entorno con políticas de acceso restringido.
- Conexión con sistemas oficiales: canales seguros y auditados hacia SOFIA Plus, BETOWA y puntos de integración externos.

## Entregables de despliegue

- Diagrama de red y topología de despliegue.
- Matriz de ambientes y controles asociados.
- Catálogo de servicios de infraestructura.
- Guía de configuración de entornos para los equipos de DevOps.

## Requisitos operacionales

- Disponibilidad: diseño para tolerar fallas parciales y reintentos.
- Escalabilidad: capacidad de crecimiento regional sin afectar la consistencia documental.
- Seguridad: cifrado TLS, autenticación federada y control de acceso granular.
- Observabilidad: métricas de servicio, correlación de transacciones y alertas definidas.

## Notas de arquitectura

Para el proyecto SENA, se propone usar una arquitectura de tipo microservicios con foco en eventos y APIs, donde los servicios de integración se convierten en el borde de aislamiento para las fuentes oficiales.
