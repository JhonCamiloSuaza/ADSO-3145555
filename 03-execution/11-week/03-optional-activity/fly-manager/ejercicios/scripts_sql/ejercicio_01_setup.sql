DROP TRIGGER IF EXISTS trg_ai_check_in_create_boarding_pass ON check_in;
DROP FUNCTION IF EXISTS fn_ai_check_in_create_boarding_pass();
DROP PROCEDURE IF EXISTS sp_register_check_in(uuid, uuid, uuid, uuid, timestamptz);

-- 1. Trigger AFTER sobre check_in
-- Automatiza la creación del pase de abordar (boarding_pass) al registrar un check-in
CREATE OR REPLACE FUNCTION fn_ai_check_in_create_boarding_pass()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_boarding_pass_code varchar(20);
BEGIN
    -- Generar un código de pase de abordar ficticio para la demostración
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

-- 2. Procedimiento Almacenado
-- Encapsula el registro del check-in
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

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
-- Requerimiento MD: reserva, pasajero, persona, tiquete, segmento_tiquete, segmento_vuelo, vuelo.
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
