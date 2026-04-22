-- ROLLBACK DOMINIO 05: CLIENTES Y LEALTAD
DELETE FROM loyalty_account WHERE loyalty_account_id IN ('m1eebc99-9c0b-4ef8-bb6d-6bb9bd380m51', 'm1eebc99-9c0b-4ef8-bb6d-6bb9bd380m52');
DELETE FROM customer WHERE customer_id IN ('k1eebc99-9c0b-4ef8-bb6d-6bb9bd380k51', 'k1eebc99-9c0b-4ef8-bb6d-6bb9bd380k52');
DELETE FROM loyalty_tier WHERE loyalty_tier_id IN ('t1eebc99-9c0b-4ef8-bb6d-6bb9bd380t51', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t52', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t53', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t54', 't1eebc99-9c0b-4ef8-bb6d-6bb9bd380t55');
DELETE FROM loyalty_program WHERE loyalty_program_id IN ('l1eebc99-9c0b-4ef8-bb6d-6bb9bd380l51', 'l1eebc99-9c0b-4ef8-bb6d-6bb9bd380l52');
DELETE FROM benefit_type WHERE benefit_type_id IN ('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b51', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b52', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b53');
DELETE FROM customer_category WHERE customer_category_id IN ('c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c51', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c52', 'c1eebc99-9c0b-4ef8-bb6d-6bb9bd380c53');
