# M02 - Estructura Institucional

## Que significa

Este modulo describe la organizacion institucional: regionales, centros de formacion y ubicaciones especificas. Es la base territorial y organizativa del proyecto.

## Por que va despues de seguridad

Una vez claro quien accede, se define donde opera el sistema. Los demas modulos necesitan referenciar centros, regionales y ubicaciones para evitar informacion duplicada.

## Alcance inicial

- Regionales.
- Centros de formacion.
- Sedes o ubicaciones especificas.
- Relacion entre estructura institucional y ambientes.

## No incluye

- Inventario detallado de ambientes.
- Horarios.
- Programas academicos.

## Entidades principales

| Entidad | Descripcion |
|---------|-------------|
| Regional | Agrupacion territorial |
| Centro de formacion | Unidad academica asociada a una regional |
| Ubicacion | Lugar especifico donde ocurre una actividad |

## Requisitos relacionados

- RF-003: administrar regionales, centros y ubicaciones.

## Servicio propuesto

`reference-data-service`

## Siguiente modulo

Despues se define `04-parametrizacion`, porque los catalogos base ayudan a organizar infraestructura, programas y actores.
