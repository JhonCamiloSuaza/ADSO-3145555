-- =============================================
-- DOMINIO: TRAYECTOS Y TRACKING
-- =============================================

-- TABLA: Trayecto (antes Viaje)
CREATE TABLE Trayecto (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    EstudianteID UUID NOT NULL REFERENCES Estudiante(ID) ON DELETE CASCADE,
    RutaID UUID NOT NULL REFERENCES Ruta(ID) ON DELETE RESTRICT,
    InicioTrayecto TIMESTAMPTZ NOT NULL,
    FinTrayecto TIMESTAMPTZ,
    Estado estado_trayecto_enum DEFAULT 'PENDIENTE',
    TuvoDesvio BOOLEAN DEFAULT false,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    EliminadoEn TIMESTAMPTZ,
    CreadoPor UUID REFERENCES Usuario(ID),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);


-- TABLA: Coordenada
CREATE TABLE Coordenada (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    TrayectoID UUID NOT NULL REFERENCES Trayecto(ID) ON DELETE CASCADE,
    Latitud DECIMAL(9,6) NOT NULL,
    Longitud DECIMAL(9,6) NOT NULL,
    RegistradoEn TIMESTAMPTZ NOT NULL,
    VelocidadKmh DECIMAL(5,1),
    SegundosDetenido INTEGER DEFAULT 0 CHECK (SegundosDetenido >= 0),
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);
