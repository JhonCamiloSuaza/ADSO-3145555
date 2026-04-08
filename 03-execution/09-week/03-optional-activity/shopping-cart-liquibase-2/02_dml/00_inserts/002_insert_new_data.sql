-- Inserts for inventory.brand
INSERT INTO inventory.brand (name, description, created_by)
VALUES
('Apple', 'Consumer electronics, software and online services.', 'system'),
('Samsung', 'Specializes in various electronics and industry industries.', 'system'),
('Sony', 'Diverse range of consumer and professional electronics.', 'system'),
('Nike', 'Footwear, apparel, equipment, and accessories.', 'system'),
('Adidas', 'Shoes, clothing and accessories.', 'system');

-- Inserts for bill.payment_method (Colombian Banks and Cash)
INSERT INTO bill.payment_method (name, description, created_by)
VALUES
('EFECTIVO', 'Pago en efectivo en el momento de la entrega o en punto físico.', 'system'),
('DAVIVIENDA', 'Transferencia o pago a través de Banco Davivienda.', 'system'),
('DAVIPLATA', 'Pago a través de la billetera digital Daviplata.', 'system'),
('BBVA', 'Transferencia o pago a través de Banco BBVA.', 'system'),
('BANCO_DE_BOGOTA', 'Transferencia o pago a través de Banco de Bogotá.', 'system'),
('BANCO_AGRARIO', 'Transferencia o pago a través de Banco Agrario.', 'system');
