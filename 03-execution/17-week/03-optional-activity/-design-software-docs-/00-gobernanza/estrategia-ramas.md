# Estrategia de ramas y promocion manual

> Estado: Definido | Ultima actualizacion: 2026-06-19
> Alcance: repositorio documental del proyecto Horarios SENA

## Proposito

Definir como se revisan y promueven cambios de documentacion entre ramas. El objetivo es conservar trazabilidad visual en Git Graph y asegurar que cada promocion tenga revision humana.

Este flujo aplica a contexto, dominio, requisitos, arquitectura, datos, APIs, microservicios, diagramas, manuales, riesgos y control de proyecto.

## Ramas oficiales

| Rama | Uso |
|------|-----|
| `dev` | Integracion inicial de documentacion revisada |
| `staging` | Validacion previa a QA |
| `qa` | Revision formal de calidad documental |
| `main` | Documentacion estable |

## Ramas documentales

| Rama documental | Nace de | Se promueve hacia |
|-----------------|---------|------------------|
| `architecture-documentation-dev` | `dev` | `dev` |
| `architecture-documentation-staging` | `staging` | `staging` |
| `architecture-documentation-qa` | `qa` | `qa` |
| `architecture-documentation-main` | `main` | `main` |

Las ramas documentales son ramas de control. No reemplazan la revision humana; la hacen visible.

## Flujo conceptual

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

## Flujo manual obligatorio

1. Crear una rama de trabajo desde `architecture-documentation-dev`.
2. Redactar o ajustar la documentacion.
3. Revisar nombres, enlaces, trazabilidad y seguridad documental.
4. Integrar el cambio en `architecture-documentation-dev`.
5. Revisar manualmente y aprobar.
6. Promover manualmente hacia `dev`.
7. Preparar la promocion hacia `architecture-documentation-staging`.
8. Revisar manualmente y promover hacia `staging`.
9. Preparar la promocion hacia `architecture-documentation-qa`.
10. Revisar manualmente y promover hacia `qa`.
11. Preparar la promocion hacia `architecture-documentation-main`.
12. Revisar manualmente y promover hacia `main`.

## Que debe validarse en cada promocion

- El cambio tiene proposito claro.
- Los documentos nuevos estan enlazados desde su README.
- La matriz de trazabilidad se actualizo si aplica.
- No hay credenciales, correos, usuarios reales, tokens ni secretos.
- No se agregaron automatizaciones, pipelines ni GitHub Actions para mover documentacion.
- La redaccion es entendible para el equipo SENA.

## Reglas

- No trabajar directamente sobre `dev`, `staging`, `qa` o `main`.
- No usar promociones automaticas.
- No usar GitHub Actions para mover cambios documentales.
- No crear procesos ocultos.
- No crear usuarios, permisos, credenciales ni integraciones ficticias.

## Trazabilidad

Cada cambio debe poder responder:

- Que documento cambio.
- Por que cambio.
- Que carpeta o modulo afecta.
- Que requisito o decision se relaciona, si aplica.
- En que rama fue revisado.
- Hacia que ambiente documental fue promovido.
