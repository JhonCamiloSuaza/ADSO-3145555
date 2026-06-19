# Guia de trazabilidad documental

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este archivo explica la regla de trazabilidad desde gobierno documental. La matriz canonica vive en:

[04-requisitos/matriz-trazabilidad.md](../04-requisitos/matriz-trazabilidad.md)

## Flujo de trazabilidad

```text
Requisito
  -> Modulo de dominio
  -> Servicio propuesto o componente
  -> API, evento o dato afectado
  -> Documento tecnico relacionado
  -> Decision ADR si aplica
```

## Regla

No mantener matrices paralelas. Si cambia un requisito, modulo, servicio, API o evento, actualizar la matriz canonica en `04-requisitos/matriz-trazabilidad.md`.

## Revision manual

Antes de promover un cambio documental, validar:

- El requisito tiene ID.
- El modulo funcional esta identificado.
- El servicio propuesto esta alineado con `09-microservicios/catalogo-servicios.md`.
- La dependencia o evento esta documentado cuando aplica.
- No se agregaron datos sensibles, correos, usuarios reales ni credenciales.
