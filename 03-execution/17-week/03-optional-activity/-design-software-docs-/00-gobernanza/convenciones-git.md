# Convenciones de Git

> Estado: Definido | Ultima actualizacion: 2026-06-19
> Responsable documental: Gobernanza documental del proyecto Horarios SENA

Este documento define convenciones simples para trabajar la documentacion del proyecto. La prioridad es mantener trazabilidad visual, revision humana y nombres de ramas faciles de entender.

## Ramas oficiales

| Rama | Proposito documental | Regla |
|------|----------------------|-------|
| `dev` | Integracion inicial de documentacion revisada | Recibe cambios desde `architecture-documentation-dev` |
| `staging` | Validacion previa a QA | Recibe cambios desde `architecture-documentation-staging` |
| `qa` | Revision formal de calidad documental | Recibe cambios desde `architecture-documentation-qa` |
| `main` | Documentacion estable | Recibe cambios desde `architecture-documentation-main` |

No se trabaja directamente sobre estas ramas.

## Ramas de documentacion

| Rama documental | Rama padre | Uso |
|-----------------|------------|-----|
| `architecture-documentation-dev` | `dev` | Preparar cambios antes de integrarlos a `dev` |
| `architecture-documentation-staging` | `staging` | Preparar promocion hacia `staging` |
| `architecture-documentation-qa` | `qa` | Preparar promocion hacia `qa` |
| `architecture-documentation-main` | `main` | Preparar promocion hacia `main` |

Cada rama documental nace de su rama padre correspondiente. Esto permite que el arbol de Git muestre visualmente de donde viene cada promocion.

## Ramas temporales de trabajo

Las ramas temporales se usan para cambios puntuales de documentacion.

| Tipo | Uso | Ejemplo |
|------|-----|---------|
| `docs/` | Crear o ampliar documentos | `docs/02-dominio-modulos` |
| `fix/` | Corregir redaccion, enlaces o nombres | `fix/04-requisitos-enlace` |
| `chore/` | Mover o renombrar archivos documentales | `chore/renombrar-gobernanza` |

Estas ramas deben partir normalmente de `architecture-documentation-dev`.

## Flujo manual esperado

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

Cada paso requiere revision humana. No se usan promociones automaticas, pipelines ni GitHub Actions para mover cambios entre ramas.

## Commits

Formato recomendado:

```text
docs(<carpeta>): descripcion corta
```

Ejemplos:

```bash
docs(01-contexto): ampliar alcance documental
docs(02-dominio): definir modulos funcionales
fix(04-requisitos): corregir enlace de trazabilidad
chore(09-microservicios): renombrar plantilla de servicio
```

## Reglas

- Mantener commits pequenos y revisables.
- No mezclar cambios de muchas carpetas si pueden revisarse por separado.
- No subir credenciales, usuarios reales, correos, tokens ni secretos.
- No documentar integraciones reales o configuraciones avanzadas en esta fase.
- Registrar cambios amplios en `CHANGELOG.md` cuando afecten a varias carpetas.
