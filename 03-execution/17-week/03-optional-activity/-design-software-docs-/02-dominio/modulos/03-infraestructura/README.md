# M03 - Infraestructura

## Que significa

Este modulo documenta los ambientes de formacion, recursos, inventario y disponibilidad. Permite saber que espacios y elementos existen para programar actividades.

## Por que va despues de estructura y parametrizacion

La infraestructura depende de ubicaciones institucionales y catalogos base. No se debe documentar un ambiente sin saber a que centro pertenece o como se clasifica.

## Alcance inicial

- Ambientes de formacion.
- Inventario asociado.
- Disponibilidad de ambientes.
- Relacion con ubicaciones.

## No incluye

- Asignacion final de horarios.
- Seguimiento de proyectos.
- Eventos de coordinacion.

## Entidades principales

| Entidad | Descripcion |
|---------|-------------|
| Ambiente | Espacio fisico o logico para formacion |
| Recurso | Elemento disponible en un ambiente |
| Inventario | Registro de recursos asociados |
| Disponibilidad | Estado que indica si un ambiente puede usarse |

## Requisitos relacionados

- RF-004: registrar ambientes, inventario y disponibilidad.

## Servicio propuesto

`training-environment-service`

## Siguiente modulo

Despues se documenta `05-programas-de-formacion`, porque ya existe base institucional y recursos donde se desarrollara la formacion.
