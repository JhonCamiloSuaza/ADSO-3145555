-- =============================================
-- 0. ENUMS (Tipos de datos enumerados)
-- =============================================

-- Grados escolares disponibles
CREATE TYPE grado_escolar_enum AS ENUM (
    'PRE_KINDER',      -- Pre-Kínder
    'KINDER',          -- Kínder
    'TRANSICION',      -- Transición
    'PRIMERO',         -- Primero básico
    'SEGUNDO',         -- Segundo básico
    'TERCERO',         -- Tercero básico
    'CUARTO',          -- Cuarto básico
    'QUINTO',          -- Quinto básico
    'SEXTO',           -- Sexto básico
    'SEPTIMO',         -- Séptimo básico
    'OCTAVO',          -- Octavo básico
    'NOVENO',          -- Noveno básico
    'DECIMO',          -- Décimo básico
    'UNDECIMO'         -- Undécimo básico
);

-- Estados posibles de un trayecto
CREATE TYPE estado_trayecto_enum AS ENUM (
    'PENDIENTE',     -- Pendiente
    'EN_CURSO',      -- En progreso
    'COMPLETADO',    -- Completado
    'CANCELADO'      -- Cancelado
);

-- Estados de sesión de usuario
CREATE TYPE estado_sesion_enum AS ENUM (
    'ACTIVA',    -- Activa
    'EXPIRADA',  -- Expirada
    'CERRADA'    -- Cerrada sesión
);

-- Roles del sistema
CREATE TYPE nombre_rol_enum AS ENUM (
    'ADMIN',    -- Administrador
    'PADRE'     -- Padre/Madre de familia
);


