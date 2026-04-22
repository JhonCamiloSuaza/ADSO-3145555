-- ROLLBACK DOMINIO 09: VENTAS Y RESERVAS
DELETE FROM baggage;
DELETE FROM seat_assignment;
DELETE FROM ticket_segment WHERE ticket_segment_id IN ('z1eebc99-9c0b-4ef8-bb6d-6bb9bd380z91');
DELETE FROM ticket WHERE ticket_id IN ('k1eebc99-9c0b-4ef8-bb6d-6bb9bd380k91');
DELETE FROM sale WHERE sale_id IN ('x1eebc99-9c0b-4ef8-bb6d-6bb9bd380x91');
DELETE FROM reservation_passenger WHERE reservation_passenger_id IN ('l1eebc99-9c0b-4ef8-bb6d-6bb9bd380l91');
DELETE FROM reservation WHERE reservation_id IN ('r1eebc99-9c0b-4ef8-bb6d-6bb9bd380r91');
DELETE FROM passenger_type WHERE passenger_type_id IN ('p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p91', 'p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p92', 'p1eebc99-9c0b-4ef8-bb6d-6bb9bd380p93');
DELETE FROM ticket_status WHERE ticket_status_id IN ('t1eebc99-9c0b-4ef8-bb6d-6bb9bd380t91', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t92', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t93');
DELETE FROM fare WHERE fare_id IN ('e1eebc99-9c0b-4ef8-bb6d-6bb9bd380e91');
DELETE FROM fare_class WHERE fare_class_id IN ('f1eebc99-9c0b-4ef8-bb6d-6bb9bd380f91', 'f1eebc99-9c0b-4ef8-bb6d-6bb9bd380f92');
DELETE FROM sale_channel WHERE sale_channel_id IN ('c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c91', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c92', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c93');
DELETE FROM reservation_status WHERE reservation_status_id IN ('s1eebc99-9c0b-4ef8-bb6d-6bb9bd380s91', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s92', 's1eebc99-9c0b-4ef8-bb6d-6bb9bd380s93');
DELETE FROM baggage_status;
DELETE FROM baggage_type;
DELETE FROM assignment_source;
