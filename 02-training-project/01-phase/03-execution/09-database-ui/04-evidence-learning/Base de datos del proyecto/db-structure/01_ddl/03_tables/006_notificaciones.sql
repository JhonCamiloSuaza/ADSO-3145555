-- =============================================
-- DOMINIO: NOTIFICACIONES Y PREFERENCIAS
-- =============================================

-- TABLA: ConfiguracionNotificacion
CREATE TABLE ConfiguracionNotificacion (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UsuarioID UUID NOT NULL REFERENCES Usuario(ID) ON DELETE CASCADE,
    AlertaRetraso BOOLEAN DEFAULT true,
    AlertaCambioRuta BOOLEAN DEFAULT true,
    AlertaLlegada BOOLEAN DEFAULT true,
    AlertaInactividad BOOLEAN DEFAULT true,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);


-- TABLA: Notificacion
CREATE TABLE Notificacion (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    TrayectoID UUID REFERENCES Trayecto(ID) ON DELETE SET NULL,
    ZonaSeguraID UUID REFERENCES ZonaSegura(ID) ON DELETE SET NULL,
    TipoEvento VARCHAR(50) NOT NULL,
    Mensaje TEXT NOT NULL,
    FechaHoraEvento TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FueEnviada BOOLEAN DEFAULT false
);


-- TABLA: ReciboNotificacion
CREATE TABLE ReciboNotificacion (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    NotificacionID UUID NOT NULL REFERENCES Notificacion(ID) ON DELETE CASCADE,
    UsuarioID UUID NOT NULL REFERENCES Usuario(ID) ON DELETE CASCADE,
    FueLeida BOOLEAN DEFAULT false,
    RecibidoEn TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    LeidoEn TIMESTAMPTZ,
    CreadoEn TIMESTAMPTZ DEFAULT NOW(),
    ActualizadoEn TIMESTAMPTZ DEFAULT NOW()
);
