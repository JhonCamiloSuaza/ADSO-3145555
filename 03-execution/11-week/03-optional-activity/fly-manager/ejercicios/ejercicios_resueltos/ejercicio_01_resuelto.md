# Ejercicio 01 Resuelto - Flujo de check-in y trazabilidad comercial del pasajero

# Modelo de datos base del sistema

## 1. Descripción general del modelo
El modelo de datos corresponde a un sistema integral de aerolínea, diseñado para soportar de forma relacional los procesos principales del negocio: gestión geográfica, identidad de personas, seguridad, clientes, fidelización, aeropuertos, aeronaves, operación de vuelos, reservas, tiquetes, abordaje, pagos y facturación.

Se trata de un modelo amplio y normalizado, en el que las entidades están separadas por dominios funcionales y conectadas mediante llaves foráneas para garantizar trazabilidad, integridad y consistencia en todo el flujo operativo y comercial.

---

## 2. Resumen previo del análisis realizado
Como base de trabajo, previamente se identificó y organizó el script en dominios funcionales. A partir de esa revisión, se determinó que el modelo no corresponde a un caso pequeño o aislado, sino a una solución empresarial con múltiples áreas del negocio conectadas entre sí.

También se verificó que:
- el modelo contiene más de 60 entidades,
- las relaciones entre tablas siguen una estructura consistente,
- existen restricciones de integridad mediante `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` y `CHECK`,
- el diseño soporta trazabilidad end-to-end desde la reserva hasta el pago, abordaje y facturación.

---

## 3. Dominios del modelo y propósito general

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency`  
**Resumen:** Centraliza información geográfica y de referencia para ubicar aeropuertos, personas, proveedores y definir monedas operativas del sistema.

### AIRLINE
**Entidades:** `airline`  
**Resumen:** Representa la aerolínea operadora del sistema, incluyendo sus códigos y país base.

### IDENTITY
**Entidades:** `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact`  
**Resumen:** Permite modelar la identidad de las personas, sus documentos y medios de contacto.

### SECURITY
**Entidades:** `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission`  
**Resumen:** Administra autenticación, autorización y control de acceso al sistema.

### CUSTOMER AND LOYALTY
**Entidades:** `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `loyalty_account_tier`, `miles_transaction`, `customer_benefit`  
**Resumen:** Gestiona clientes, programas de fidelización, acumulación de millas, beneficios y niveles.

### AIRPORT
**Entidades:** `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation`  
**Resumen:** Modela la infraestructura aeroportuaria y las condiciones regulatorias asociadas a cada aeropuerto.

### AIRCRAFT
**Entidades:** `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_provider`, `maintenance_type`, `maintenance_event`  
**Resumen:** Gestiona aeronaves, fabricantes, configuración interna y procesos de mantenimiento.

### FLIGHT OPERATIONS
**Entidades:** `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay`  
**Resumen:** Controla la operación de vuelos, sus segmentos, estados y retrasos.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation_status`, `sale_channel`, `fare_class`, `fare`, `ticket_status`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage`  
**Resumen:** Gestiona el flujo comercial principal: reserva, pasajero, venta, emisión de tiquetes, asignación de asiento y equipaje.

### BOARDING
**Entidades:** `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation`  
**Resumen:** Soporta el proceso de check-in, emisión de pase de abordar y validación final de embarque.

### PAYMENT
**Entidades:** `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund`  
**Resumen:** Administra pagos, transacciones y devoluciones asociadas a las ventas.

### BILLING
**Entidades:** `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line`  
**Resumen:** Gestiona impuestos, tasas de cambio, facturas y detalle facturable.

---

## 4. Restricción general para todos los ejercicios
Todos los ejercicios se resuelven respetando estrictamente el modelo entregado.

No se cambia:
- ningún atributo existente,
- nombres de tablas o columnas,
- relaciones del modelo,
- ni la estructura general del script base.

---

## 5. Contexto del ejercicio
La aerolínea requiere fortalecer la trazabilidad operativa del proceso de abordaje, desde la reserva del pasajero hasta la emisión del pase de abordar. Para ello, se necesita consultar información consolidada del flujo comercial y automatizar parte del proceso de check-in mediante lógica en base de datos.

---

## 6. Dominios involucrados
### SALES, RESERVATION, TICKETING
**Entidades:** `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`  
**Propósito en este ejercicio:** Gestionar el flujo comercial principal del sistema y la relación entre reserva, pasajero y tiquete.

### FLIGHT OPERATIONS
**Entidades:** `flight`, `flight_segment`, `flight_status`  
**Propósito en este ejercicio:** Relacionar los tiquetes con la operación real del vuelo y sus segmentos.

### IDENTITY
**Entidades:** `person`  
**Propósito en este ejercicio:** Identificar al pasajero asociado a la reserva.

### BOARDING
**Entidades:** `check_in`, `check_in_status`, `boarding_group`, `boarding_pass`  
**Propósito en este ejercicio:** Gestionar el proceso de registro previo al abordaje y la emisión del pase de abordar.

### SECURITY
**Entidades:** `user_account`  
**Propósito en este ejercicio:** Identificar el usuario que registra el check-in.

---

## 7. Problema a resolver
La aerolínea desea consultar qué pasajeros ya se encuentran asociados a reservas y tiquetes válidos para un vuelo determinado, y adicionalmente automatizar la creación del pase de abordar cuando se registra un check-in. Si el check-in se hace manualmente y no se automatiza la creación del boarding pass, se pueden generar inconsistencias en la puerta de embarque.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `check_in`,
3. un procedimiento almacenado que centralice el registro del check-in.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se estructuró una consulta que vincula la trazabilidad comercial (reserva y tiquete) con la operativa (vuelo y segmento). 

```sql
SELECT
    r.reservation_code AS codigo_reserva,
    f.flight_number AS numero_vuelo,
    f.service_date AS fecha_servicio,
    t.ticket_number AS numero_tiquete,
    rp.passenger_sequence_no AS secuencia_pasajero,
    p.first_name || ' ' || p.last_name AS nombre_pasajero,
    fs.segment_number AS segmento_vuelo,
    fs.scheduled_departure_at AS hora_programada_salida
FROM reservation r
INNER JOIN reservation_passenger rp ON rp.reservation_id = r.reservation_id
INNER JOIN person p ON p.person_id = rp.person_id
INNER JOIN ticket t ON t.reservation_passenger_id = rp.reservation_passenger_id
INNER JOIN ticket_segment ts ON ts.ticket_id = t.ticket_id
INNER JOIN flight_segment fs ON fs.flight_segment_id = ts.flight_segment_id
INNER JOIN flight f ON f.flight_id = fs.flight_id
ORDER BY f.service_date DESC, r.reservation_code;
```

### 8.2 Explicación paso a paso de la consulta
1. **`reservation`** aporta el código centralizador de la compra.
2. **`reservation_passenger`** conecta la reserva con el listado de pasajeros.
3. **`person`** aporta el nombre y apellido reales del pasajero.
4. **`ticket`** es el documento comercial emitido al pasajero.
5. **`ticket_segment`** desglosa el tiquete comercial en tramos de vuelo.
6. **`flight_segment`** representa el vuelo físico programado.
7. **`flight`** aporta el identificador macro del vuelo y su fecha.

Se utilizó exclusivamente `INNER JOIN` para asegurar que el listado contenga pasajeros que tienen un ciclo comercial y operativo completamente consistente (no muestra reservas sin tiquetes emitidos).

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se seleccionó un trigger `AFTER INSERT ON check_in` porque la creación del pase de abordar (`boarding_pass`) es una consecuencia directa y obligatoria del proceso de check-in.

### 9.2 Lógica implementada
- Al insertarse un nuevo check-in, se asume que el pasajero ya está listo para recibir su pase.
- Se genera un código de pase de abordar y un código de barras de manera dinámica.
- Se inserta el nuevo registro en la tabla `boarding_pass` apuntando al `check_in_id` recién creado (referenciado como `NEW.check_in_id`).

### 9.3 Script del trigger
```sql
DROP TRIGGER IF EXISTS trg_ai_check_in_create_boarding_pass ON check_in;
DROP FUNCTION IF EXISTS fn_ai_check_in_create_boarding_pass();

CREATE OR REPLACE FUNCTION fn_ai_check_in_create_boarding_pass()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_boarding_pass_code varchar(20);
BEGIN
    -- Generar un código de pase de abordar dinámico
    v_boarding_pass_code := 'BP-' || upper(replace(left(NEW.check_in_id::text, 8), '-', ''));
    
    INSERT INTO boarding_pass (
        check_in_id,
        boarding_pass_code,
        barcode_value,
        issued_at
    )
    VALUES (
        NEW.check_in_id,
        v_boarding_pass_code,
        'BARCODE-' || gen_random_uuid()::text,
        now()
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_check_in_create_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_ai_check_in_create_boarding_pass();
```

### 9.4 Por qué esta solución es correcta
- Asegura la consistencia referencial: no puede existir un check-in sin su pase de abordar.
- Opera de manera invisible y atómica para la aplicación principal.
- Utiliza únicamente tablas reales definidas en el modelo original.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Encapsular toda la lógica de inserción de un check-in, de manera que la aplicación cliente no interactúe directamente con las tablas base.

### 10.2 Decisión técnica
Se define un procedimiento `sp_register_check_in` que recibe los parámetros mínimos operativos y delega en el trigger la finalización del flujo (el boarding pass).

### 10.3 Script del procedimiento
```sql
DROP PROCEDURE IF EXISTS sp_register_check_in(uuid, uuid, uuid, uuid, timestamptz);

CREATE OR REPLACE PROCEDURE sp_register_check_in(
    p_ticket_segment_id uuid,
    p_check_in_status_id uuid,
    p_boarding_group_id uuid,
    p_checked_in_by_user_id uuid,
    p_checked_in_at timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO check_in (
        ticket_segment_id,
        check_in_status_id,
        boarding_group_id,
        checked_in_by_user_id,
        checked_in_at
    )
    VALUES (
        p_ticket_segment_id,
        p_check_in_status_id,
        p_boarding_group_id,
        p_checked_in_by_user_id,
        p_checked_in_at
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Al llamar este procedimiento, el usuario inserta en `check_in` y, tras bastidores, se completa todo el proceso sin pasos adicionales manuales.
- Es 100% reutilizable.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_account_id uuid;
BEGIN
    -- 1. Buscar un segmento de tiquete que NO tenga check-in
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    LIMIT 1;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No se encontraron segmentos de tiquete disponibles para la prueba de check-in.';
    END IF;

    -- 2. Obtener datos auxiliares
    SELECT check_in_status_id INTO v_check_in_status_id FROM check_in_status LIMIT 1;
    SELECT boarding_group_id INTO v_boarding_group_id FROM boarding_group LIMIT 1;
    SELECT user_account_id INTO v_user_account_id FROM user_account LIMIT 1;

    -- 3. Invocar procedimiento (esto disparará el trigger que crea el boarding_pass)
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_account_id,
        now()
    );

    RAISE NOTICE 'Check-in registrado exitosamente para el segmento %', v_ticket_segment_id;
END;
$$;

-- 4. Verificación
SELECT 
    ci.checked_in_at,
    ts.segment_sequence_no,
    bp.boarding_pass_code,
    bp.barcode_value,
    bp.issued_at
FROM check_in ci
INNER JOIN ticket_segment ts ON ts.ticket_segment_id = ci.ticket_segment_id
INNER JOIN boarding_pass bp ON bp.check_in_id = ci.check_in_id
ORDER BY ci.created_at DESC
LIMIT 1;
```

### 11.1 Qué demuestra este script
1. Busca un registro válido para hacer la inserción y simula el escenario productivo.
2. Llama al procedimiento almacenado, pasándole las llaves foráneas encontradas.
3. La validación final confirma que el procedimiento insertó el `check_in` y el trigger hizo su trabajo insertando el `boarding_pass` automáticamente.

---

## 12. Validación final
La solución es válida porque:
- La consulta resuelve el requisito comercial usando `INNER JOIN`.
- El trigger cumple la función de automatizar el abordaje (`AFTER INSERT`).
- El procedimiento almacenado está listo para uso en producción.
- La base de datos es la única fuente de la verdad para esta transacción.

---

## 13. Archivo SQL relacionado
- `scripts_sql/ejercicio_01_setup.sql`
- `scripts_sql/ejercicio_01_demo.sql`
