# Ambientes documentales

Este documento define el significado de las ramas usadas como ambientes documentales.

| Ambiente | Rama | Uso |
|----------|------|-----|
| Desarrollo | `dev` | Integrar documentacion revisada inicialmente |
| Staging | `staging` | Validar consistencia antes de QA |
| QA | `qa` | Revisar calidad documental y trazabilidad |
| Publicado | `main` | Mantener documentacion estable |

## Ramas de control

| Rama de control | Promueve hacia |
|-----------------|---------------|
| `architecture-documentation-dev` | `dev` |
| `architecture-documentation-staging` | `staging` |
| `architecture-documentation-qa` | `qa` |
| `architecture-documentation-main` | `main` |

## Regla

Cada ambiente representa un estado de la documentacion, no una infraestructura real de software.
