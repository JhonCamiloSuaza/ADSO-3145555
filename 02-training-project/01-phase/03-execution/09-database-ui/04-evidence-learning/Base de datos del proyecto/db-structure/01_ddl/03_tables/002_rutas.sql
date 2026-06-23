-- =============================================
-- DOMINIO: RUTAS Y PARADAS
-- =============================================

-- TABLA: Ruta
CREATE TABLE Ruta (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    NombreRuta VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    LatitudOrigen DECIMAL(9,6),
    LongitudOrigen DECIMAL(9,6),
    LatitudDestino DECIMAL(9,6),
    LongitudDestino DECIMAL(9,6),
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    EliminadoEn TIMESTAMPTZ,
    CreadoPor UUID REFERENCES Usuario(ID),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);


-- TABLA: Estudiante_Ruta
CREATE TABLE Estudiante_Ruta (
    EstudianteID UUID NOT NULL REFERENCES Estudiante(ID) ON DELETE CASCADE,
    RutaID UUID NOT NULL REFERENCES Ruta(ID) ON DELETE CASCADE,
    EstaActivo BOOLEAN DEFAULT true,
    AsignadoEn TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (EstudianteID, RutaID)
);


-- TABLA: Parada
CREATE TABLE Parada (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    RutaID UUID NOT NULL REFERENCES Ruta(ID) ON DELETE CASCADE,
    OrdenParada INTEGER NOT NULL,
    NombreParada VARCHAR(100),
    Latitud DECIMAL(9,6) NOT NULL,
    Longitud DECIMAL(9,6) NOT NULL,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);
