-- =============================================================================
-- SCRIPT DDL COMPLETO - GPS Guardian Escolar v3
-- PostgreSQL - Tablas, PKs, FKs, Restricciones, Índices y Secuencias
-- Nicolás Estid Ruiz Sastoque, Jhon Camilo Suaza Sánchez, Kevin Andrey Culma Gómez
-- SENA - Análisis y Desarrollo de Software
-- =============================================================================

-- Crear base de datos (ejecutar como superusuario)
-- CREATE DATABASE transporteescolar_beta;
-- \c transporteescolar_beta;

-- =============================================================================
-- 1. SECUENCIAS EXPLÍCITAS
-- =============================================================================

CREATE SEQUENCE seq_usuario          START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_ruta             START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_estudiante       START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_parada           START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_trayecto         START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_coordenadas      START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_notificacion     START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_confignotif      START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_registro         START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_roles            START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_permisos         START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_auditoria        START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_sesion_usuario   START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_log_errores      START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_config_seguridad START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_politicas        START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;

-- =============================================================================
-- 2. TABLAS PRINCIPALES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- TABLA: usuario
-- -----------------------------------------------------------------------------
CREATE TABLE usuario (
    usuarioid      INT          PRIMARY KEY DEFAULT nextval('seq_usuario'),
    nombrecompleto VARCHAR(255) NOT NULL,
    telefono       VARCHAR(20)  NULL,
    email          VARCHAR(100) NOT NULL,
    contrasena     VARCHAR(255) NOT NULL,
    tipousuario    VARCHAR(20)  NOT NULL,
    estadousuario  BOOLEAN      DEFAULT TRUE,
    fechacreacion  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    ultimoacceso   TIMESTAMP    NULL,
    creado_por     INT          NULL,
    creado_en      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por INT          NULL,
    modificado_en  TIMESTAMP    NULL,
    estado         BOOLEAN      DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_usuario_tipo CHECK (tipousuario IN ('Padre', 'Admin')),
    CONSTRAINT uq_usuario_email UNIQUE (email)
);

-- FK circular (usuario se referencia a sí misma)
ALTER TABLE usuario
    ADD CONSTRAINT fk_usuario_creado_por    FOREIGN KEY (creado_por)    REFERENCES usuario(usuarioid),
    ADD CONSTRAINT fk_usuario_modificado_por FOREIGN KEY (modificado_por) REFERENCES usuario(usuarioid);

-- -----------------------------------------------------------------------------
-- TABLA: ruta
-- -----------------------------------------------------------------------------
CREATE TABLE ruta (
    rutaid         INT          PRIMARY KEY DEFAULT nextval('seq_ruta'),
    nombreruta     VARCHAR(255) NOT NULL,
    descripcion    VARCHAR(255) NULL,
    horariosalida  TIME         NULL,
    estadoruta     VARCHAR(30)  DEFAULT 'Activa',
    originlatitud  DECIMAL(9,6) NULL,
    originlongitud DECIMAL(9,6) NULL,
    creado_por     INT          NULL,
    creado_en      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por INT          NULL,
    modificado_en  TIMESTAMP    NULL,
    estado         BOOLEAN      DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_ruta_estado CHECK (estadoruta IN ('Activa', 'Inactiva', 'Suspendida')),
    CONSTRAINT chk_ruta_latitud  CHECK (originlatitud  BETWEEN -90  AND 90),
    CONSTRAINT chk_ruta_longitud CHECK (originlongitud BETWEEN -180 AND 180),

    -- FK
    CONSTRAINT fk_ruta_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: estudiante
-- -----------------------------------------------------------------------------
CREATE TABLE estudiante (
    estudianteid       INT          PRIMARY KEY DEFAULT nextval('seq_estudiante'),
    usuarioid          INT          NOT NULL,
    rutaid             INT          NULL,
    nombreestudiante   VARCHAR(255) NOT NULL,
    gradoescolar       VARCHAR(50)  NULL,
    contactoemergencia VARCHAR(100) NULL,
    estadoestudiante   BOOLEAN      DEFAULT TRUE,
    fechanacimiento    DATE         NULL,
    creado_por         INT          NULL,
    creado_en          TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por     INT          NULL,
    modificado_en      TIMESTAMP    NULL,
    estado             BOOLEAN      DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_estudiante_nacimiento CHECK (fechanacimiento <= CURRENT_DATE),

    -- FK
    CONSTRAINT fk_estudiante_usuario   FOREIGN KEY (usuarioid)  REFERENCES usuario(usuarioid),
    CONSTRAINT fk_estudiante_ruta      FOREIGN KEY (rutaid)     REFERENCES ruta(rutaid),
    CONSTRAINT fk_estudiante_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: parada
-- -----------------------------------------------------------------------------
CREATE TABLE parada (
    paradaid        INT          PRIMARY KEY DEFAULT nextval('seq_parada'),
    rutaid          INT          NOT NULL,
    nombreparada    VARCHAR(255) NOT NULL,
    latitud         DECIMAL(9,6) NOT NULL,
    longitud        DECIMAL(9,6) NOT NULL,
    horarioestimado TIME         NULL,
    creado_por      INT          NULL,
    creado_en       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por  INT          NULL,
    modificado_en   TIMESTAMP    NULL,
    estado          BOOLEAN      DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_parada_latitud  CHECK (latitud  BETWEEN -90  AND 90),
    CONSTRAINT chk_parada_longitud CHECK (longitud BETWEEN -180 AND 180),

    -- FK
    CONSTRAINT fk_parada_ruta      FOREIGN KEY (rutaid)     REFERENCES ruta(rutaid),
    CONSTRAINT fk_parada_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: trayecto
-- -----------------------------------------------------------------------------
CREATE TABLE trayecto (
    trayectoid       INT         PRIMARY KEY DEFAULT nextval('seq_trayecto'),
    rutaid           INT         NOT NULL,
    estudianteid     INT         NOT NULL,
    fechainicio      TIMESTAMP   NOT NULL,
    fechafin         TIMESTAMP   NULL,
    estadotrayecto   VARCHAR(30) DEFAULT 'En Progreso',
    duracionestimada INT         NULL,
    creado_por       INT         NULL,
    creado_en        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    modificado_por   INT         NULL,
    modificado_en    TIMESTAMP   NULL,
    estado           BOOLEAN     DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_trayecto_estado   CHECK (estadotrayecto IN ('En Progreso', 'Finalizado', 'Cancelado')),
    CONSTRAINT chk_trayecto_fechas   CHECK (fechafin IS NULL OR fechafin >= fechainicio),
    CONSTRAINT chk_trayecto_duracion CHECK (duracionestimada IS NULL OR duracionestimada > 0),

    -- FK
    CONSTRAINT fk_trayecto_ruta        FOREIGN KEY (rutaid)       REFERENCES ruta(rutaid),
    CONSTRAINT fk_trayecto_estudiante  FOREIGN KEY (estudianteid) REFERENCES estudiante(estudianteid),
    CONSTRAINT fk_trayecto_creado_por  FOREIGN KEY (creado_por)   REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: coordenadas
-- -----------------------------------------------------------------------------
CREATE TABLE coordenadas (
    coordenadaid   INT          PRIMARY KEY DEFAULT nextval('seq_coordenadas'),
    trayectoid     INT          NOT NULL,
    latitud        DECIMAL(9,6) NOT NULL,
    longitud       DECIMAL(9,6) NOT NULL,
    fechahora      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    velocidad      DECIMAL(5,2) NULL,
    creado_por     INT          NULL,
    creado_en      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por INT          NULL,
    modificado_en  TIMESTAMP    NULL,
    estado         BOOLEAN      DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_coord_latitud   CHECK (latitud  BETWEEN -90  AND 90),
    CONSTRAINT chk_coord_longitud  CHECK (longitud BETWEEN -180 AND 180),
    CONSTRAINT chk_coord_velocidad CHECK (velocidad IS NULL OR velocidad >= 0),

    -- FK
    CONSTRAINT fk_coord_trayecto   FOREIGN KEY (trayectoid) REFERENCES trayecto(trayectoid),
    CONSTRAINT fk_coord_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: notificacion
-- -----------------------------------------------------------------------------
CREATE TABLE notificacion (
    notificacionid INT         PRIMARY KEY DEFAULT nextval('seq_notificacion'),
    trayectoid     INT         NULL,
    reportadopor   INT         NULL,
    tipoevento     VARCHAR(50) NOT NULL,
    mensaje        TEXT        NOT NULL,
    fechahora      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    esdesvioruta   BOOLEAN     DEFAULT FALSE,
    estadoenvio    VARCHAR(30) DEFAULT 'Enviado',
    creado_por     INT         NULL,
    creado_en      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    modificado_por INT         NULL,
    modificado_en  TIMESTAMP   NULL,
    estado         BOOLEAN     DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT chk_notif_tipoevento CHECK (tipoevento IN ('Retraso', 'CambioRuta', 'Llegada', 'Emergencia', 'Desvio', 'Otro')),
    CONSTRAINT chk_notif_estadoenvio CHECK (estadoenvio IN ('Enviado', 'Fallido', 'Pendiente')),

    -- FK
    CONSTRAINT fk_notif_trayecto    FOREIGN KEY (trayectoid)   REFERENCES trayecto(trayectoid),
    CONSTRAINT fk_notif_reportado   FOREIGN KEY (reportadopor) REFERENCES usuario(usuarioid),
    CONSTRAINT fk_notif_creado_por  FOREIGN KEY (creado_por)   REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: notificacion_recibe
-- -----------------------------------------------------------------------------
CREATE TABLE notificacion_recibe (
    notificacionid INT         NOT NULL,
    receptorid     INT         NOT NULL,
    receptortipo   VARCHAR(20) NOT NULL,
    fecharecibo    TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    leida          BOOLEAN     DEFAULT FALSE,

    -- PK compuesta
    CONSTRAINT pk_notificacion_recibe PRIMARY KEY (notificacionid, receptorid),

    -- Restricciones
    CONSTRAINT chk_receptor_tipo CHECK (receptortipo IN ('Padre', 'Admin')),

    -- FK
    CONSTRAINT fk_notifrecibe_notif    FOREIGN KEY (notificacionid) REFERENCES notificacion(notificacionid),
    CONSTRAINT fk_notifrecibe_receptor FOREIGN KEY (receptorid)     REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: confignotificacion
-- -----------------------------------------------------------------------------
CREATE TABLE confignotificacion (
    configid         INT     PRIMARY KEY DEFAULT nextval('seq_confignotif'),
    usuarioid        INT     NOT NULL,
    alertaretraso    BOOLEAN DEFAULT TRUE,
    alertacambioruta BOOLEAN DEFAULT TRUE,
    alertallegada    BOOLEAN DEFAULT TRUE,
    creado_por       INT     NULL,
    creado_en        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_por   INT     NULL,
    modificado_en    TIMESTAMP NULL,
    estado           BOOLEAN DEFAULT TRUE,

    -- Restricciones
    CONSTRAINT uq_confignotif_usuario UNIQUE (usuarioid),   -- relación 1:1

    -- FK
    CONSTRAINT fk_confignotif_usuario    FOREIGN KEY (usuarioid)  REFERENCES usuario(usuarioid),
    CONSTRAINT fk_confignotif_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

-- =============================================================================
-- 3. SEGURIDAD Y AUDITORÍA
-- =============================================================================

-- -----------------------------------------------------------------------------
-- TABLA: registro
-- -----------------------------------------------------------------------------
CREATE TABLE registro (
    registroid    INT          PRIMARY KEY DEFAULT nextval('seq_registro'),
    usuarioid     INT          NOT NULL,
    tipoaccion    VARCHAR(100) NOT NULL,
    descripcion   VARCHAR(500) NULL,
    fechahora     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    ip_origen     VARCHAR(50)  NULL,
    dispositivo   VARCHAR(100) NULL,
    estadoaccion  VARCHAR(50)  DEFAULT 'Exitoso',

    -- Restricciones
    CONSTRAINT chk_registro_estado CHECK (estadoaccion IN ('Exitoso', 'Fallido', 'Parcial')),

    -- FK
    CONSTRAINT fk_registro_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: roles
-- -----------------------------------------------------------------------------
CREATE TABLE roles (
    rolid       INT          PRIMARY KEY DEFAULT nextval('seq_roles'),
    nombrerol   VARCHAR(50)  NOT NULL,
    descripcion VARCHAR(255) NULL,

    -- Restricciones
    CONSTRAINT uq_roles_nombre UNIQUE (nombrerol)
);

-- -----------------------------------------------------------------------------
-- TABLA: usuario_rol
-- -----------------------------------------------------------------------------
CREATE TABLE usuario_rol (
    usuarioid       INT       NOT NULL,
    rolid           INT       NOT NULL,
    fechaasignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- PK compuesta
    CONSTRAINT pk_usuario_rol PRIMARY KEY (usuarioid, rolid),

    -- FK
    CONSTRAINT fk_usuariorol_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid),
    CONSTRAINT fk_usuariorol_rol     FOREIGN KEY (rolid)     REFERENCES roles(rolid)
);

-- -----------------------------------------------------------------------------
-- TABLA: permisos
-- -----------------------------------------------------------------------------
CREATE TABLE permisos (
    permisoid     INT          PRIMARY KEY DEFAULT nextval('seq_permisos'),
    nombrepermiso VARCHAR(50)  NOT NULL,
    descripcion   VARCHAR(255) NULL,

    -- Restricciones
    CONSTRAINT uq_permisos_nombre UNIQUE (nombrepermiso)
);

-- -----------------------------------------------------------------------------
-- TABLA: rol_permiso
-- -----------------------------------------------------------------------------
CREATE TABLE rol_permiso (
    rolid           INT       NOT NULL,
    permisoid       INT       NOT NULL,
    fechaasignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- PK compuesta
    CONSTRAINT pk_rol_permiso PRIMARY KEY (rolid, permisoid),

    -- FK
    CONSTRAINT fk_rolpermiso_rol     FOREIGN KEY (rolid)     REFERENCES roles(rolid),
    CONSTRAINT fk_rolpermiso_permiso FOREIGN KEY (permisoid) REFERENCES permisos(permisoid)
);

-- -----------------------------------------------------------------------------
-- TABLA: auditoria
-- -----------------------------------------------------------------------------
CREATE TABLE auditoria (
    auditoriaid INT          PRIMARY KEY DEFAULT nextval('seq_auditoria'),
    usuarioid   INT          NULL,
    accion      VARCHAR(255) NULL,
    fecha       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(500) NULL,
    ip_origen   VARCHAR(50)  NULL,
    aplicacion  VARCHAR(255) NULL,

    -- FK
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: sesion_usuario
-- -----------------------------------------------------------------------------
CREATE TABLE sesion_usuario (
    sesionid     INT         PRIMARY KEY DEFAULT nextval('seq_sesion_usuario'),
    usuarioid    INT         NOT NULL,
    fechainicio  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    fechafin     TIMESTAMP   NULL,
    ip_origen    VARCHAR(50) NULL,
    estadosesion VARCHAR(50) NULL,

    -- Restricciones
    CONSTRAINT chk_sesion_fechas  CHECK (fechafin IS NULL OR fechafin >= fechainicio),
    CONSTRAINT chk_sesion_estado  CHECK (estadosesion IN ('Activa', 'Cerrada', 'Expirada')),

    -- FK
    CONSTRAINT fk_sesion_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: log_errores
-- -----------------------------------------------------------------------------
CREATE TABLE log_errores (
    errorid     INT          PRIMARY KEY DEFAULT nextval('seq_log_errores'),
    fecha       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    usuarioid   INT          NULL,
    tipoerror   VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    ip_origen   VARCHAR(50)  NULL,

    -- FK
    CONSTRAINT fk_logerror_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);

-- -----------------------------------------------------------------------------
-- TABLA: configuracion_seguridad
-- -----------------------------------------------------------------------------
CREATE TABLE configuracion_seguridad (
    configuracionid     INT          PRIMARY KEY DEFAULT nextval('seq_config_seguridad'),
    nombreconfiguracion VARCHAR(100) NOT NULL,
    valorconfiguracion  VARCHAR(500) NULL,
    descripcion         VARCHAR(255) NULL,

    -- Restricciones
    CONSTRAINT uq_config_nombre UNIQUE (nombreconfiguracion)
);

-- -----------------------------------------------------------------------------
-- TABLA: politicas_contrasenas
-- -----------------------------------------------------------------------------
CREATE TABLE politicas_contrasenas (
    politicaid            INT     PRIMARY KEY DEFAULT nextval('seq_politicas'),
    minlongitud           INT     DEFAULT 8,
    maxlongitud           INT     DEFAULT 20,
    requieremayusculas    BOOLEAN DEFAULT TRUE,
    requiereminusculas    BOOLEAN DEFAULT TRUE,
    requirenumeros        BOOLEAN DEFAULT TRUE,
    requieresimbolos      BOOLEAN DEFAULT TRUE,
    caducidaddias         INT     DEFAULT 90,
    intentosfалlidosmax   INT     DEFAULT 5,

    -- Restricciones
    CONSTRAINT chk_politica_longitud CHECK (minlongitud > 0 AND maxlongitud >= minlongitud),
    CONSTRAINT chk_politica_caducidad CHECK (caducidaddias > 0),
    CONSTRAINT chk_politica_intentos  CHECK (intentosfалlidosmax > 0)
);

-- =============================================================================
-- 4. ÍNDICES
-- =============================================================================

-- Trayecto
CREATE INDEX ix_trayecto_fechainicio ON trayecto(fechainicio);
CREATE INDEX ix_trayecto_estudiante  ON trayecto(estudianteid);
CREATE INDEX ix_trayecto_ruta        ON trayecto(rutaid);
CREATE INDEX ix_trayecto_estado      ON trayecto(estadotrayecto);

-- Coordenadas
CREATE INDEX ix_coordenadas_trayecto  ON coordenadas(trayectoid);
CREATE INDEX ix_coordenadas_fechahora ON coordenadas(fechahora DESC);

-- Notificación
CREATE INDEX ix_notificacion_trayecto   ON notificacion(trayectoid);
CREATE INDEX ix_notificacion_tipoevento ON notificacion(tipoevento);
CREATE INDEX ix_notificacion_fechahora  ON notificacion(fechahora DESC);

-- Parada
CREATE INDEX ix_parada_ruta ON parada(rutaid);

-- Estudiante
CREATE INDEX ix_estudiante_usuario ON estudiante(usuarioid);
CREATE INDEX ix_estudiante_ruta    ON estudiante(rutaid);

-- Registro y Auditoría
CREATE INDEX ix_registro_usuario  ON registro(usuarioid, fechahora DESC);
CREATE INDEX ix_auditoria_usuario ON auditoria(usuarioid, fecha DESC);
CREATE INDEX ix_sesion_usuario    ON sesion_usuario(usuarioid, fechainicio DESC);

-- Notificacion_Recibe
CREATE INDEX ix_notifrecibe_receptor ON notificacion_recibe(receptorid);

-- =============================================================================
-- FIN DEL SCRIPT DDL COMPLETO
-- =============================================================================
