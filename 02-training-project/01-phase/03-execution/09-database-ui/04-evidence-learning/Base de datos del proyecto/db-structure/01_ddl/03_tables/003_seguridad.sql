-- =============================================
-- DOMINIO: SEGURIDAD Y ACCESO
-- =============================================

-- TABLA: Rol
CREATE TABLE Rol (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    NombreRol nombre_rol_enum UNIQUE NOT NULL,
    Descripcion VARCHAR(255),
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);


-- TABLA: Permiso
CREATE TABLE Permiso (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    NombrePermiso VARCHAR(100) UNIQUE NOT NULL,
    Descripcion TEXT,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);


-- TABLA: Usuario_Rol
CREATE TABLE Usuario_Rol (
    UsuarioID UUID NOT NULL REFERENCES Usuario(ID) ON DELETE CASCADE,
    RolID UUID NOT NULL REFERENCES Rol(ID) ON DELETE CASCADE,
    AsignadoEn TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (UsuarioID, RolID)
);


-- TABLA: Rol_Permiso
CREATE TABLE Rol_Permiso (
    RolID UUID NOT NULL REFERENCES Rol(ID) ON DELETE CASCADE,
    PermisoID UUID NOT NULL REFERENCES Permiso(ID) ON DELETE CASCADE,
    PRIMARY KEY (RolID, PermisoID)
);


-- TABLA: SesionUsuario
CREATE TABLE SesionUsuario (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UsuarioID UUID NOT NULL REFERENCES Usuario(ID) ON DELETE CASCADE,
    Token VARCHAR(500) NOT NULL,
    InicioSesion TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FinSesion TIMESTAMPTZ,
    IpOrigen INET,
    EstadoSesion estado_sesion_enum DEFAULT 'ACTIVA',
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);


-- TABLA: PoliticaContrasena
CREATE TABLE PoliticaContrasena (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    LongitudMinima INT DEFAULT 10,
    LongitudMaxima INT DEFAULT 128,
    RequiereMayusculas BOOLEAN DEFAULT true,
    RequiereNumeros BOOLEAN DEFAULT true,
    RequiereSimbolos BOOLEAN DEFAULT true,
    DiasExpiracion INT DEFAULT 90,
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);


-- TABLA: ConfiguracionSeguridad
CREATE TABLE ConfiguracionSeguridad (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    NombreConfig VARCHAR(100) UNIQUE NOT NULL,
    ValorConfig TEXT,
    Descripcion TEXT,
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);
