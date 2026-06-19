# Flujo de publicacion documental

Este documento resume la promocion manual de cambios documentales. El detalle completo vive en `00-gobernanza/estrategia-ramas.md`.

## Flujo

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

Cada paso se revisa y aprueba manualmente antes de pasar al siguiente ambiente documental.

## Que se revisa antes de publicar

- Los documentos tienen contenido real.
- No hay campos vacios ni decisiones sin documentar.
- Los enlaces funcionan conceptualmente.
- La matriz de trazabilidad se actualizo si aplica.
- No hay secretos ni datos sensibles.

## Regla

Este flujo es manual. No se documentan automatizaciones obligatorias en esta etapa.
