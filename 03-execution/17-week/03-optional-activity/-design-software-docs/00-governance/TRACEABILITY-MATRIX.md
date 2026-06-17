# Traceability Matrix

> Estado: 🟡 En progreso | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Gobernanza, QA

## Propósito

Establecer una matriz de trazabilidad que vincula requisitos SENA → documentación → arquitectura → servicios → implementación, asegurando que toda decisión documentada es justificable y rastreable.

## Estructura de trazabilidad

```
Requisito (REQ-XXX)
  ↓
Documento de contexto o requisito (01-context, 04-requirements)
  ↓
Decisión arquitectónica (ADR-XXX en 05-architecture)
  ↓
Servicio o componente (09-microservices)
  ↓
Contrato API / Evento (07-api, 06-data)
  ↓
Artefacto de implementación (repo de código, PR)
```

## Matriz de mapeo de requisitos SENA

| Requisito | Descripción | Tipo | Documento de origen | ADR asociada | Servicio(s) | Estado |
|-----------|-------------|------|---------------------|--------------|-------------|--------|
| REQ-001 | Gestión de trazabilidad de formación | Funcional | 04-requirements/functional.md | ADR-XXX | trazabilidad-formacion-api | 🔴 |
| REQ-002 | Seguimiento de proyectos formativos | Funcional | 04-requirements/functional.md | ADR-XXX | trazabilidad-formacion-api | 🔴 |
| REQ-003 | Notificaciones de estado de formación | Funcional | 04-requirements/functional.md | ADR-XXX | notification-service | 🔴 |
| REQ-004 | Coordinación de horarios por jornada | Funcional | 04-requirements/functional.md | ADR-XXX | programa-formacion-api | 🔴 |
| REQ-005 | Integración con SOFIA Plus / BETOWA | Funcional | 04-requirements/functional.md | ADR-XXX | integracion-sena-api | 🔴 |
| REQ-006 | Auditoría de cambios en datos SENA | Funcional | 04-requirements/functional.md | ADR-XXX | auditoria-api | 🔴 |
| REQ-NF-001 | Disponibilidad 99.5% en horario nacional | No funcional | 04-requirements/non-functional.md | ADR-XXX | deployment.md | 🔴 |
| REQ-NF-002 | Latencia máxima 200ms en consultas | No funcional | 04-requirements/non-functional.md | ADR-XXX | cross-cutting.md | 🔴 |
| REQ-SEC-001 | Autenticación SSO federada SENA | Seguridad | SECURITY-GOVERNANCE.md | ADR-XXX | integracion-sena-api | 🔴 |
| REQ-SEC-002 | Cifrado TLS en tránsito | Seguridad | SECURITY-GOVERNANCE.md | ADR-XXX | deployment.md | 🔴 |

## Mapeo de decisiones arquitectónicas (ADRs)

| ADR | Título | Requisito(s) | Sección | Servicios afectados | Status |
|-----|--------|--------------|---------|---------------------|--------|
| ADR-001 | Branching Model for Documentation | REQ-GOV-001 | 00-governance | N/A | ✅ ACEPTADA |
| ADR-002 | Domain-Driven Design para SENA | REQ-001, REQ-002 | 02-domain | Todos | 🔴 PENDING |
| ADR-003 | Event-Driven Communication | REQ-002, REQ-003 | 09-microservices | Todos | 🔴 PENDING |
| ADR-004 | Integration Layer Isolation | REQ-005 | 05-architecture | integracion-sena-api | 🔴 PENDING |
| ADR-005 | Security and Compliance SENA | REQ-SEC-001, REQ-SEC-002 | SECURITY-GOVERNANCE | Todos | 🔴 PENDING |

## Validación de trazabilidad

Para que un documento sea considerado "traceable":

1. **Requisito documentado**: el cambio debe vincularse a al menos 1 requisito en `04-requirements/`.
2. **Decisión registrada**: si implica arquitectura, debe tener un ADR en `05-architecture/decisions/`.
3. **Servicio/componente claro**: debe indicar qué servicio(s) en `09-microservices/` implementan la funcionalidad.
4. **Contrato especificado**: debe detallar API, eventos o persistencia en `07-api/` o `06-data/`.
5. **Trazabilidad bidirecional**: el requisito debe poder ser consultado desde la arquitectura y viceversa.

## Ejemplo de trazabilidad completa

**Requisito SENA (REQ-003):**
> Notificaciones de estado de formación deben entregarse en máximo 5 minutos desde el cambio de estado.

**Documento en `04-requirements/functional.md`:**
```markdown
## REQ-003: Notificaciones de estado de formación

Descripción: El sistema debe notificar a aprendices e instructores cuando el estado de un proyecto formativo cambia.

- Actor: Sistema, Aprendiz, Instructor
- Triggers: Cambio de estado en trazabilidad-formacion-api
- Delivery: máximo 5 minutos
- Canales: email, SMS, push notification
- Trazabilidad: ADR-XXX, notification-service
```

**ADR en `05-architecture/decisions/records/ADR-XXX.md`:**
```markdown
# ADR-XXX: Event-Based Notifications

## Decisión
Usar un bus de eventos para desacoplar la lógica de cambio de estado de la entrega de notificaciones.

## Justificación
- Requisito: REQ-003 exige máximo 5 minutos de latencia.
- Patrón: Event-driven architecture reduce latencia vs polling.
- Beneficio: escalabilidad y resiliencia.

## Implementación
- Servicio: notification-service
- Evento: `FormationStateChanged`
- Topología: ver 09-microservices/communication-patterns.md
```

**Servicio en `09-microservices/service-catalog.md`:**
```markdown
| notification-service | Notificaciones... | notification-service | repo/notification-service | 🔴 |
```

**Contrato en `07-api/contracts/notification-service.md`:**
```markdown
# notification-service API

## Events

### FormationStateChanged (consumed)
- Source: trazabilidad-formacion-api
- Schema: {...}
- Handling: trigger notification delivery
- SLA: 5 minutes

## REQ-003 Mapping
Implementa envío de notificaciones según REQ-003.
```

## Checklist de trazabilidad para PRs

Antes de abrir un PR, verificar:

- [ ] ¿Existe un requisito asociado? (SÍ → vincular; NO → justificar)
- [ ] ¿Hay una ADR si es decisión de arquitectura? (SÍ → linkear; NO → crear)
- [ ] ¿Se identifica el servicio o componente afectado?
- [ ] ¿Se documenta el contrato API o evento?
- [ ] ¿Se actualiza esta matriz si aplica?
- [ ] ¿La trazabilidad es bidireccional?

## Auditoría de trazabilidad

Cada trimestre se ejecuta:

```bash
# Verificar que todo requisito en 04-requirements tiene ADR
# Verificar que todo ADR tiene servicio en 09-microservices
# Verificar que todo servicio tiene contrato en 07-api
# Generar reporte de gaps
```

## Referencias

- [`04-requirements/functional.md`](../04-requirements/functional.md)
- [`04-requirements/non-functional.md`](../04-requirements/non-functional.md)
- [`05-architecture/decisions/`](../05-architecture/decisions/)
- [`09-microservices/service-catalog.md`](../09-microservices/service-catalog.md)
- [`07-api/contracts/`](../07-api/contracts/)

Versión: v1.0 — 2026-06-17
