# Aspectos transversales

> Estado: Definido | Ultima actualizacion: 2026-06-19

Este documento define criterios que aplican a toda la arquitectura documental. No describe implementaciones reales, herramientas de seguridad, infraestructura ni operacion de produccion.

## Proposito

Mantener coherencia entre contexto, dominio, requisitos, arquitectura, datos, APIs, microservicios y manuales.

## Seguridad documental

- No publicar credenciales, tokens, secrets ni contrasenas.
- No publicar correos ni usuarios reales.
- No documentar integraciones reales como si ya existieran.
- Usar ejemplos genericos cuando se necesite ilustrar una idea.

## Trazabilidad

Todo cambio importante debe poder relacionarse con:

- Carpeta afectada.
- Modulo funcional.
- Requisito relacionado.
- Servicio propuesto, si aplica.
- Decision ADR, si cambia arquitectura.

## Calidad documental

Un documento transversalmente aceptable debe:

- Tener proposito claro.
- Estar en la carpeta correcta.
- Estar enlazado desde el README de su seccion.
- Evitar contenido repetido.
- Ser entendible para estudiantes y futuros equipos SENA.

## Microservicios propuestos

Los microservicios se documentan como propuesta tecnica, no como implementacion real. No se crean carpetas de servicios reales sin decision documentada.

## Gobernanza

La promocion documental es manual. No se usan pipelines, GitHub Actions ni automatizaciones para mover cambios entre ramas.

## Regla

Los aspectos transversales deben simplificar el trabajo del equipo. Si una regla no ayuda a documentar, revisar o mantener trazabilidad, no debe agregarse en esta fase.
