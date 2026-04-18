# Estrategia de Despliegue Técnico y Contenedorización

Este documento describe la infraestructura tecnológica diseñada para garantizar la portabilidad, persistencia y el versionamiento del proyecto mediante contenedores.

## 1. Despliegue basado en Microservicios de Infraestructura
Se utiliza **Docker Compose** para orquestar los componentes vitales del entorno, asegurando que la base de datos sea idéntica en cualquier computador:

*   **Motor de Base de Datos (PostgreSQL 15)**:
    *   **Puerto Externo**: `5435` (Configurado específicamente para evitar conflictos con instalaciones locales de Postgres o PgAdmin).
    *   **Persistencia**: Uso del volumen nombrado **`postgres_data`** (gestionado por Docker) para garantizar que los datos y el historial de cambios no se pierdan al reiniciar los contenedores.
    *   **Configuración**: Base de datos denominada `Taller_prueba` con credenciales administradas mediante variables de entorno en el archivo de orquestación.
*   **Orquestador de Migraciones (Liquibase)**:
    *   **Integración**: Uso de un **Bind Mount** que mapea el directorio local (`./`) al contenedor. Esto permite que Liquibase acceda directamente al archivo maestro `changelog-master.yaml` y al Driver JDBC.
    *   **Control de Orquestación**: El servicio cuenta con la instrucción `depends_on`, asegurando que el motor de base de datos inicie su proceso de arranque antes de que Liquibase intente inyectar el esquema DDL/DML.

## 2. Gestión Estratégica del DDL (Versionamiento)
Cumpliendo con los estándares de modularidad exigidos:
*   **Un Dominio = Un Changelog**: Se garantiza que el máximo de entidades por archivo corresponda a un mismo dominio funcional (ej: `01_geografía.yaml`), facilitando la revisión de código y la detección de errores.
*   **Scripts SQL Externos**: Las definiciones de Triggers y Funciones de Auditoría se mantienen en archivos `.sql` independientes, permitiendo su depuración individual antes de ser integrados por el archivo maestro.
*   **Estructura Organizada**: Navegación rápida mediante carpetas por capas: Tablas (`03_tables`), Vistas (`04_views`), Procedimientos (`08_triggers`) e Índices (`09_indexes`).

## 3. Guía de Ejecución Rápida
Todo el sistema se levanta de forma automatizada con los siguientes comandos:
1. `docker-compose up -d postgres` (Lanza el motor de base de datos en modo persistente).
2. `docker-compose up liquibase` (Ejecuta las migraciones y el poblamiento de datos sobre el archivo `changelog-master.yaml`).

---
**Resultado técnico**: Se logra una solución de base de datos "Desplegable en un Clic", eliminando inconsistencias de entorno y asegurando que la evolución del esquema sea trazable y recuperable. 🚀🏆
