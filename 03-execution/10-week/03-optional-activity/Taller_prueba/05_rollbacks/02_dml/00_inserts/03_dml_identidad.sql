-- ROLLBACK DOMINIO 03: IDENTIDAD
DELETE FROM person_contact WHERE person_id IN ('d1eebc99-9c0b-4ef8-bb6d-6bb9bd380d21');
DELETE FROM person_document WHERE person_id IN ('d1eebc99-9c0b-4ef8-bb6d-6bb9bd380d21');
DELETE FROM person WHERE person_id IN ('d1eebc99-9c0b-4ef8-bb6d-6bb9bd380d21', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d22', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d23', 'd1eebc99-9c0b-4ef8-bb6d-6bb9bd380d24');
DELETE FROM contact_type WHERE contact_type_id IN ('c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c21', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c22', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c23');
DELETE FROM document_type WHERE document_type_id IN ('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b23');
DELETE FROM person_type WHERE person_type_id IN ('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a23');
DELETE FROM gender WHERE gender_id IN ('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f11', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f12', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f13', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f14');
