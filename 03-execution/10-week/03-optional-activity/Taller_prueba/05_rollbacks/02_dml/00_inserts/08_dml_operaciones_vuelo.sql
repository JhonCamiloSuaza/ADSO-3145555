-- ROLLBACK DOMINIO 08: OPERACIONES DE VUELO
DELETE FROM flight_delay;
DELETE FROM flight_segment WHERE flight_segment_id IN ('g1eebc99-9c0b-4ef8-bb6d-6bb9bd380g81', 'g1eebc99-9c0b-4ef8-bb6d-6bb9bd380g82');
DELETE FROM flight WHERE flight_id IN ('f1eebc99-9c0b-4ef8-bb6d-6bb9bd380f81', 'f1eebc99-9c0b-4ef8-bb6d-6bb9bd380f82');
DELETE FROM delay_reason_type WHERE delay_reason_type_id IN ('d1eebc99-9c0b-4ef8-bb6d-6bb9bd380d81', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d82', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d83', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d84');
DELETE FROM flight_status WHERE flight_status_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s81', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s82', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s83', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s84', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s85', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s86', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s87');
