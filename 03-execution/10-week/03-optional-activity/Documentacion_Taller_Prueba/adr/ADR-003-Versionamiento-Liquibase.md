# ADR-003: Versionamiento del DDL con Liquibase

## Contexto y Necesidad Técnica
En el desarrollo de bases de datos relacionales complejas, el estado del esquema suele divergir rápidamente entre los desarrolladores. El uso de scripts SQL manuales es propenso a errores, no permite el versionamiento atómico y dificulta la replicación exacta de la base de datos en entornos de QA o Producción.

## Problema Identificado
La falta de una herramienta de migración automatizada genera:
1.  **Conflictos de Despliegue**: Fallos al intentar aplicar cambios en un orden incorrecto.
2.  **Pérdida de Trazabilidad**: Desconocimiento de quién aplicó un cambio, cuándo y por qué.
3.  **Dificultad de Rollback**: Revertir un cambio estructural (como un cambio de tipo de dato) es una tarea manual peligrosa sin una herramienta que orqueste la reversión.

## Decisión Arquitectónica
Se adopta **Liquibase** como el estándar de gestión del ciclo de vida de la base de datos. La estrategia se basa en:
*   **Changelogs Modulares por Dominio**: Cada dominio funcional (Geografía, Aeronaves, etc.) tiene su propio archivo YAML. Esto evita conflictos de merge en Git cuando dos desarrolladores trabajan en dominios distintos.
*   **Declaratividad**: Uso de formato YAML para los changelogs por su alta legibilidad y capacidad de validación estructural antes de la ejecución.
*   **Orquestación Maestra**: Un archivo `changelog-master.yaml` que importa los módulos en el orden estricto de sus dependencias lógicas.

## Justificación Técnica
*   **Idempotencia**: El comando `update` de Liquibase garantiza que solo se apliquen los cambios pendientes, permitiendo ejecuciones repetidas sin errores.
*   **Integridad Refencial**: Al separar por dominios y usar un archivo maestro, se garantiza que las tablas "padre" siempre se creen antes que las "hijas".
*   **Auditoría Nativa**: El uso de las tablas `databasechangelog` y `databasechangeloglock` ofrece un registro inmutable de la evolución del DDL.

## Consecuencias Esperadas
*   **Consistencia**: Se garantiza que la base de datos sea idéntica en el local del desarrollador y en el servidor de pruebas.
*   **Curva de Aprendizaje**: El equipo debe familiarizarse con la sintaxis de Liquibase y evitar la tentación de realizar cambios DDL directos vía consola.

