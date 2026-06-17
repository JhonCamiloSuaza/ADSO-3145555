# Architecture overview

> Estado: 🔴 | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Arquitectura

## Propósito

Este documento presenta la arquitectura de referencia del sistema **Horarios SENA**, una plataforma nacional para la gestión de trazabilidad de formación, coordinación de horarios, seguimiento de proyectos formativos y notificaciones institucionales.

El objetivo es establecer una base arquitectónica de nivel senior que apoye:
- la integración con sistemas institucionales de SENA (SOFIA Plus, BETOWA, servicios internos),
- la operación segura a escala nacional,
- la gobernanza de documentación técnica y decisiones de arquitectura,
- la visibilidad operativa y el cumplimiento de estándares de calidad.

## Principios arquitectónicos

1. Governed by documentation: la arquitectura se define primero en documentos, ADRs y decisiones formales.
2. Domain-driven design para SENA: los servicios están alineados con los dominios de formación, ficha, programa, orientación y auditoría.
3. Boundary-first integration: las conexiones externas a sistemas SENA se aíslan en capas de integración claramente definidas.
4. Observable desde el diseño: telemetría, auditoría y monitoreo son componentes nativos.
5. Seguridad por defecto: autenticación, autorización, cifrado y clasificación de datos se aplican en cada capa.

## Vistas de arquitectura

- Vista lógica: servicios, bounded contexts y dependencias de dominio.
- Vista de despliegue: entornos, infraestructura y redes.
- Vista de integración: contratos API, eventos y patrones de comunicación.
- Vista de datos: modelos de persistencia, eventos y flujos de datos.
- Vista operacional: monitoreo, gobernanza, seguridad y resiliencia.

## Alcance del repositorio

Este repositorio documenta la arquitectura senior de software del proyecto SENA Nacional para:
- servicios backend y APIs,
- catálogo de microservicios,
- decisiones arquitectónicas (ADR),
- despliegue y entornos,
- aspectos transversales de seguridad, calidad y operaciones.

## Estructura del área de arquitectura

- `overview.md` — visión de alto nivel y principios.
- `deployment.md` — topología de despliegue y ambientes.
- `cross-cutting.md` — seguridad, observabilidad, resiliencia y gobernanza.
- `decisions/` — ADRs y decisiones arquitectónicas.

## Metodología

La arquitectura se documenta con un enfoque incremental y revisable:
- cada decisión se registra en un ADR,
- cada cambio significativo pasa por revisión de equipo,
- la documentación se actualiza antes de los cambios en los artefactos técnicos.

## Nota para el equipo SENA

Esta arquitectura está diseñada para ser consumida por los equipos de diseño, desarrollo, infraestructura y gobernanza de SENA Nacional, con foco en trazabilidad, calidad y continuidad operativa.
