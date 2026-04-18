-- Rollback de Geografía (HU-17)
DELETE FROM currency WHERE iso_currency_code IN ('COP', 'USD', 'EUR', 'GBP', 'MXN');
DELETE FROM country WHERE iso_alpha2 IN ('CO', 'US', 'ES', 'BR', 'FR', 'GB', 'MX', 'AR', 'CL', 'PE');
DELETE FROM continent;
