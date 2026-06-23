-- =============================================
-- DOMINIO: AUDITORIA Y LOGS
-- =============================================

-- TABLA: RegistroActividad
CREATE TABLE RegistroActividad (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UsuarioID UUID REFERENCES Usuario(ID),
    TipoAccion VARCHAR(50) NOT NULL,
    Descripcion TEXT,
    IpOrigen INET,
    Metadatos JSONB,
    CreadoEn TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- TABLA: RegistroAuditoria
CREATE TABLE RegistroAuditoria (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UsuarioID UUID REFERENCES Usuario(ID),
    Accion VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    IpOrigen INET,
    Aplicacion VARCHAR(100) DEFAULT 'GPS_Guardian',
    Metadatos JSONB,
    CreadoEn TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- TABLA: RegistroError
CREATE TABLE RegistroError (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UsuarioID UUID REFERENCES Usuario(ID),
    TipoError VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    TrazaError TEXT,
    IpOrigen INET,
    Metadatos JSONB,
    CreadoEn TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
