DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'gps_guardian_app') THEN
        CREATE ROLE gps_guardian_app NOLOGIN;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'gps_guardian_readonly') THEN
        CREATE ROLE gps_guardian_readonly NOLOGIN;
    END IF;
END $$;
