# Contexto del proyecto

Esta carpeta explica por que existe el proyecto Horarios SENA, que problema busca resolver y que vocabulario debe usar el equipo. Es la primera carpeta que debe leer una persona nueva antes de entrar a requisitos, arquitectura o microservicios.

## Proposito

Dar una vision comun del proyecto para que la documentacion no se escriba desde interpretaciones separadas. Todo requisito, modulo, API o servicio debe poder entenderse desde este contexto.

## Documentos

| Documento | Que explica | Estado |
|-----------|-------------|--------|
| [vision-general.md](./vision-general.md) | Problema, objetivo, contexto SENA y enfoque general | Definido |
| [alcance.md](./alcance.md) | Que entra, que no entra, supuestos y restricciones | Definido |
| [glosario.md](./glosario.md) | Terminos principales para hablar el mismo idioma | Definido |

## Como se usa

1. Leer la vision general para entender la intencion del proyecto.
2. Validar el alcance antes de crear requisitos nuevos.
3. Consultar el glosario cuando haya dudas sobre terminos como ficha, ambiente, RAP, competencia o proyecto formativo.

## Relacion con otras carpetas

- `02-dominio` toma este contexto y lo organiza en modulos funcionales.
- `04-requisitos` convierte el contexto en necesidades documentables.
- `05-arquitectura` define decisiones tecnicas alineadas al alcance.
- `09-microservicios` propone limites tecnicos sin inventar implementaciones.
