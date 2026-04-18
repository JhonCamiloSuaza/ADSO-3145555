-- Rollback de Roles y Permisos (HU-18)
DELETE FROM role_permission;
DELETE FROM security_permission;
DELETE FROM security_role;
DELETE FROM user_status;
