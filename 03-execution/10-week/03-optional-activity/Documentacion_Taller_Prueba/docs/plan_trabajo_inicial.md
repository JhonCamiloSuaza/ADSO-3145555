# Plan de Trabajo Inicial - Fase Supervisada (5 Horas)

Este documento detalla la planificación estratégica y ejecución técnica realizada durante la prueba supervisada para garantizar la estabilización del modelo de base de datos y el cumplimiento de los requerimientos.

---

## 📈 Cronograma de Ejecución y Metas

| Hora | Actividad | Meta Principal | Entregable |
|:---|:---|:---|:---|
| **H1** | Análisis y Gitflow | Identificar los 13 dominios y estructurar el repositorio. | `ANALISIS_DOMINIOS.md` |
| **H2** | Infraestructura Docker | Configurar Postgres y Liquibase con Master Changelog. | `docker-compose.yml` |
| **H3** | Modularización DDL | Dividir el SQL original en changelogs por dominio funcional. | Carpeta `01_ddl/` |
| **H4** | Evolución Técnica | Implementar RBAC, Auditoría y el nuevo dominio: Tripulación. | ADR-001, ADR-002 |
| **H5** | Calidad e Integridad | Carga de datos por niveles y cierre de documentación técnica. | BACKLOG, ADR (03,04,05) |

---

## 🕒 Ejecución Detallada

### : Análisis y Estructura Base
*   **Actividad**: Análisis profundo del script `modelo_postgresql.sql` e identificación de los 13 dominios.
*   **Entregable**: Archivo `ANALISIS_DOMINIOS.md` y creación del repositorio Git con ramas `dev`, `qa` y `main`.

### : Contenerización e Infraestructura
*   **Actividad**: Configuración de `docker-compose.yml` para PostgreSQL y Liquibase.
*   **Entregable**: Contenedores operativos y conexión exitosa. Creación del `changelog-master.yaml`.

### : Estabilización y Modularización DDL
*   **Actividad**: Separación del DDL original en archivos YAML organizados por dominios funcionales.
*   **Entregable**: Carpeta `01_ddl/` totalmente poblada y validada mediante `liquibase update`.

### : Seguridad, Auditoría y Escalabilidad
*   **Actividad**: Implementación del nuevo dominio de **Tripulación** y del sistema de **Auditoría por Triggers**. Definición de la matriz de roles y permisos (RBAC).
*   **Entregable**: ADR-001, ADR-002 y scripts de triggers operativos.

### : Poblamiento, QA y Documentación Final
*   **Actividad**: Ejecución del plan de poblamiento (DML) por niveles. Realización de pruebas de integridad. Redacción final de ADR-003, ADR-004 y ADR-005.
*   **Entregable**: Repositorio consolidado en `main`, Backlog técnico y archivos de soporte técnico.

---

## 🛠️ Detalles de la Estrategia Técnica

### 1. Fase de Estabilización
La utilización de **Liquibase** como orquestador permitió que la creación de las tablas fuera atómica y respetara estrictamente las llaves foráneas mediante una carga jerárquica de archivos YAML modulares.

### 2. Estrategia de Versionamiento (Gitflow)
Se aplicó una metodología de entregas continuas para mantener la integridad:
1.  **Desarrollo**: Trabajo en ramas independientes por Historia de Usuario (`HU-XXdev`).
2.  **Integración (`dev`)**: Convergencia de cambios validados.
3.  **Certificación (`qa`)**: Verificación técnica integral por Liquibase.
4.  **Entrega Final (`main`)**: Versión certificada 100% estable.

---

## 🏁 Resultado Final
El proceso culminó con éxito en el tiempo estipulado, logrando una **Base de Datos Estabilizada, Contenerizada y Documentada**, con un backlog técnico que asegura la trazabilidad de cada cambio y una estructura lista para su evolución hacia una arquitectura de servicios orientada a la industria aeronáutica. 🚀🏆
