# Validacion de escalabilidad documental

Este documento explica por que la estructura actual puede crecer sin volverse confusa.

## Criterio principal

El repositorio separa la documentacion por responsabilidad:

- `01-contexto`: por que existe el proyecto.
- `02-dominio`: que modulos y reglas tiene el negocio.
- `04-requisitos`: que debe cumplir el sistema.
- `05-arquitectura`: que decisiones tecnicas se toman.
- `06-datos`: como se entienden los datos.
- `07-api`: como se documentaran contratos.
- `09-microservicios`: que servicios se proponen y como se relacionan.
- `14-manuales`: como se explicara el uso a personas.
- `15-control-proyecto`: riesgos, dependencias y preguntas.

## Por que escala

| Necesidad futura | Donde se documenta |
|------------------|--------------------|
| Nuevo modulo funcional | `02-dominio/modulos` |
| Nuevo requisito | `04-requisitos` |
| Nueva decision de arquitectura | `05-arquitectura/decisiones` |
| Nuevo servicio aprobado | `09-microservicios/servicios` |
| Nuevo evento | `09-microservicios/catalogo-eventos.md` |
| Nuevo dato compartido | `06-datos/diccionario-datos.md` |
| Nuevo riesgo | `15-control-proyecto/riesgos.md` |

## Riesgo controlado

La estructura puede crecer, pero solo si se respetan estas reglas:

- No duplicar fuentes de verdad.
- No crear carpetas sin README.
- No crear microservicios ficticios.
- No dejar documentos vacios.
- Mantener nombres en espanol y entendibles.

## Conclusion

La estructura es suficiente para un proyecto SENA Nacional porque permite iniciar simple y crecer por modulos, requisitos, decisiones, servicios y manuales sin reorganizar todo el repositorio.
