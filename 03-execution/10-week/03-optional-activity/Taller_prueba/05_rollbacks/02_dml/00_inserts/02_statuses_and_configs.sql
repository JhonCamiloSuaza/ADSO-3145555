-- Rollback de Estados y Configuraciones (HU-16)
DELETE FROM validation_result;
DELETE FROM assignment_source;
DELETE FROM ticket_status;
DELETE FROM check_in_status;
DELETE FROM reservation_status;
DELETE FROM payment_status;
DELETE FROM flight_status;
