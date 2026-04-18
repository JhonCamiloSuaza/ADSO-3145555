-- Rollback de Triggers de Auditoría
DROP TRIGGER IF EXISTS trg_audit_check_in ON check_in;
DROP TRIGGER IF EXISTS trg_audit_ticket ON ticket;
DROP TRIGGER IF EXISTS trg_audit_payment ON payment;
DROP TRIGGER IF EXISTS trg_audit_sale ON sale;
DROP TRIGGER IF EXISTS trg_audit_reservation ON reservation;
