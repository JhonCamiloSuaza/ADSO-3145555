-- ROLLBACK DOMINIO 06: AEROPUERTO
DELETE FROM runway WHERE runway_id IN ('w1eebc99-9c0b-4ef8-bb6d-6bb9bd380w61', 'w1eebc99-9c0b-4ef8-bb6d-6bb9bd380w62', 'w1eebc99-9c0b-4ef8-bb6d-6bb9bd380w63');
DELETE FROM boarding_gate WHERE boarding_gate_id IN ('g1eebc99-9c0b-4ef8-bb6d-6bb9bd380g61', 'g1eebc99-9c0b-4ef8-bb6d-6bb9bd380g62', 'g1eebc99-9c0b-4ef8-bb6d-6bb9bd380g63', 'g1eebc99-9c0b-4ef8-bb6d-6bb9bd380g64');
DELETE FROM terminal WHERE terminal_id IN ('t1eebc99-9c0b-4ef8-bb6d-6bb9bd380t61', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t62', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t63');
DELETE FROM airport WHERE airport_id IN ('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a61', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a62', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a63');
