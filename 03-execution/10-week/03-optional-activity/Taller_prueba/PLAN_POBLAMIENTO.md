# Plan de Poblamiento de Datos (Seeding Plan)

Este documento detalla la estrategia y el orden lógico para el cargue de datos iniciales (master data y datos de prueba) en la base de datos del Taller Integrador.

## 1. Estrategia de Carga
Para garantizar el cumplimiento de las restricciones de integridad (Foreign Keys), los datos se cargan en niveles de dependencia. No se puede cargar una entidad hija sin que su padre exista previamente.

## 2. Niveles de Dependencia (Orden de Ejecución)

### Nivel 1: Catálogos Independientes (Basics)
Son tablas que no dependen de ninguna otra.
1.  **Género (`gender`)**: Necesario para crear personas.
2.  **Continente (`continent`)**: Base de la geografía.
3.  **Moneda (`currency`)**: Necesaria para tarifas y pagos.
4.  **Tipos (`*_type`)**: `person_type`, `document_type`, `contact_type`, `passenger_type`, `baggage_type`.

### Nivel 2: Estados y Configuraciones de Negocio
Tablas que definen el ciclo de vida de los procesos.
1.  **Estados (`*_status`)**: `flight_status`, `payment_status`, `reservation_status`, `check_in_status`, `ticket_status`.
2.  **Fuentes y Resultados**: `assignment_source`, `validation_result`.
3.  **Canales de Venta (`sale_channel`)**.

### Nivel 3: Estructura Geográfica (Jerárquica)
1.  **País (`country`)** -> Depende de Continent.
2.  **Estado/Provincia (`state_province`)** -> Depende de Country.
3.  **Ciudad (`city`)** -> Depende de State_Province.
4.  **Distrito (`district`)** -> Depende de City.
5.  **Dirección (`address`)** -> Depende de District.

### Nivel 4: Infraestructura y Organización
1.  **Aerolínea (`airline`)** -> Depende de Country.
2.  **Aeropuerto (`airport`)** -> Depende de Address.
3.  **Aeronave (`aircraft_manufacturer`, `aircraft_model`)**.

### Nivel 5: Datos de Prueba (Transaccionales)
*Solo después de completar los niveles 1-4 se pueden realizar inserts de personas, vuelos y reservas.*

## 3. Implementación en Liquibase
Los scripts de inserción están ubicados en la carpeta `02_dml/` y se organizan por archivos numerados según su nivel de dependencia para asegurar un despliegue trazable y ordenado.

| Archivo | Contenido |
| :--- | :--- |
| `01_master_basics.yaml` | Catálogos de identidad y equipaje. |
| `02_statuses_and_configs.yaml` | Todos los estados de flujo de negocio. |
| `03_geography.yaml` | Datos de prueba geográficos (en progreso). |

## 4. Validación técnica
Cada ChangeSet incluye una sección de `rollback` que permite limpiar los datos de manera granular en caso de errores durante el despliegue.
