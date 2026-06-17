# ADR-001: Branching model for documentation promotion

> Estado: PROPOSED
> Fecha: 2026-06-17
> Autores: Arquitectura de documentación
> Equipos involucrados: Arquitectura, QA, Documentación

## Contexto

Este repositorio documental soportará la arquitectura de software y la documentación técnica del proyecto SENA. El equipo requiere una estrategia de ramas que sea visible, revisable y que permita evidenciar el ciclo de promoción entre ambientes.

El modelo solicitado incluye ramas padre tradicionales (`dev`, `staging`, `qa`, `main`) y ramas hijas específicas de documentación (`architecture-documentation-dev`, `architecture-documentation-staging`, `architecture-documentation-qa`, `architecture-documentation-main`).

## Decisión

Se adopta el siguiente modelo de ramas para la promoción manual de documentación:

- `dev` — integración de contenido en desarrollo
- `staging` — validación previa a QA
- `qa` — validación formal
- `main` — documentación estable
- `architecture-documentation-dev` — preparación intermedia antes de merge a `dev`
- `architecture-documentation-staging` — preparación intermedia antes de merge a `staging`
- `architecture-documentation-qa` — preparación intermedia antes de merge a `qa`
- `architecture-documentation-main` — preparación intermedia antes de merge a `main`

Cada paso de promoción se hace mediante Pull Request. Las ramas hijas no contienen contenido final hasta que se mergean a la rama padre correspondiente.

## Consecuencias

### Positivas

- Trazabilidad explícita del ciclo de promoción documental.
- Evidencia clara de la existencia de ramas hijas específicas de documentación.
- Control manual reforzado entre cada ambiente.

### Negativas / Trade-offs

- Mayor complejidad operativa en comparación con un flujo documental estándar.
- Necesidad de disciplina estricta en PRs y merges.
- Posible trabajo adicional al mantener ramas hijas sincronizadas con padres.

### Riesgos

- Si el flujo no se sigue exactamente, las ramas pueden divergir y generar confusión.
- Si se mergea contenido directo en una rama padre, se pierde la evidencia del flujo.
- Las ramas hijas pueden volverse obsoletas si no se limpian o mantienen.

## Alternativas consideradas

| Alternativa | Por qué se descartó |
|-------------|---------------------|
| Usar solo `dev`, `qa`, `staging`, `main` con ramas de trabajo `docs/*` | Es más simple, pero no cumple con la exigencia de mostrar ramas hijas específicas de documentación. |
| Usar `architecture/dev`, `architecture/staging`, `architecture/qa`, `architecture/main` | Es una alternativa más ordenada, pero el equipo solicitó nombres explícitos `architecture-documentation-*`. |
| Usar solo `release/*` y `hotfix/*` para documentación | No es adecuado para la promoción incremental entre ambientes. |

## Referencias

- `00-governance/branch-strategy.md`
- `00-governance/git-conventions.md`
- `05-architecture/decisions/README.md`
