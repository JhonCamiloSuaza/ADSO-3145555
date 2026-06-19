# Gobierno documental

Esta carpeta contiene las reglas minimas para mantener el repositorio ordenado, trazable y entendible. Su enfoque es documental: no define usuarios reales, permisos reales, credenciales ni automatizaciones obligatorias.

## Documentos canonicos

| Documento | Para que sirve | Estado |
|-----------|----------------|--------|
| [diagnostico-documental.md](./diagnostico-documental.md) | Diagnostico de estructura, simplificacion y documentos faltantes | En progreso |
| [reglas-documentacion.md](./reglas-documentacion.md) | Reglas para nombrar, crear, enlazar y mantener documentos | Estable |
| [estrategia-ramas.md](./estrategia-ramas.md) | Flujo manual de ramas y promocion documental | Estable |
| [convenciones-git.md](./convenciones-git.md) | Convenciones de ramas, commits y PRs | Estable |
| [definicion-listo.md](./definicion-listo.md) | Criterios para que un documento pueda revisarse | Estable |
| [definicion-terminado.md](./definicion-terminado.md) | Criterios para cerrar un documento como estable | Estable |
| [documentacion-microservicios.md](./documentacion-microservicios.md) | Reglas para documentar servicios sin inventar implementaciones | Estable |

## Documentos de apoyo

| Documento | Uso recomendado | Nota |
|-----------|-----------------|------|
| [reglas-seguridad.md](./reglas-seguridad.md) | Reglas practicas para no filtrar informacion sensible | Mantener simple |
| [matriz-revision.md](./matriz-revision.md) | Guia conceptual de revision documental | No agregar personas reales |
| [reglas-trazabilidad.md](./reglas-trazabilidad.md) | Regla de trazabilidad documental | La matriz canonica esta en `04-requisitos/matriz-trazabilidad.md` |
| [gobierno-seguridad.md](./gobierno-seguridad.md) | Referencia amplia de seguridad documental | Fusionar con `reglas-seguridad.md` si se vuelve repetitivo |

## Criterio de simplificacion

Un documento se conserva si cumple al menos una condicion:

- Ayuda a decidir donde documentar algo.
- Evita duplicidad o perdida de trazabilidad.
- Explica un flujo de trabajo que el equipo debe seguir.
- Sirve como plantilla reutilizable.
- Aporta contexto necesario para requisitos, arquitectura, APIs o microservicios.

Un documento debe fusionarse o archivarse si repite reglas ya definidas, usa nombres confusos, exige procesos que el equipo no va a ejecutar o describe implementacion que aun no existe.

## Promocion manual

El flujo aprobado conserva estas ramas:

- `architecture-documentation-dev` hacia `dev`
- `architecture-documentation-staging` hacia `staging`
- `architecture-documentation-qa` hacia `qa`
- `architecture-documentation-main` hacia `main`

Cada promocion se hace mediante revision manual y PR visible. No se requieren GitHub Actions ni procesos ocultos para mover documentacion.
