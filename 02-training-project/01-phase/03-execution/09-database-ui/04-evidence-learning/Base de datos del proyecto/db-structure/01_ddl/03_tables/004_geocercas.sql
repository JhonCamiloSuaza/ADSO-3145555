-- =============================================
-- DOMINIO: GEOLOCALIZACION Y ZONAS SEGURAS
-- =============================================

-- TABLA: ZonaSegura
CREATE TABLE ZonaSegura (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    EstudianteID UUID NOT NULL REFERENCES Estudiante(ID) ON DELETE CASCADE,
    NombreZona VARCHAR(100) NOT NULL,
    Latitud DECIMAL(9,6) NOT NULL,
    Longitud DECIMAL(9,6) NOT NULL,
    RadioMetros INTEGER NOT NULL CHECK (RadioMetros > 0),
    SegundosInactividadAlerta INTEGER NOT NULL DEFAULT 300 CHECK (SegundosInactividadAlerta > 0),
    EstaActivo BOOLEAN DEFAULT true,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    EliminadoEn TIMESTAMPTZ,
    CreadoPor UUID REFERENCES Usuario(ID),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);
