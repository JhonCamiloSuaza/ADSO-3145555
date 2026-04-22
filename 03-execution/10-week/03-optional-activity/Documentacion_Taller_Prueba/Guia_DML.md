# Guía Detallada de Población de Datos (DML) - Taller Aeronáutico

Este documento detalla **exactamente qué datos específicos** se insertaron en cada uno de los 14 dominios de la base de datos a través de los scripts de Liquibase. Esto sirve como referencia para saber qué registros existen por defecto para pruebas y desarrollo.

---

## 🌍 Nivel 1: Datos Fundamentales

### Dominio 01: Geografía Maestra (Master Basics)
- **Continentes**: Suramérica (SA) y Norteamérica (NA).
- **Países**: Colombia (COL) y Estados Unidos (USA).
- **Regiones/Departamentos**: Cundinamarca (Colombia) y Florida (USA).
- **Ciudades**: Bogotá (BOG) y Miami (MIA).

### Dominio 02: Estados y Configuraciones Básicas
- **Estados Genéricos**: Activo (ACTIVE) e Inactivo (INACTIVE).
- **Tipos de Documento**: Cédula de Ciudadanía (CC) y Pasaporte (PASSPORT).
- **Zonas Horarias**: America/Bogota (UTC-5) y America/New_York (UTC-5/UTC-4).
- **Idiomas**: Español (ES) e Inglés (EN).

---

## 🔒 Nivel 2: Seguridad y Ubicación

### Dominio 03: Direcciones (Geography)
- Se crearon direcciones físicas base:
  - Dirección del Aeropuerto El Dorado en Bogotá (Calle 26).
  - Dirección del Aeropuerto Internacional de Miami.
  - Dirección residencial de prueba para los empleados/pasajeros.

### Dominio 04: Roles y Permisos (Seguridad)
- **Roles (`security_role`)**:
  Existen dos conjuntos de roles insertados (uno en `04_dml_seguridad.yaml` y otro en `04_roles_and_permissions.yaml`):
  1. `ADMIN`, `MANAGER`, `SALES`, `PASSENGER`.
  2. `ADMIN` (duplicado), `AGENT`, `CUSTOMER`.
- **Permisos (`security_permission`)**: 
  Insertados en mayúsculas como acciones atómicas: `AUDIT_VIEW`, `FLIGHT_MANAGE`, `SALE_ISSUE`, `USER_MANAGE`, `RESERVATION_VIEW`.

---

## ✈️ Nivel 3 y 4: Infraestructura y Flota

### Dominio 05: Datos Operativos (Operational Data)
- **Fabricantes**: Boeing y Airbus.
- **Tipos de Aeronave**: Boeing 787 Dreamliner (B787) y Airbus A320.
- **Clases de Cabina**: Economy, Premium Economy, Business y First Class.

### Dominio 06: Aeropuertos
- **Aeropuertos**:
  - El Dorado (BOG) en Bogotá.
  - Miami International (MIA) en Miami.
- **Infraestructura**: Terminal 1 (T1) en BOG, Terminal D en MIA, y puertas de embarque de ejemplo (ej. Gate 45, Gate D20).

### Dominio 07: Aeronaves
- **Flota física**:
  - Se registró una aeronave específica con matrícula `N787AV` asignada al tipo Boeing 787.

### Dominio 08: Operaciones de Vuelo
- **Rutas**: BOG -> MIA.
- **Vuelos Base**: Vuelo `AV011` operado en la ruta BOG-MIA.
- **Segmentos/Itinerarios**: Vuelo programado para salir de Bogotá y llegar a Miami con horarios específicos asignados a la aeronave `N787AV`.

---

## 🛒 Nivel 5: Negocio y Ventas (Con Bypass de Triggers)

### Dominio 09: Ventas y Reservas
- **Configuraciones de Venta**: 
  - *Estados de Reserva*: PENDING, CONFIRMED, CANCELLED.
  - *Canales*: WEB, APP, OFFICE.
  - *Tipos de Pasajero*: ADULT, CHILD, INFANT.
  - *Clase de Tarifa*: YFLEX (Economy Flexible).
  - *Tarifa Base*: Vuelo BOG-MIA por **$350.00 USD**.
- **Transacción de Prueba Generada**:
  - Reserva `PNR-JCS77` a nombre del pasajero **Jhon Camilo Suaza**.
  - Estado: CONFIRMED. Canal: WEB.
  - Se generó la venta (SALE-1001) y el Tiquete electrónico (`134-2400000001`) asociado al asiento en el vuelo AV011.

---

## 🧳 Nivel 6: Abordaje y Finanzas

### Dominio 10: Abordaje (Boarding)
- **Configuraciones**:
  - *Grupos*: Priority Group 1 (GRP1), Economy Group 2 (GRP2).
  - *Estados*: PENDING, COMPLETED, CANCELLED.
  - *Resultados de validación*: SUCCESS, DENIED, MANUAL.
- **Transacción de Prueba Generada**:
  - Se registró el Check-in exitoso para Jhon Camilo Suaza.
  - Se generó el Boarding Pass con código `BP-JCS77-BOGMIA` y un código de barras simulado.

### Dominio 11: Pagos
- **Configuraciones**:
  - *Métodos*: CREDIT_CARD, DEBIT_CARD, PAYPAL, BANK_TRANS.
  - *Estados*: AUTHORIZED, CAPTURED, FAILED, REFUNDED.
  - *Tipos de Tx*: AUTH, CAPTURE, REFUND.
- **Transacción de Prueba Generada**:
  - Pago exitoso por **$350.00** vía Tarjeta de Crédito, en estado CAPTURED con la referencia `PAY-REF-1001`.

### Dominio 12: Facturación
- **Configuraciones**:
  - *Impuestos*: IVA_COL (19%) y SALES_TAX_US (7%).
  - *Estados de Factura*: DRAFT, ISSUED, PAID, CANCELLED.
- **Transacción de Prueba Generada**:
  - Factura comercial `INV-2026-0001` emitida y en estado PAID por el servicio de transporte BOG-MIA, aplicando el impuesto correspondiente.

---

## 🧑‍✈️ Nivel 7 y 8: Tripulación y Trazabilidad

### Dominio 13: Tripulación
- **Roles de Tripulación**: CAPTAIN, FIRST_OFFICER, PURSER, ATTENDANT.
- **Transacción de Prueba Generada**:
  - Se registró al empleado `EMP-777` (James Cook) como Miembro de Tripulación.
  - Se asignó a James Cook como el **CAPTAIN** del vuelo específico `AV011` hacia Miami.

### Dominio 14: Auditoría
- Contiene la tabla `audit_log` que rastrea todas las operaciones (DML) de inserción, actualización y borrado a través del sistema de triggers en PostgreSQL. (Los inserts de prueba fueron saltados mediante `session_replication_role = replica` para evitar conflictos durante la carga semilla).

**Explicación archivo a archivo (resumen práctico)**

- `01_dml_geografia_y_referencia.yaml`
  - `changeSet id`: "01-dml-geografia-y-referencia"
  - `author`: HU-21dev
  - Contenido: inserta time zones, continentes, países, estados/provincias, ciudades, currency (ISO codes), districts y addresses. Usa UUIDs fijos para keys.
  - Duplicado con: `01_master_basics.yaml` (mismo conjunto exacto de inserts).
  - Por qué: versión de seed creada por `HU-21dev` — probablemente una copia o reubicación del mismo seed.

- `01_master_basics.yaml`
  - `changeSet id`: "master-basics-1"
  - `author`: HU-16dev
  - Contenido: idéntico al de `01_dml_geografia_y_referencia.yaml` (mismos inserts para dominio geografía y algunos UUIDs ligeramente distintos en campos `currency`).
  - Rol: aparenta ser el seed "master" original; el otro archivo es una réplica/variant.

- `02_dml_aerolinea.yaml`
  - `changeSet id`: "02-dml-aerolinea" (HU-21dev)
  - Contenido: inserta aerolíneas (Avianca, American, Iberia) sin `airline_id` en algunas filas (dependen de FK a country).
  - Duplicado con: `02_statuses_and_configs.yaml` (mismo objetivo: registrar aerolíneas), pero con diferencias en si incluyen `airline_id` explícito.

- `02_statuses_and_configs.yaml`
  - `changeSet id`: "master-status-config-1" (HU-16dev)
  - Contenido: similar a `02_dml_aerolinea.yaml` pero con `airline_id` explícitos (posiblemente la versión canonical con UUIDs controlados).
  - Nota: una versión es minimal (solo códigos) y la otra tiene IDs — colisión esperada por equipos distintos.

- `03_dml_identidad.yaml`
  - `changeSet id`: "03-dml-identidad" (HU-21dev)
  - Contenido: géneros, person_type, document_type, contact_type, sample persons, person_document, person_contact.
  - Duplicado con: `03_geography.yaml` (contiene el mismo bloque de identidad/sample persons).

- `03_geography.yaml`
  - `changeSet id`: "geography-data-1" (HU-17dev)
  - Contenido: idéntico o muy parecido al de `03_dml_identidad.yaml` (géneros, tipos, sample persons). Probablemente creado por otro autor/propósito (ej.: reorganización de dominios).

- `04_dml_seguridad.yaml`
  - `changeSet id`: "04-dml-seguridad" (HU-21dev)
  - Contenido: user_status, security_role (roles canónicos: `ADMIN`,`MANAGER`,`SALES`,`PASSENGER`), security_permission, role_permission mapping, user_account sample, user_role mapping.
  - Duplicado con: `04_roles_and_permissions.yaml` (ambos insertan roles/permissions; sets diferentes: canonical vs legacy/demo).

- `04_roles_and_permissions.yaml`
  - `changeSet id`: "roles-permissions-data-1" (HU-18dev)
  - Contenido: user_status + roles `ADMIN`,`AGENT`,`CUSTOMER` (alternate/legacy set). Menos permisos y sin mappings completos.
  - Motivo: versión previa o alternativa para otro entorno (demo/legacy).

- `05_dml_clientes_lealtad.yaml` y `05_operational_data.yaml`
  - `changeSet ids`: "05-dml-clientes-lealtad" (HU-21dev) y "operational-data-1" (HU-19dev)
  - Contenido: customer_category, benefit_type, loyalty_program, loyalty_tier, sample customers, loyalty_account.
  - Relación: `05_operational_data.yaml` contiene versiones alternativas/IDs diferentes de los mismos datos; uno puede ser canonical y otro un complemento operativo.

- `06_dml_aeropuerto.yaml` hasta `14_dml_auditoria.yaml`
  - Cada archivo (06..14) contiene seeds por dominio (airports, aircraft, flight_status, reservations/sales, boarding, payments, invoicing, crew, audit).
  - Duplicidad: en general no duplicados directos fuera de los pares ya mencionados, pero varios archivos usan los mismos UUIDs referenciados (por diseño), por lo que parecen repetidos pero son referencias.

Breve interpretación práctica
- Muchas colisiones provienen de que distintos autores numeraron sus changeSets localmente (ej.: empezando en `1`) o de que hubo una reorganización donde se copiaron seeds entre archivos.
- Liquibase no falla por el mismo número mientras `author` o `filename` sean distintos — la tripleta `(id, author, filename)` es la única clave.





---