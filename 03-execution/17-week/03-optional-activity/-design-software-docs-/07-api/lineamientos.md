# Lineamientos de API

Este documento define reglas iniciales para APIs futuras. No significa que los endpoints ya existan.

## Principios

- Cada API debe responder a un requisito o modulo.
- Los nombres deben ser claros y consistentes.
- No se deben exponer datos sensibles innecesarios.
- Las APIs deben enlazarse con servicios propuestos cuando aplique.

## Recursos candidatos

| Recurso | Modulo | Servicio propuesto |
|---------|--------|--------------------|
| `/regionales` | M02 | `reference-data-service` |
| `/centros-formacion` | M02 | `reference-data-service` |
| `/ambientes` | M03 | `training-environment-service` |
| `/catalogos` | M04 | `reference-data-service` |
| `/programas-formacion` | M05 | `academic-management-service` |
| `/fichas` | M06 | `academic-management-service` |
| `/actores` | M07 | `actors-service` |
| `/horarios` | M08 | `scheduling-service` |
| `/seguimientos` | M09 | `monitoring-service` |
| `/eventos` | M10 | `coordination-service` |

## Convenciones

- Usar nombres en plural para recursos.
- Usar kebab-case en rutas.
- Versionar cuando exista contrato formal.
- Documentar errores esperados.
- Relacionar endpoint con requisito funcional.
