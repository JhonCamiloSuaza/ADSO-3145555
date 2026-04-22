-- ROLLBACK DOMINIO 12: FACTURACIÓN
DELETE FROM invoice_line WHERE invoice_line_id IN ('l1eebc99-9c0b-4ef8-bb6d-6bb9bd380l12');
DELETE FROM invoice WHERE invoice_id IN ('i1eebc99-9c0b-4ef8-bb6d-6bb9bd380i12');
DELETE FROM invoice_status WHERE invoice_status_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s12', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s13', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s14', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s15');
DELETE FROM exchange_rate;
DELETE FROM tax WHERE tax_id IN ('t1eebc99-9c0b-4ef8-bb6d-6bb9bd380t12', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t13');
