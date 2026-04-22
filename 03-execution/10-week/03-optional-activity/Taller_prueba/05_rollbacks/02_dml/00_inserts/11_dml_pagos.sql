-- ROLLBACK DOMINIO 11: PAGOS
DELETE FROM refund;
DELETE FROM payment_transaction WHERE payment_transaction_id IN ('z1eebc99-9c0b-4ef8-bb6d-6bb9bd380z11');
DELETE FROM payment WHERE payment_id IN ('p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p11');
DELETE FROM payment_transaction_type WHERE payment_transaction_type_id IN ('t1eebc99-9c0b-4ef8-bb6d-6bb9bd380t11', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t12', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t13', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t14');
DELETE FROM payment_method WHERE payment_method_id IN ('m1eebc99-9c0b-4ef8-bb6d-6bb9bd380m11', 'm1eebc99-9c0b-4ef8-bb6d-6bb9bd380m12', 'm1eebc99-9c0b-4ef8-bb6d-6bb9bd380m13', 'm1eebc99-9c0b-4ef8-bb6d-6bb9bd380m14');
DELETE FROM payment_status WHERE payment_status_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s11', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s12', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s13', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s14');
