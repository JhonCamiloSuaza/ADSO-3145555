-- ROLLBACK DOMINIO 13: TRIPULACIÓN
DELETE FROM flight_crew_assignment WHERE assignment_id IN ('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a13');
DELETE FROM crew_member WHERE crew_member_id IN ('m1eebc99-9c0b-4ef8-bb6d-6bb9bd380m13');
DELETE FROM crew_role WHERE crew_role_id IN ('r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r13', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r14', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r15', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r16');
