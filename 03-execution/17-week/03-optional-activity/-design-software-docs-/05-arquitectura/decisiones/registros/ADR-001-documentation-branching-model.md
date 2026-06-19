# ADR-001 - Modelo de ramas para promocion documental

## Estado

Aceptada

## Fecha

2026-06-19

## Contexto

El repositorio documenta la arquitectura del proyecto Horarios SENA. En fase 1, el objetivo es mantener gobernanza, trazabilidad y revision humana sin automatizaciones ni procesos operativos de produccion.

El equipo necesita conservar las ramas oficiales:

- `dev`
- `staging`
- `qa`
- `main`

Y las ramas documentales:

- `architecture-documentation-dev`
- `architecture-documentation-staging`
- `architecture-documentation-qa`
- `architecture-documentation-main`

## Decision

Se adopta un flujo manual de promocion documental. Cada rama documental nace de su rama padre correspondiente:

| Rama documental | Rama padre |
|-----------------|------------|
| `architecture-documentation-dev` | `dev` |
| `architecture-documentation-staging` | `staging` |
| `architecture-documentation-qa` | `qa` |
| `architecture-documentation-main` | `main` |

El flujo conceptual queda asi:

```text
architecture-documentation-dev
        ->
       dev
        ->
architecture-documentation-staging
        ->
     staging
        ->
architecture-documentation-qa
        ->
        qa
        ->
architecture-documentation-main
        ->
       main
```

Cada promocion debe revisarse y aprobarse manualmente.

## Consecuencias positivas

- El arbol de Git permite ver la trazabilidad documental.
- Cada ambiente documental tiene una rama de control.
- La revision humana queda como parte obligatoria del flujo.
- No se depende de automatizaciones para mover documentacion.

## Riesgos controlados

| Riesgo | Control |
|--------|---------|
| Cambios directos en ramas oficiales | No trabajar directamente sobre `dev`, `staging`, `qa` o `main` |
| Ramas documentales desactualizadas | Revisar cada promocion manualmente |
| Confusion sobre el origen de una rama | Documentar que cada rama `architecture-documentation-*` nace de su rama padre |

## Alternativas consideradas

| Alternativa | Motivo para descartarla |
|-------------|-------------------------|
| Usar solo ramas oficiales | No muestra claramente la etapa documental intermedia |
| Usar solo ramas temporales de trabajo | No deja una trazabilidad visual suficiente entre ambientes |
| Automatizar promociones | No corresponde a fase 1 y oculta parte del flujo documental |

## Documentos relacionados

- `00-gobernanza/estrategia-ramas.md`
- `00-gobernanza/convenciones-git.md`
- `10-ambientes-publicacion/flujo-publicacion.md`
