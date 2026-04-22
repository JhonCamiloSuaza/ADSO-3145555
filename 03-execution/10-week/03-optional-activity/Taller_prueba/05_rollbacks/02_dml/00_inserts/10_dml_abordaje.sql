-- ROLLBACK DOMINIO 10: ABORDAJE
DELETE FROM boarding_validation;
DELETE FROM boarding_pass WHERE boarding_pass_id IN ('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b11');
DELETE FROM check_in WHERE check_in_id IN ('k1eebc99-9c0b-4ef8-bb6d-6bb9bd380k10');
DELETE FROM validation_result WHERE validation_result_id IN ('v1eebc99-9c0b-4ef8-bb6d-6bb9bd380v10', 'v1eebc99-9c0b-4ef8-bb6d-6bb9bd380v11', 'v1eebc99-9c0b-4ef8-bb6d-6bb9bd380v12');
DELETE FROM check_in_status WHERE check_in_status_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s10', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s11', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s12');
DELETE FROM boarding_group WHERE boarding_group_id IN ('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a10', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b10', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c10', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d10', 'e1eebc99-9c0b-4ef8-bb6d-6bb9bd380e10');
