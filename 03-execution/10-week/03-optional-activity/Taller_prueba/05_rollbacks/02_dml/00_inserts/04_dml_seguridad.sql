-- ROLLBACK DOMINIO 04: SEGURIDAD
DELETE FROM user_role WHERE user_account_id IN ('u1eebc99-9c0b-4ef8-bb6d-6bb9bd380u41');
DELETE FROM user_account WHERE user_account_id IN ('u1eebc99-9c0b-4ef8-bb6d-6bb9bd380u41');
DELETE FROM role_permission WHERE security_role_id IN ('r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r41', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r42', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r43', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r44');
DELETE FROM security_permission WHERE security_permission_id IN ('p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p41', 'p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p42', 'p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p43', 'p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p44', 'p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p45');
DELETE FROM security_role WHERE security_role_id IN ('r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r41', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r42', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r43', 'r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r44');
DELETE FROM user_status WHERE user_status_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s41', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s42', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s43');
