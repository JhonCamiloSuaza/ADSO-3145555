# Vision general

## Contexto institucional

El proyecto Horarios SENA se plantea para apoyar la organizacion academica de programas de formacion, fichas, instructores, ambientes, proyectos formativos y eventos de coordinacion. La documentacion esta orientada a un proyecto SENA Nacional, por eso debe ser clara, trazable y entendible por diferentes integrantes del equipo.

El repositorio no implementa software todavia. Su funcion es dejar preparada la arquitectura documental para que el equipo pueda avanzar con una misma lectura del problema, los modulos, los requisitos y las decisiones tecnicas.

## Problema

La gestion de horarios y proyectos formativos puede volverse dificil cuando la informacion se encuentra dispersa entre fichas, instructores, ambientes, competencias, RAP, inventarios, eventos y documentos de seguimiento. Si cada equipo documenta de forma distinta, se pierde trazabilidad y aparecen decisiones contradictorias.

Este repositorio busca resolver ese desorden documental antes de pasar a implementacion.

## Objetivo general

Definir una estructura documental profesional, simple y mantenible para el proyecto Horarios SENA, alineada con los 10 modulos funcionales definidos y preparada para crecer hacia APIs, microservicios, manuales, diagramas, riesgos y KPIs.

## Objetivos especificos

- Explicar el dominio del proyecto mediante 10 modulos funcionales.
- Mantener trazabilidad entre contexto, requisitos, dominio, arquitectura, APIs y microservicios.
- Evitar documentos vacios, repetidos o con nombres dificiles de entender.
- Definir un flujo manual de promocion documental entre ramas.
- Crear una base clara para que otros companeros puedan completar o revisar documentos sin perderse.

## Enfoque de trabajo

El proyecto se documenta primero como una arquitectura modular. Esto permite entender el negocio antes de decidir que partes seran microservicios reales. La documentacion no debe inventar usuarios, credenciales, repositorios ni configuraciones que todavia no existen.

## Modulos funcionales base

1. Seguridad y Acceso.
2. Estructura Institucional.
3. Infraestructura.
4. Parametrizacion.
5. Programas de Formacion.
6. Oferta y Programas.
7. Actores.
8. Horarios.
9. Proyectos Formativos.
10. Coordinacion y Eventos.

## Criterio de exito documental

Una persona nueva debe poder abrir el repositorio, leer `README.md`, entrar a `01-contexto`, revisar `02-dominio/modulos` y entender que se esta construyendo, en que orden se piensa trabajar y como se conecta cada parte con requisitos y servicios propuestos.
