# ADR-002: Diseño de Roles con Permisos Diferenciados (RBAC)

## Contexto arquitectónico
El sistema aeronáutico es multi-usuario y multi-rol; contiene desde datos públicos (itinerarios) hasta datos sensibles (logs, transacciones). El control de acceso debe impedir que usuarios sin privilegios manipulen o accedan a información sensible.

Este ADR valida la propuesta RBAC contra el esquema existente en el repositorio y documenta la decisión recomendada.

## Suposiciones
- Los stakeholders han confirmado que los cinco roles canónicos son definitivos: `ADMIN`, `MANAGER`, `SALES`, `CREW`, `PASSENGER`.
- No se realizarán cambios de DDL o DML destructivos como parte de este ADR; cualquier cambio será aprobado y documentado por separado.

## Alcance
- Este ADR valida y acepta el modelo RBAC definido en la base de datos y cubre únicamente la estructura y los permisos iniciales. No aplica cambios automáticos ni elimina scripts existentes.

In-scope:
- Validar y aceptar la topología RBAC existente en la base de datos: tablas (`security_role`, `security_permission`, `user_role`, `role_permission`), constraints, índices y datos de referencia que ya están en los changeSets.
- Registrar la confirmación de stakeholders sobre los cinco roles canónicos y documentar las recomendaciones operativas (mapeo de permisos, pruebas, auditoría).
- Proponer acciones no destructivas (documentación, ADRs o changeSets separados) para reconciliar duplicidades si es necesario.

Out-of-scope:
- No se realizarán cambios destructivos en DDL o DML: no se eliminarán ni renombrarán scripts existentes ni se borrarán roles/permiso en este ADR.
- No se implementará código de la capa de aplicación ni se desplegarán cambios de runtime; esas acciones quedan para equipos responsables tras aprobación.

Criterios de aceptación:
- El ADR está marcado como `Accepted` y revisado por stakeholders (hecho).
- Los cinco roles canónicos están documentados y confirmados en el repositorio o por stakeholders: `ADMIN`, `MANAGER`, `SALES`, `CREW`, `PASSENGER`.
- Se provee una ruta clara para cualquier cambio futuro (nuevo ADR o changeSet) y guías para pruebas y rollback.

Responsables y aprobaciones:
- Propietario técnico (Security/Platform): equipo de seguridad/DBA — responsable de coordinar changeSets y validaciones.
- Aprobación final: stakeholders de producto y seguridad.

Resultado esperado: este ADR sirve como la fuente de verdad para la política RBAC inicial; cualquier modificación significativa requerirá un ADR o un changeSet aprobado y documentado.

## Estado actual (evidencia en el repo)
- Tablas relevantes definidas en DDL: [01_ddl/03_tables/04_seguridad.yaml](01_ddl/03_tables/04_seguridad.yaml#L1)
  - `security_role` (PK `security_role_id`, `role_code`, `role_name`, `role_description`, unicidad en `role_code`/`role_name`).
  - `security_permission` (PK `security_permission_id`, `permission_code`, `permission_name`, unicidad en `permission_code`).
  - `user_role` (tabla puente con FK `user_account_id` → `user_account` y `security_role_id` → `security_role`, y restricción única `uq_user_role(user_account_id, security_role_id)`).
  - `role_permission` (tabla puente entre roles y permisos con restricción única `uq_role_permission(security_role_id, security_permission_id)`).

- Datos de ejemplo cargados en DML: [02_dml/00_inserts/04_dml_seguridad.yaml](02_dml/00_inserts/04_dml_seguridad.yaml#L1) y [02_dml/00_inserts/04_roles_and_permissions.yaml](02_dml/00_inserts/04_roles_and_permissions.yaml#L1).
  - Roles insertados en los scripts: `ADMIN`, `MANAGER`, `SALES`, `PASSENGER` (en `04_dml_seguridad.yaml`) y un conjunto alterno `ADMIN`, `AGENT`, `CUSTOMER` (en `04_roles_and_permissions.yaml`).
  - Permisos insertados: `AUDIT_VIEW`, `FLIGHT_MANAGE`, `SALE_ISSUE`, `USER_MANAGE`, `RESERVATION_VIEW`.

## Problema de decisión
¿Aceptar el diseño RBAC tal cual (roles y permisos existentes) o estandarizar/cambiar códigos de permisos y roles para reflejar convenciones funcionales (p.ej. `flight.create`, `audit.view`, `sale.refund`)?

## Decisión tomada
1. Adoptar el modelo RBAC implementado en la base de datos (tablas y relaciones) como la fuente de verdad.
2. Mantener los roles actuales (`ADMIN`, `MANAGER`, `SALES`, `PASSENGER`) como escopos iniciales, pero:
   - Recomendación: reconciliar la duplicidad detectada (`AGENT`/`CUSTOMER` vs `MANAGER`/`SALES`/`PASSENGER`) en un cambio separado (ver 'Siguientes pasos').
3. Mantener los códigos de permiso actuales (`AUDIT_VIEW`, `FLIGHT_MANAGE`, `SALE_ISSUE`, `USER_MANAGE`, `RESERVATION_VIEW`) como permisos atómicos almacenados en `security_permission`.
  - Recomendación: documentar un mapeo entre `permission_code` (DB) y nombres semánticos consumidos por la app (p.ej. `FLIGHT_MANAGE` → `flight.*`, `AUDIT_VIEW` → `audit.view`).

4. Confirmación de stakeholders: se confirma rotundamente que los roles NO cambiarán. Los cinco roles definitivos son:
  - `ADMIN`
  - `MANAGER`
  - `SALES`
  - `CREW`
  - `PASSENGER`
  No se agregarán ni eliminarán roles adicionales a este conjunto. Cualquier ajuste futuro deberá registrarse en un ADR o changeSet separado.

Razonamiento: la estructura DDL y los inserts ya implementan las entidades necesarias (roles, permisos y tablas puente) con constraints apropiados (FKs, unicidad, índices y triggers). Aprovechar lo existente minimiza cambios y riesgos.

## Consecuencias
- Positivas
  - No requiere cambios en DDL ni en los changeSets existentes; despliegue y rollbacks ya soportados.
  - Permite implementar validaciones de permisos en la capa de aplicación usando la tabla `role_permission` y `user_role`.

- Pendientes / Riesgos
  - Convención de nombres: la app y los desarrolladores deben acordar cómo mapear `permission_code` a rutas/acciones de la aplicación; sin esto, pueden surgir inconsistencias (p. ej. `sale.refund` no existe y debería mapearse o crearse como `SALE_REFUND`).
  - Duplicidad de roles insertados en diferentes scripts debe resolverse para evitar confusión en entornos donde se apliquen ambos changelogs.

## Impacto operacional
- Autenticación/Login: durante el login la aplicación debe recuperar `user_account` → `user_role` → `role_permission` (o una estructura cacheada equivalente).
- Auditoría: los triggers y los metadatos de `user_role` permiten registrar el rol bajo el cual se asignaron acciones (recomendado implementar en la capa de aplicación y, si aplica, enrich en triggers).
- Migraciones: cualquier cambio a códigos de permiso o roles requiere un changeSet DML que cree nuevos permisos o renombre/mapee existentes y un rollback correspondiente.

## Recomendaciones y siguientes pasos (acciones separadas)
1. Reconciliation: Crear un ADR o changeSet separado para decidir si `AGENT`/`CUSTOMER` se conservan o se unifican con `MANAGER`/`SALES`/`PASSENGER`.
2. Permission naming policy: definir convención (p.ej. `domain.action` lower_case) y mantener una tabla de mapeo/documentación que relacione `permission_code` con la convención de la app.
3. (Opcional) Si se requiere `sale.refund`, añadir un permiso `SALE_REFUND` en `security_permission` mediante un changeSet en `02_dml/00_inserts` y actualizar `role_permission` para asignarlo a roles apropiados.
4. Añadir pruebas automáticas que validen que las migraciones DML aplicadas en staging no crean roles duplicados ni permisos inconsistentes.

## Notas y referencias
- DDL: [01_ddl/03_tables/04_seguridad.yaml](01_ddl/03_tables/04_seguridad.yaml#L1) — definición de tablas y constraints.
- Inserts de seguridad: [02_dml/00_inserts/04_dml_seguridad.yaml](02_dml/00_inserts/04_dml_seguridad.yaml#L1), [02_dml/00_inserts/04_roles_and_permissions.yaml](02_dml/00_inserts/04_roles_and_permissions.yaml#L1).
- Rollbacks de seguridad: [05_rollbacks/02_dml/00_inserts/04_dml_seguridad.sql](05_rollbacks/02_dml/00_inserts/04_dml_seguridad.sql#L1).

---
Decisión propuesta: Aceptar el modelo RBAC actual como base; abrir una ADR/ChangeSet separado si se desean cambios en roles o en la convención de permisos.
