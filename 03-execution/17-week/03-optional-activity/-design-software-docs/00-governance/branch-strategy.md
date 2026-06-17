# Estrategia de ramas para documentación de arquitectura

> Estado: 🟡 En progreso | Última actualización: 2026-06-17
> Autor: Arquitectura de documentación | Equipo: Arquitectura / QA

## Propósito

Definir una estrategia de ramas para la documentación técnica y de arquitectura, garantizando que la estructura inicial que subamos responda a los estándares de SENA Nacional.

Este documento formaliza un flujo visible y rastreable para la promoción manual de la documentación de arquitectura con ciclo de vida claro de ramas y ambientes.

## Alcance

- Este flujo aplica al repositorio documental `design-software-docs`.
- Se utiliza para la documentación de arquitectura, requisitos, diagramas, servicios, QA y operaciones.
- No es un flujo de código fuente de producto; es un flujo de documentación con ramas de promoción manual.

## Jerarquía de ramas

### Ramas padre

- `dev` — entorno de desarrollo e integración de documentación.
- `staging` — entorno de validación previa a QA.
- `qa` — entorno de validación formal y preparación para publicación.
- `main` — documentación estable publicada.

### Ramas hijas de documentación

- `architecture-documentation-dev`
- `architecture-documentation-staging`
- `architecture-documentation-qa`
- `architecture-documentation-main`

Estas ramas hijas son ramas de control intermedias usadas para promover contenido entre ambientes. Cada una se crea desde su rama padre correspondiente y sirve como punto de revisión antes del merge al ambiente final.

## Flujo de promoción manual

El flujo obligatorio es el siguiente:

1. Crear una rama de trabajo a partir de `dev`, por ejemplo `docs/architecture-09-microservices`.
2. Llevar los cambios a `architecture-documentation-dev` y abrir PR de `docs/architecture-...` hacia `architecture-documentation-dev`.
3. Revisar y mergear `architecture-documentation-dev` → `dev`.
4. Crear `architecture-documentation-staging` desde `staging`.
5. Integrar los cambios de `dev` en `architecture-documentation-staging` (merge o cherry-pick según política).
6. Abrir PR de `architecture-documentation-staging` hacia `staging`.
7. Revisar y mergear `architecture-documentation-staging` → `staging`.
8. Crear `architecture-documentation-qa` desde `qa`.
9. Integrar los cambios de `staging` en `architecture-documentation-qa`.
10. Abrir PR de `architecture-documentation-qa` hacia `qa`.
11. Revisar y mergear `architecture-documentation-qa` → `qa`.
12. Crear `architecture-documentation-main` desde `main`.
13. Integrar los cambios de `qa` en `architecture-documentation-main`.
14. Abrir PR de `architecture-documentation-main` hacia `main`.
15. Revisar y mergear `architecture-documentation-main` → `main`.

> Cada PR debe indicar claramente el paso de la promoción y vincularse con el documento o conjunto de documentos que avanza.

> Cada PR debe indicar claramente el paso de la promoción y vincularse con el documento o conjunto de documentos que avanza.

## Reglas de uso

- No se debe trabajar directamente sobre `dev`, `staging`, `qa` ni `main`.
- Las ramas hijas se crean siempre desde su rama padre correspondiente.
- Las ramas `architecture-documentation-*` son permanentes y existe una por cada ambiente.
- El contenido se desarrolla en ramas de trabajo temporales (`docs/*`, `fix/*`) que se eliminan después de mergear.
- Los commits deben usar Conventional Commits y la convención del repositorio.
- Cada documento nuevo debe enlazarse desde el `README.md` de su sección en la rama destino.

## Ciclo de vida de ramas

### Ramas temporales (de trabajo)

Formato: `docs/NN-section-description` o `fix/doc-issue-description`

```
Origen: architecture-documentation-dev
  ↓
  Desarrollo local
  ↓
Merge en: architecture-documentation-dev
  ↓
Eliminar: se borra después de merge (cleanup automático)
```

Vida útil: 1-2 semanas mientras se desarrolla el contenido.

### Ramas permanentes (control)

Formato: `architecture-documentation-<env>`

```
Origen: rama padre correspondiente (dev, staging, qa, main)
  ↓
Propuesta: reciben PRs desde ramas temporales
  ↓
Revisión: validación por revisor designado
  ↓
Merge: hacia su rama padre
  ↓
Estado: permanente, nunca se elimina
```

Vida útil: indefinida. Existín una por ambiente.

### Ramas de ambiente padre

Formato: `dev`, `staging`, `qa`, `main`

```
Origen: rama-documentation-<env> (merge)
  ↓
Desarrollo: no se trabaja directamente
  ↓
Merge siguiente: solo desde su rama-documentation asociada
  ↓
Estado: protegida, solo merge de PRs revisados
  ↓
Visibilidad: rama "oficial" del ambiente
```

Vida útil: indefinida, refleja el estado documentado del ambiente.

## Ejemplo de flujo completo

1. `git checkout dev`
2. `git pull origin dev`
3. `git checkout -b docs/architecture-09-microservices`
4. Actualizar documentos en `09-microservices/`
5. `git commit -m "docs(09-microservices): add service catalog and event catalog"`
6. `git push origin docs/architecture-09-microservices`
7. Crear PR hacia `architecture-documentation-dev`.
8. Cuando la rama hija está aprobada, mergear `docs/architecture-09-microservices` en `architecture-documentation-dev`.
9. Crear PR de `architecture-documentation-dev` hacia `dev`.
10. Revisar y mergear.
11. Repetir promoción hacia `architecture-documentation-staging`, `architecture-documentation-qa` y `architecture-documentation-main`.

## Esquema visual del árbol

```
Ramas temporales           Ramas de control           Ramas padre
(se eliminan)             (permanentes)              (permanentes)

  docs/feature
      |
      +---> architecture-documentation-dev ----> dev (rama oficial)
            (revisión, control)                   (ambiente)
      
      +---> architecture-documentation-staging -> staging (rama oficial)
            (validación previa)                   (ambiente)
      
      +---> architecture-documentation-qa -----> qa (rama oficial)
            (comprobación formal)                (ambiente)
      
      +---> architecture-documentation-main ---> main (rama oficial)
            (aprobación final)                  (ambiente productión)
```

Cada columna representa un nivel de promoción. Las ramas temporales (izq) viven semanas; las de control (centro) y padre (dcha) son permanentes.

## Buenas prácticas

- Mantener los cambios de cada paso pequeños y revisables.
- Usar PRs con descripción clara del alcance, sección afectada y contexto.
- No mezclar cambios de arquitectura con cambios de formato o styling en el mismo PR.
- Registrar los documentos nuevos en el `README.md` de la sección destino antes del merge.

## Estrategia alternativa recomendada

Este modelo es válido si el objetivo es hacer visible el árbol de ramas. Sin embargo, para una arquitectura documental moderna y menos compleja, se recomienda considerar un modelo basado en:

- `main` — documentación estable
- `dev` — integración de documentación
- `qa` — validación
- `staging` — prepublicación
- `docs/<feature>` — ramas de trabajo

Si el jefe requiere un árbol de ramas explícito, mantener las ramas `architecture-documentation-*` como ramas de control adicionales.

## References

- [CONTRIBUTING.md](../CONTRIBUTING.md)
- [APPROVAL-MATRIX.md](./APPROVAL-MATRIX.md)
- [TRACEABILITY-MATRIX.md](./TRACEABILITY-MATRIX.md)
- [SECURITY-GOVERNANCE.md](./SECURITY-GOVERNANCE.md)
- [00-governance/git-conventions.md](./git-conventions.md)
- [05-architecture/decisions/records/ADR-001-documentation-branching-model.md](../05-architecture/decisions/records/ADR-001-documentation-branching-model.md)
