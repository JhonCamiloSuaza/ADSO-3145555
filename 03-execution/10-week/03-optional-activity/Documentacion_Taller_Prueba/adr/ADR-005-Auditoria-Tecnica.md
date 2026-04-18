# ADR-005: Sistema de Auditoría Técnica mediante Triggers Reactivos


## Contexto y Sensibilidad de Datos
El sistema gestiona dominios críticos como Ventas, Seguridad e Identidad. En una arquitectura de nivel empresarial, no basta con saber el estado actual de un registro; es imperativo conocer su historial de cambios, quién realizó la modificación y desde qué estado venía el dato.

## Problema Detectado
La auditoría tradicional a nivel de aplicación (logs en archivos de texto o consola) presenta tres vulnerabilidades:
1.  **Puede ser eludida**: Si un administrador modifica la base de datos vía SQL directo, la aplicación no se entera.
2.  **Inconsistencia**: No todos los desarrolladores implementan logs en todos los métodos de actualización.
3.  **Dificultad de Análisis**: Los logs desconectados de los datos son difíciles de cruzar en una investigación forense.

## Decisión Técnica adoptada
Implementar un **Sistema de Auditoría Reactiva** inyectado directamente en el motor PostgreSQL:
*   **Tabla Centralizada (`audit_log`)**: Diseñada con tipo de dato JSONB para capturar el estado anterior (`old_value`) y el nuevo (`new_value`) de forma flexible para cualquier tabla.
*   **Mecánica de Triggers (Disparadores)**: Se desarrollan funciones PL/pgSQL que se ejecutan automáticamente en los eventos `AFTER UPDATE` y `AFTER DELETE` de las tablas críticas.
*   **Automatización de Despliegue**: Los triggers y funciones se integran en Liquibase (dominio `12_facturacion_auditoria`) para asegurar su presencia en todos los entornos.

## Justificación Técnica
*   **Ineludible**: Al residir en la DB, el registro ocurre incluso si el cambio se hace fuera de la aplicación principal.
*   **Normalización**: Centraliza la auditoría en un solo punto, evitando duplicidad de columnas como `update_by` o `last_change` en cada tabla del sistema.
*   **JSONB**: El uso de JSONB permite auditar tablas con diferentes columnas sin necesidad de alterar el esquema de la tabla de auditoría.

## Consecuencias e Impacto
*   **Transparencia Total**: El equipo de seguridad puede reconstruir cualquier estado histórico de un registro.
*   **Costo de Almacenamiento**: El volumen de datos crecerá proporcionalmente a la actividad del sistema (mitigable mediante políticas de archivado).
*   **Mantenibilidad**: Se debe tener cuidado de actualizar la función del trigger si se añaden tablas de extrema sensibilidad.
