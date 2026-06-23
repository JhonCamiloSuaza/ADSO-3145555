-- =============================================
-- DOMINIO: USUARIOS Y ESTUDIANTES
-- =============================================

-- TABLA: Usuario
CREATE TABLE Usuario (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    NombreCompleto VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Telefono VARCHAR(30),
    HashContrasena VARCHAR(255) NOT NULL,
    EstaActivo BOOLEAN DEFAULT true,
    CorreoVerificado BOOLEAN DEFAULT false,
    TokenVerificacionCorreo VARCHAR(255) UNIQUE,
    ExpiraTokenVerificacion TIMESTAMPTZ,
    TokenRestablecerContrasena VARCHAR(255) UNIQUE,
    ExpiraTokenRestablecer TIMESTAMPTZ,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    EliminadoEn TIMESTAMPTZ,
    CreadoPor UUID REFERENCES Usuario(ID),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);


-- TABLA: Estudiante
CREATE TABLE Estudiante (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UsuarioID UUID NOT NULL REFERENCES Usuario(ID) ON DELETE RESTRICT,
    NombreCompleto VARCHAR(100) NOT NULL,
    GradoEscolar grado_escolar_enum,
    FechaNacimiento DATE,
    EstaActivo BOOLEAN DEFAULT true,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    EliminadoEn TIMESTAMPTZ,
    CreadoPor UUID REFERENCES Usuario(ID),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);


-- TABLA: ContactoEmergencia
CREATE TABLE ContactoEmergencia (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    EstudianteID UUID NOT NULL REFERENCES Estudiante(ID) ON DELETE CASCADE,
    NombreCompleto VARCHAR(100) NOT NULL,
    Telefono VARCHAR(30) NOT NULL,
    Parentesco VARCHAR(50),
    EsPrincipal BOOLEAN DEFAULT false,
    EstaActivo BOOLEAN DEFAULT true,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW(),
    EliminadoEn TIMESTAMPTZ,
    CreadoPor UUID REFERENCES Usuario(ID),
    ActualizadoPor UUID REFERENCES Usuario(ID)
);
