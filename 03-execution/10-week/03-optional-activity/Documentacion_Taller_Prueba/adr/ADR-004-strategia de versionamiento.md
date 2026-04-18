# ADR-004: Estrategia de Versionamiento y Flujo de Ramas (GitFlow)


## Contexto del Ciclo de Vida
El desarrollo de un sistema aeronáutico integrado requiere una alta estabilidad. No es aceptable que código experimental o incompleto llegue a la rama principal, ya que esto detendría la validación por parte de los interesados o instructores.

## Problema de Gestión de Versiones
El desarrollo en una sola rama (`monolítica`) causa:
1.  **Bloqueos de Código**: Un error en un módulo detiene el progreso de los demás.
2.  **Inestabilidad en QA**: Las pruebas fallan por cambios que aún están a medio terminar.
3.  **Dificultad de Auditoría**: Es difícil identificar qué versión del código corresponde a qué estado de la base de datos en producción.

## Decisión de Flujo de Trabajo
Implementar un modelo de flujo de ramas basado en **GitFlow simplificado**, optimizado para la entrega de historias de usuario:
*   **`main`**: Versión certificada. No se toca directamente. Solo recibe merges de `qa`.
*   **`qa`**: Rama de estabilización. Aquí el instructor o el equipo de QA validan el funcionamiento completo.
*   **`dev`**: Rama de integración diaria. Aquí convergen las historias de usuario terminadas.
*   **`HU-XXdev`**: Ramas de características (Feature branches). Se crea una para cada HU y se destruye tras el merge exitoso a `dev`.

## Justificación Técnica
*   **Aislamiento Atómico**: Cada Historia de Usuario se desarrolla en su propio entorno, minimizando colisiones.
*   **Calidad por Etapa**: El paso de `dev` a `qa` y de `qa` a `main` requiere la aprobación de Pull Requests, lo que actúa como un filtro de calidad manual y técnico.
*   **Trazabilidad de Requerimientos**: Cada commit en las ramas `HU-XX` está directamente vinculado a un requerimiento funcional de la guía.

## Consecuencias e Impacto
*   **Fiabilidad**: Se garantiza que la rama `main` siempre esté en un estado funcional.
*   **Esfuerzo de Sincronización**: Requiere que realicen `git pull` y `git merge` constantes para mantener sus ramas actualizadas con `dev`.
