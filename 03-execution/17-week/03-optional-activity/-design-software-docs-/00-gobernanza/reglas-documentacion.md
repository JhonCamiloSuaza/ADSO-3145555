# Reglas de documentación

> Estado: 🟢 Estable | Última actualización: 2026-06-17
> Autor: Equipo de Gobernanza

Este documento define las reglas generales para crear, nombrar, enlazar y mantener documentos. Para ramas y commits, ver [convenciones-git.md](./convenciones-git.md). Para seguridad, ver [reglas-seguridad.md](./reglas-seguridad.md).

## Naming

### Archivos

- Usar `kebab-case.md`.
- Usar nombres descriptivos: `modelo-datos.md`, `contrato-api.md`, `estrategia-migracion.md`.
- No usar espacios, `snake_case`, `PascalCase` ni nombres genéricos como `documento1.md`.

### Carpetas

- Las carpetas raíz usan prefijo numérico: `NN-nombre`.
- No crear carpetas raíz nuevas sin aprobación de arquitectura.
- Toda carpeta nueva debe tener `README.md`.

### ADRs

- Formato: `ADR-NNN-titulo-corto.md`.
- Los ADRs viven en `05-arquitectura/decisiones/registros/`.
- Ver proceso completo en [05-arquitectura/decisiones/README.md](../05-arquitectura/decisiones/README.md).

## Estructura mínima

Todo documento `.md` debe iniciar con:

```markdown
# Título descriptivo

> Estado: 🔴 Pendiente | Última actualización: YYYY-MM-DD
> Autor: Nombre Apellido | Equipo: <nombre del equipo>

## Contexto

## Contenido

## Referencias
```

## Estados

| Estado | Uso |
|--------|-----|
| 🔴 Pendiente | Archivo creado, sin contenido validado |
| 🟡 En progreso | Contenido parcial o en revisión |
| 🟢 Estable | Revisado, aprobado y vigente |
| ⚫ Deprecado | Ya no aplica. Ver criterio de acción abajo. |

**Criterio para documentos deprecados:**

| Situación | Acción |
|-----------|--------|
| Documento sustituido por otro | Cambiar estado a ⚫, agregar `> Reemplazado por: [enlace al nuevo]` al inicio, dejar en su ubicación actual |
| Documento de sección eliminada o reestructurada | Mover a `99-archivo/deprecated/`, registrar el movimiento en `CHANGELOG.md` |
| ADR obsoleta | Nunca mover — cambiar estado a `DEPRECATED` en `registros/` y agregar `> Reemplazada por: ADR-NNN-nueva.md` |

Un documento pasa a 🟢 solo después de revisión por una persona distinta al autor.

## Índices obligatorios

- Todo archivo nuevo debe enlazarse desde el `README.md` de su carpeta.
- Toda carpeta nueva debe tener `README.md`.
- Los documentos movidos deben conservar trazabilidad mediante enlace o nota en `CHANGELOG.md`.
- Los ADRs se registran en `05-arquitectura/decisiones/README.md`.
- Los microservicios se registran en `09-microservicios/catalogo-servicios.md`.

## Documentos y carpetas

### Documento nuevo

1. Verificar que no exista en otra sección.
2. Crear el archivo en la sección correcta.
3. Usar la estructura mínima.
4. Enlazarlo desde el `README.md` de la sección.
5. Abrir PR con checklist completo.

### Carpeta nueva

Crear una subcarpeta solo cuando:

- Agrupa varios documentos del mismo subtema.
- Tiene ciclo de vida propio.
- Facilita navegación frecuente para varios equipos.

No crear carpetas `misc/`, `otros/`, `temp/` ni carpetas con un solo documento.

## Diagramas y recursos visuales

| Tipo de recurso | Dónde va |
|----------------|----------|
| Fuentes UML `.wsd` / `.puml` | `08-uml/diagrams/source/` |
| Exportaciones UML `.svg` / `.png` | `08-uml/diagrams/exports/` |
| Logos | `recursos/logos/` |
| Capturas, mockups o imágenes no UML | `recursos/images/` |
| Diagramas UML referenciados por arquitectura | Fuente y export en `08-uml/`, enlace desde `05-arquitectura/` |

Reglas:

- Todo diagrama debe tener fuente editable.
- SVG es preferido sobre PNG.
- No subir solo la imagen exportada si existe fuente editable.
- Registrar diagramas en `08-uml/indice-diagramas.md`.

## Errores comunes

| Error | Consecuencia | Solución |
|-------|-------------|----------|
| Crear archivo sin registrarlo en el índice | Documento invisible | Enlazar en el `README.md` de la sección |
| Subir solo una exportación de diagrama | No se puede editar después | Subir fuente + exportación |
| Duplicar contenido entre secciones | Pérdida de fuente de verdad | Enlazar al documento canónico |
| Crear carpeta genérica | Navegación confusa | Usar nombres descriptivos |
| Eliminar historia documental | Pérdida de trazabilidad | Deprecar o archivar |

## Revisión

Para saber si un documento está listo para PR, usar [definicion-listo.md](./definicion-listo.md). Para cierre, usar [definicion-terminado.md](./definicion-terminado.md).
