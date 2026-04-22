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

-- 4. Verificación del Check-in y el Pase de Abordar (creado por el trigger)
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
