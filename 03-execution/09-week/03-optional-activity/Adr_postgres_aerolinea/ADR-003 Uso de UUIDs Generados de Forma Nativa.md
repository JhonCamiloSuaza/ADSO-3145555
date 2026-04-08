# Architecture Decision Record (ADR-003): Uso de UUIDs como Claves Primarias

ID: ADR-003
Autor: Jhon Camilo Suaza Sanchez
**Fecha:** Abril 2026  
**Estatus:** Aceptado e Implementado  
**Contexto:**
Durante el diseño de la base de datos aeronáutica, se requirió definir el tipo de dato que actuaría como Clave Primaria (Primary Key) para las más de 45 tablas del sistema. La práctica común en sistemas antiguos o monolíticos pequeños es utilizar identificadores numéricos incrementales (Ejemplo: `SERIAL` o `BIGINT AUTO_INCREMENT` que generan IDs como 1, 2, 3, 4...). 

Sin embargo, para un sistema empresarial, financiero y de boletaje, exponer IDs incrementales conlleva un riesgo altísimo de seguridad llamado **Enumeración de URLs (Insecure Direct Object Reference - IDOR)**. Si un boleto tiene el ID `1005`, un usuario malintencionado puede intentar buscar el boleto `1006` en la API del backend para robar información de otras personas. Además, si a futuro el sistema se divide en microservicios, usar números incrementales causaría choques y colisiones de IDs al sincronizar diferentes bases de datos.

---

## La Decisión
Dictaminar el uso exclusivo de UUIDs (Universally Unique Identifiers) en su versión V4 aleatoria para todas las llaves primarias y foráneas del modelo de datos.

**Solución Implementada:** 
Se estructuraron las tablas utilizando la función criptográfica nativa de PostgreSQL `gen_random_uuid()`. Esta función es proveída al habilitar la extensión `pgcrypto`.

Ejemplo implementado en todas las tablas:
```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE ticket (
    ticket_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    -- ...
);
```

---

## Impacto y Justificación
* **Seguridad (Antiscraping):** Es matemáticamente imposible que un atacante adivine el ID del siguiente boleto. (Ejemplo de ID generado: `f47ac10b-58cc-4372-a567-0e02b2c3d479`).
* **Descentralización:** El Backend (Spring Boot / Node) puede pre-generar un UUID antes de guardar en la base de datos sin miedo a que el ID ya esté ocupado.
* **Escalabilidad Global:** Prepara la base de datos para una eventual migración de esquema hacia una arquitectura Distribuida o de Múltiples Inquilinos a nivel mundial.

Esta decisión vuelve inmensamente resiliente al sistema de cara a su exposición pública por medio del Backend (API).
