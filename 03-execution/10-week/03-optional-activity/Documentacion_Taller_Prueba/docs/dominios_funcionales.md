# Análisis de Dominios Funcionales - Proyecto Aeronáutico

## ¿Qué es un dominio funcional?
Imagina que una empresa es una casa grande. Dentro de esa casa hay cuartos: uno es la cocina, otro el dormitorio, otro la sala. Cada cuarto tiene su propio propósito y sus propias cosas. En bases de datos, esos "cuartos" se llaman **dominios funcionales**: son grupos de tablas que trabajan juntas para resolver una necesidad específica del negocio.

En este modelo hemos identificado **13 dominios funcionales (12 base y 1 de ampliación técnica)** bien definidos y orquestados.

---

## 1. Geografía y Datos de Referencia
**Tablas:** `country`, `city`, `address`, `currency`, `time_zone`
*   **¿Para qué sirve?**: Es el "diccionario de ubicaciones". Provee la estructura espacial necesaria para el resto del sistema.
*   **Ejemplo**: Para registrar el aeropuerto El Dorado, el sistema valida la cadena: Colombia → Cundinamarca → Bogotá → Avenida El Dorado.
*   **Análisis Técnico**: La jerarquía está normalizada en cadena. Incluye validaciones `CHECK` en latitud y longitud para asegurar datos reales.
*   **Relación Clave**: Casi todos los dominios (Aeropuerto, Aerolínea, Identidad) dependen de este para definir su ubicación legal o física.

---

## 2. Aerolínea
**Tablas:** `airline`, `airline_network`
*   **¿Para qué sirve?**: Guarda la información básica de las operadoras. Es la entidad raíz de la operación comercial.
*   **Ejemplo**: Avianca (IATA: AV) u Iberia (ICAO: IBE). 
*   **Análisis Técnico**: Uso estricto de restricciones `UNIQUE` y `CHECK` en códigos internacionales para evitar colisiones de datos.
*   **Relación Clave**: Orquesta los dominios de Aeronaves y Operaciones; sin una aerolínea, no hay vuelos que programar.

---

## 3. Identidad
**Tablas:** `person`, `document_type`, `gender`, `person_contact`
*   **¿Para qué sirve?**: El "registro civil" del sistema. Gestiona los datos maestros de todos los seres humanos (pasajeros o empleados).
*   **Análisis Técnico**: Uso de tablas de referencia para `gender` y `document_type`, lo que facilita la escalabilidad sin alterar la estructura DDL.
*   **Relación Clave**: Es la base para los dominios de **Seguridad** y **Clientes**. No puedes ser usuario del sistema si no eres primero una Persona.

---

## 4. Seguridad (Control de Acceso)
**Tablas:** `user_account`, `security_role`, `security_permission`, `role_permission`
*   **¿Para qué sirve?**: Implementa el modelo RBAC (Control de Acceso Basado en Roles) para proteger la integridad de la información.
*   **Ejemplo**: Un "Agente de Ventas" puede crear reservas, pero no puede anular "Facturas" (permiso restringido).
*   **Análisis Técnico**: Separación total entre identidad y acceso. Uso de `password_hash` para seguridad criptográfica.
*   **Relación Clave**: Se vincula 1:1 con **Identidad**. Garantiza que cada acción registrada en la DB tenga un responsable rastreable.

---

## 5. Clientes y Fidelización
**Tablas:** `customer`, `loyalty_account`, `miles_transaction`
*   **¿Para qué sirve?**: Gestión relacional y programas de millas.
*   **Análisis Técnico**: El saldo de millas no es un campo fijo (evita inconsistencias); se calcula dinámicamente mediante el historial de transacciones.
*   **Relación Clave**: Depende de **Identidad** y se alimenta directamente del dominio de **Ventas**.

---

## 6. Aeropuerto
**Tablas:** `airport`, `terminal`, `boarding_gate`, `runway`
*   **¿Para qué sirve?**: Gestionar la infraestructura física de los nodos de transporte.
*   **Análisis Técnico**: Jerarquía física clara (`airport → terminal → gate`) que facilita el flujo lógico para el abordaje.
*   **Relación Clave**: Es la ubicación de origen y destino para el dominio de **Operaciones de Vuelo**.

---

## 7. Aeronaves
**Tablas:** `aircraft`, `aircraft_model`, `aircraft_seat`, `maintenance_event`
*   **¿Para qué sirve?**: Gestión de activos físicos (aviones) y su estado técnico/configuración.
*   **Análisis Técnico**: Modelo de asientos detallado (`is_window`, `is_exit_row`) para personalización en ventas.
*   **Relación Clave**: Depende de **Aerolínea** (propietaria) y provee el inventario físico para **Ventas**.

---

## 8. Operaciones de Vuelo
**Tablas:** `flight`, `flight_segment`, `flight_status`, `flight_delay`
*   **¿Para qué sirve?**: El motor transaccional que programa itinerarios y registra el estado real de los vuelos.
*   **Análisis Técnico**: Soporta vuelos con escalas separando la intención de viaje (`flight`) del tramo físico (`flight_segment`).
*   **Relación Clave**: Es el centro del modelo; une a **Aeronaves**, **Aeropuertos** y **Aerolíneas** en una fecha específica.

---

## 9. Ventas y Reservas
**Tablas:** `reservation`, `sale`, `ticket`, `seat_assignment`, `baggage`
*   **¿Para qué sirve?**: Gestionar el ciclo comercial, desde la reserva de un asiento hasta el despacho del equipaje.
*   **Análisis Técnico**: Diseño en 3FN que elimina redundancias en la asignación de asientos mediante tablas puente eficientes.
*   **Relación Clave**: Su éxito depende de la disponibilidad en **Operaciones** y genera la obligación para el dominio de **Pagos**.

---

## 10. Abordaje
**Tablas:** `check_in`, `boarding_pass`, `boarding_validation`
*   **¿Para qué sirve?**: Control del flujo del pasajero en tierra para garantizar que solo personas autorizadas suban al avión.
*   **Análisis Técnico**: Restricciones de unicidad estricta para evitar que un Check-in se use dos veces.
*   **Relación Clave**: Valida un Ticket emitido por el dominio de **Ventas** contra una Puerta del dominio de **Aeropuerto**.

---

## 11. Pagos
**Tablas:** `payment`, `payment_transaction`, `refund`
*   **¿Para qué sirve?**: Control contable de ingresos, transacciones bancarias y reembolsos.
*   **Análisis Técnico**: Uso de `payment_transaction` como log de eventos financieros (Auth, Capture, Void).
*   **Relación Clave**: Vinculado directamente a **Ventas**; es el disparador para la emisión legal de la factura.

---

## 12. Facturación
**Tablas:** `invoice`, `invoice_line`, `tax`, `exchange_rate`
*   **¿Para qué sirve?**: Formalización fiscal y legal de la transacción económica.
*   **Análisis Técnico**: Aplicación de impuestos con fechas de vigencia y soporte para múltiples monedas mediante tasas de cambio históricas.
*   **Relación Clave**: Cierra el ciclo comercial iniciado en **Ventas** y consolidado en **Pagos**.

---

## 13. Tripulación (Ampliación Técnica - ADR-001)
**Tablas:** `crew_member`, `crew_role`, `flight_crew_assignment`
*   **¿Para qué sirve?**: Gestión del personal operativo obligatorio (Pilotos, Auxiliares) para la validez legal del vuelo.
*   **Análisis Técnico**: Separación de empleados técnicos de pasajeros, permitiendo auditar licencias y roles específicos por tramo de vuelo.
*   **Relación Clave**: Depende de **Identidad** (Persona) y de **Operaciones** (Vuelo asignado). Es vital para la seguridad operativa.

---

## Resumen de los 13 Dominios

| # | Dominio | Propósito | Relación Más Importante |
|---|---------|-----------|-------------------------|
| 1 | Geografía | Ubicaciones base | Es el cimiento de todo el modelo |
| 2 | Aerolínea | Operadoras aéreas | Dueña de aviones y rutas |
| 3 | Identidad | Registro de personas | Base para usuarios y clientes |
| 4 | Seguridad | Roles y Permisos | Protege la integridad de los datos |
| 5 | Clientes | Fidelización | Fideliza la venta recurrente |
| 6 | Aeropuerto | Infraestructura | Punto de salida y llegada |
| 7 | Aeronaves | Flota y mantenimiento | Define el inventario de asientos |
| 8 | Operaciones | Itinerarios | Motor que une aeropuerto y avión |
| 9 | Ventas | Transacciones | Genera el ingreso del negocio |
| 10 | Abordaje | Control en tierra | Valida el ticket en la puerta |
| 11 | Pagos | Flujo monetario | Convierte la reserva en ingreso real |
| 12 | Facturación | Documentos legales | Soporte fiscal de la operación |
| 13 | **Tripulación** | **Habilitación de vuelo** | **Garantiza personal técnico a bordo** |
