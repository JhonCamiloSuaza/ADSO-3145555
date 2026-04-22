-- ROLLBACK DOMINIO 07: AERONAVE
DELETE FROM maintenance_type WHERE maintenance_type_id IN ('u1eebc99-9c0b-4ef8-bb6d-6bb9bd380u71', 'u1eebc99-9c0b-4ef8-bb6d-6bb9bd380u72');
DELETE FROM maintenance_status WHERE maintenance_status_id IN ('t1eebc99-9c0b-4ef8-bb6d-6bb9bd380t71', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t72', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t73');
DELETE FROM aircraft_seat WHERE aircraft_seat_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s71', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s72', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s73');
DELETE FROM aircraft_cabin WHERE aircraft_cabin_id IN ('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b71', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b72');
DELETE FROM aircraft WHERE aircraft_id IN ('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a71', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a72');
DELETE FROM cabin_class WHERE cabin_class_id IN ('c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c71', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c72', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c73', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c74');
DELETE FROM aircraft_model WHERE aircraft_model_id IN ('o1eebc99-9c0b-4ef8-bb6d-6bb9bd380o71', 'o1eebc99-9c0b-4ef8-bb6d-6bb9bd380o72', 'o1eebc99-9c0b-4ef8-bb6d-6bb9bd380o73', 'o1eebc99-9c0b-4ef8-bb6d-6bb9bd380o74');
DELETE FROM aircraft_manufacturer WHERE aircraft_manufacturer_id IN ('m1eebc99-9c0b-4ef8-bb6d-6bb9bd380m71', 'm1eebc99-9c0b-4ef8-bb6d-6bb9bd380m72', 'm1eebc99-9c0b-4ef8-bb6d-6bb9bd380m73');
