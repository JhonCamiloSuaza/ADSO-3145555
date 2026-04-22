-- ROLLBACK DOMINIO 01: GEOGRAFIA Y REFERENCIA (DML)
DELETE FROM baggage_status WHERE status_code IN ('REGISTERED', 'LOADED', 'CLAIMED', 'LOST');
DELETE FROM baggage_type WHERE type_code IN ('CARRY_ON', 'CHECKED', 'SPECIAL');
DELETE FROM passenger_type WHERE type_code IN ('ADULT', 'CHILD', 'INFANT');
DELETE FROM contact_type WHERE type_code IN ('EMAIL', 'PHONE', 'HOME');
DELETE FROM document_type WHERE type_code IN ('PASSPORT', 'ID', 'VISA');
DELETE FROM person_type WHERE type_code IN ('PAX', 'EMP', 'CREW');
DELETE FROM gender WHERE gender_code IN ('M', 'F', 'X', 'U');
DELETE FROM address WHERE address_id IN ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a31', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a32', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33');
DELETE FROM district WHERE district_id IN ('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f21', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f22', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f23');
DELETE FROM currency WHERE iso_currency_code IN ('USD', 'EUR', 'COP');
DELETE FROM city WHERE city_id IN ('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e11', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e12', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e13');
DELETE FROM state_province WHERE state_province_id IN ('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d11', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380d12', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380d13');
DELETE FROM country WHERE country_id IN ('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c13');
DELETE FROM continent WHERE continent_id IN ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13');
DELETE FROM time_zone WHERE time_zone_id IN ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13');
