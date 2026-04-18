# ADR-002: Diseño de Roles con Permisos Diferenciados (RBAC)

## Contexto Arquitectónico
El sistema aeronáutico propuesto es multi-usuario y multi-rol por naturaleza. Contiene datos de diversa sensibilidad: desde itinerarios públicos hasta logs de auditoría técnica y transacciones financieras. Sin un control granular, cualquier usuario con acceso al sistema podría comprometer la integridad de la base de datos o violar la privacidad de los pasajeros.

## Problema de Seguridad
La falta de diferenciación de privilegios genera riesgos de:
1.  **Fraude**: Personal no autorizado manipulando facturas o reembolsos.
2.  **Sabotaje**: Cambios accidentales o malintencionados en el estado de los vuelos.
3.  **Filtración**: Acceso a datos personales por parte de roles que no lo requieren (ej: personal de mantenimiento).

## Decisión Técnica
Implementar un modelo de **Control de Acceso Basado en Roles** desacoplado de la lógica de aplicación. Se definen niveles de acceso mediante la asociación de Roles y Permisos Atómicos:
*   `security_role`: ADMIN, MANAGER, SALES, CREW, PASSENGER.
*   `security_permission`: Acciones específicas (ej: `flight.create`, `audit.view`, `sale.refund`).
*   `user_role`: Tabla puente para asignaciones múltiples.

## Justificación Técnica y Criterios
*   **Desacoplamiento**: Los permisos se verifican contra la base de datos, lo que permite cambiar las políticas de seguridad sin redesplegar la aplicación (Arquitectura Evolutiva).
*   **Auditoría**: Al tener roles definidos, el sistema de triggers puede registrar no solo el ID del usuario, sino el Rol bajo el cual se ejecutó la acción.
*   **Escalabilidad**: Un nuevo tipo de empleado (ej: Inspector de Seguridad) puede ser añadido simplemente creando un nuevo registro en `security_role` y asignándole los permisos existentes.

## Consecuencias e Impacto
*   **Integridad de Datos**: Se reduce el riesgo de inconsistencias por manipulaciones indebidas.
*   **Esfuerzo de Desarrollo**: Requiere que la capa de aplicación implemente interceptores para validar estos permisos antes de ejecutar queries.
*   **Rendimiento**: Se añade una ligera carga de `JOINs` en el login para recuperar el árbol de permisos del usuario, mitigable mediante el uso de caché en niveles superiores.
