# M04 - Parametrizacion

## Que significa

Este modulo contiene catalogos base y parametros generales que usan otros modulos. Su objetivo es evitar que cada parte del sistema invente listas o valores diferentes.

## Por que va temprano

Va antes de infraestructura, programas, actores y horarios porque esos modulos necesitan valores controlados: tipos, estados, categorias, jornadas, clasificaciones y opciones comunes.

## Alcance inicial

- Catalogos base.
- Parametros genericos.
- Estados y clasificaciones reutilizables.
- Valores permitidos para formularios y reglas.

## No incluye

- Reglas complejas de horarios.
- Datos propios de programas o fichas.
- Configuraciones tecnicas de infraestructura real.

## Entidades principales

| Entidad | Descripcion |
|---------|-------------|
| Catalogo | Lista controlada de valores |
| Valor de catalogo | Opcion permitida dentro de un catalogo |
| Parametro | Configuracion reutilizable |

## Requisitos relacionados

- RF-005: gestionar catalogos base y parametros reutilizables.

## Servicio propuesto

`reference-data-service`

## Siguiente modulo

Despues de parametrizar, se puede documentar infraestructura y programas con valores consistentes.
