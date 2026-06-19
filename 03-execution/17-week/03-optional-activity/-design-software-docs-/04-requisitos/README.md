# Requisitos

Esta carpeta convierte el contexto y el dominio en necesidades verificables. Su funcion es que el equipo pueda saber que debe cumplir el sistema, de donde sale cada necesidad y que modulo, servicio o documento la desarrolla.

## Documentos

| Documento | Proposito | Estado |
|-----------|-----------|--------|
| [requisitos-funcionales.md](./requisitos-funcionales.md) | Requisitos funcionales organizados por los 10 modulos | Definido |
| [requisitos-no-funcionales.md](./requisitos-no-funcionales.md) | Criterios de calidad, seguridad, trazabilidad y mantenibilidad | Definido |
| [historias-usuario.md](./historias-usuario.md) | Historias iniciales con criterio de aceptacion | Definido |
| [matriz-trazabilidad.md](./matriz-trazabilidad.md) | Relacion entre requisitos, modulos, servicios, APIs, eventos y documentos | Definido |

## Como se usa

1. Crear o ajustar primero el requisito.
2. Relacionarlo con un modulo de `02-dominio/modulos`.
3. Revisar si afecta datos, API, microservicios o arquitectura.
4. Actualizar la matriz de trazabilidad.

## Regla

Un requisito sin modulo, criterio o trazabilidad no debe promoverse como estable.
