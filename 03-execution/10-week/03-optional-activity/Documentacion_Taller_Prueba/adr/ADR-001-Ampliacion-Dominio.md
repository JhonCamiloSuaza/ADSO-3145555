# ADR-001: Ampliación del Dominio Funcional de Tripulación


## Título
Inclusión del módulo de Tripulación (Crew Management) para completar el ciclo de operación de vuelo.

## Contexto
El modelo original permitía gestionar la infraestructura de aeropuertos y el transporte de pasajeros, pero carecía de una estructura para gestionar el personal operativo obligatorio (Pilotos, Copilotos, Auxiliares) en cada segmento de vuelo.

## Problema
Imposibilidad de validar la asignación de personal técnico a los vuelos, falta de trazabilidad sobre roles operativos y riesgo de incumplimiento de regulaciones aeronáuticas sobre tripulaciones mínimas.

## Decisión
Se decidió extender el modelo de datos con el dominio **Tripulación**, añadiendo las tablas:
*   `crew_member`: Para datos maestros del personal operativo.
*   `crew_role`: Catálogo de roles diferenciados.
*   `flight_crew_assignment`: Para la asignación transaccional a segmentos de vuelo.

## Justificación Técnica
*   **Normalización**: Evita saturar la tabla `person` con datos laborales específicos de aeronáutica.
*   **Seguridad**: Permite integrar a futuro validaciones de licencias vigentes antes de asignar un vuelo.

## Consecuencias
*   **Positivo**: Operación de vuelo 100% trazable según estándares reales de la industria.
*   **Negativo**: Incrementa ligeramente la complejidad del plan de poblamiento de datos.
