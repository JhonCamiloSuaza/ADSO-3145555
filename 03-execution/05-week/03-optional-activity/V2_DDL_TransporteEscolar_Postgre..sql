
-- Integrantes:
--   Nicolás Estid Ruiz Sastoque
--   Jhon Camilo Suaza Sánchez
--   Kevin Andrey Culma Gómez
-- SENA — Análisis y Desarrollo de Software — Ficha 3145555
-- =============================================================================
--
-- CAMBIOS RESPECTO A v1.0:
--   + TABLA conductor       → perfil extendido del usuario Conductor
--   + TABLA vehiculo        → bus de transporte escolar
--   + TABLA trayecto_estudiante → relación N:M trayecto-pasajeros
--   ~ TABLA trayecto        → agrega conductorid, vehiculoid; estudianteid NULL
--   ~ TABLA usuario         → tipousuario acepta 'Conductor'
--   ~ TABLA notificacion    → agrega tipos 'Trafico' y 'BusVarado'
--   ~ TABLA notificacion_recibe → receptortipo acepta 'Conductor'
--   ~ TABLA confignotificacion  → agrega alertatrafico, alertabusvarado,
--                                  alertaproximollegada
--
-- LÓGICA DE NEGOCIO:
--   - El GPS lo envía el CONDUCTOR desde su celular (no el estudiante)
--   - Un trayecto = un bus en ruta con N estudiantes pasajeros
--   - El conductor marca ✓ a cada estudiante que sube (A Bordo)
--   - El conductor marca ✓ llegada al colegio (Entregado)
--   - El conductor puede reportar trancón manualmente (Trafico)
--   - El sistema detecta bus varado automáticamente (BusVarado)
--   - El padre ve el bus en tiempo real pero NO ve la velocidad
--   - El Admin sí ve velocidad para detectar buses varados
--   - El padre recibe notificaciones automáticas según la configuración de su cuenta
-- =============================================================================

-- 1. SECUENCIAS EXPLÍCITAS


-- Originales
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

-- NUEVAS v2.0
CREATE SEQUENCE seq_conductor        START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_vehiculo         START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;
CREATE SEQUENCE seq_tray_est         START 1 INCREMENT 1 MINVALUE 1 NO MAXVALUE CACHE 1;


-- 2. TABLAS PRINCIPALES



-- TABLA: usuario
-- tipousuario ahora acepta 'Conductor' además de 'Padre' y 'Admin'

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

    -- CAMBIO: agregado 'Conductor'
    CONSTRAINT chk_usuario_tipo CHECK (tipousuario IN ('Padre', 'Admin', 'Conductor')),
    CONSTRAINT uq_usuario_email UNIQUE (email)
);

-- FK circular (usuario se referencia a sí misma)
ALTER TABLE usuario
    ADD CONSTRAINT fk_usuario_creado_por     FOREIGN KEY (creado_por)    REFERENCES usuario(usuarioid),
    ADD CONSTRAINT fk_usuario_modificado_por FOREIGN KEY (modificado_por) REFERENCES usuario(usuarioid);


-- TABLA: ruta
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

    CONSTRAINT chk_ruta_estado   CHECK (estadoruta IN ('Activa', 'Inactiva', 'Suspendida')),
    CONSTRAINT chk_ruta_latitud  CHECK (originlatitud  BETWEEN -90  AND 90),
    CONSTRAINT chk_ruta_longitud CHECK (originlongitud BETWEEN -180 AND 180),

    CONSTRAINT fk_ruta_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);


-- TABLA: conductor  
-- Perfil extendido del usuario con tipousuario='Conductor'.
-- Cada conductor ES un usuario del sistema con login propio.
-- Es quien conduce el bus y envía el GPS desde su celular.
CREATE TABLE conductor (
    conductorid         INT          PRIMARY KEY DEFAULT nextval('seq_conductor'),
    usuarioid           INT          NOT NULL,    -- FK a usuario (tipousuario='Conductor')
    numerolicencia      VARCHAR(50)  NOT NULL,    -- número de licencia de conducción
    categoriaLicencia   VARCHAR(10)  NOT NULL,    -- categoría: C1, C2, C3, etc.
    fechavencimiento    DATE         NOT NULL,    -- vencimiento de la licencia
    documentoidentidad  VARCHAR(30)  NOT NULL,    -- cédula o documento de identidad
    telefono_emergencia VARCHAR(20)  NULL,        -- contacto de emergencia alterno
    estado              BOOLEAN      DEFAULT TRUE,
    creado_por          INT          NULL,
    creado_en           TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por      INT          NULL,
    modificado_en       TIMESTAMP    NULL,

    -- Un usuario solo puede tener un perfil de conductor
    CONSTRAINT uq_conductor_usuario    UNIQUE (usuarioid),
    CONSTRAINT uq_conductor_licencia   UNIQUE (numerolicencia),
    CONSTRAINT uq_conductor_documento  UNIQUE (documentoidentidad),

    -- La licencia no puede estar vencida al momento del registro
    CONSTRAINT chk_conductor_licencia  CHECK (fechavencimiento >= CURRENT_DATE),

    -- Categorías válidas en Colombia para transporte escolar
    CONSTRAINT chk_conductor_categoria CHECK (categoriaLicencia IN ('B1', 'B2', 'B3', 'C1', 'C2', 'C3')),

    CONSTRAINT fk_conductor_usuario    FOREIGN KEY (usuarioid)   REFERENCES usuario(usuarioid),
    CONSTRAINT fk_conductor_creado_por FOREIGN KEY (creado_por)  REFERENCES usuario(usuarioid)
);

COMMENT ON TABLE conductor IS
    'Perfil extendido del usuario Conductor. El conductor inicia sesión en el sistema y envía coordenadas GPS desde su celular durante el trayecto.';
COMMENT ON COLUMN conductor.usuarioid IS
    'Referencia al usuario del sistema. Ese usuario debe tener tipousuario=Conductor.';


-- TABLA: vehiculo  
-- Bus o vehículo de transporte escolar.
-- Se asigna a una ruta específica. El GPS viene del celular del conductor,
-- no de un dispositivo físico en el vehículo.
CREATE TABLE vehiculo (
    vehiculoid      INT          PRIMARY KEY DEFAULT nextval('seq_vehiculo'),
    placa           VARCHAR(10)  NOT NULL,        -- placa del vehículo ej: ABC123
    marca           VARCHAR(100) NULL,            -- ej: Mercedes-Benz
    modelo          VARCHAR(100) NULL,            -- ej: Sprinter 516
    anio            SMALLINT     NULL,            -- año del vehículo
    capacidad       SMALLINT     NOT NULL,        -- número máximo de estudiantes
    rutaid          INT          NULL,            -- ruta asignada (puede ser NULL)
    estadovehiculo  VARCHAR(30)  DEFAULT 'Disponible',
    color           VARCHAR(50)  NULL,
    observaciones   TEXT         NULL,
    estado          BOOLEAN      DEFAULT TRUE,
    creado_por      INT          NULL,
    creado_en       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por  INT          NULL,
    modificado_en   TIMESTAMP    NULL,

    CONSTRAINT uq_vehiculo_placa      UNIQUE (placa),
    CONSTRAINT chk_vehiculo_capacidad CHECK (capacidad > 0 AND capacidad <= 80),
    CONSTRAINT chk_vehiculo_anio      CHECK (anio IS NULL OR (anio >= 1990 AND anio <= EXTRACT(YEAR FROM CURRENT_DATE))),
    CONSTRAINT chk_vehiculo_estado    CHECK (estadovehiculo IN ('Disponible', 'En Ruta', 'En Mantenimiento', 'Fuera de Servicio')),

    CONSTRAINT fk_vehiculo_ruta       FOREIGN KEY (rutaid)     REFERENCES ruta(rutaid),
    CONSTRAINT fk_vehiculo_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

COMMENT ON TABLE vehiculo IS
    'Vehículo de transporte escolar. Se asigna a una ruta. El GPS proviene del celular del conductor, no de un dispositivo en el vehículo.';
COMMENT ON COLUMN vehiculo.estadovehiculo IS
    'Disponible: sin trayecto activo. En Ruta: trayecto activo en curso. En Mantenimiento / Fuera de Servicio: no operable.';


-- TABLA: estudiante
CREATE TABLE estudiante (
    estudianteid       INT          PRIMARY KEY DEFAULT nextval('seq_estudiante'),
    usuarioid          INT          NOT NULL,    -- padre propietario del registro
    rutaid             INT          NULL,        -- ruta habitual del estudiante
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

    CONSTRAINT chk_estudiante_nacimiento CHECK (fechanacimiento <= CURRENT_DATE),

    CONSTRAINT fk_estudiante_usuario    FOREIGN KEY (usuarioid)  REFERENCES usuario(usuarioid),
    CONSTRAINT fk_estudiante_ruta       FOREIGN KEY (rutaid)     REFERENCES ruta(rutaid),
    CONSTRAINT fk_estudiante_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);


-- TABLA: parada

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

    CONSTRAINT chk_parada_latitud  CHECK (latitud  BETWEEN -90  AND 90),
    CONSTRAINT chk_parada_longitud CHECK (longitud BETWEEN -180 AND 180),

    CONSTRAINT fk_parada_ruta       FOREIGN KEY (rutaid)     REFERENCES ruta(rutaid),
    CONSTRAINT fk_parada_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);


-- TABLA: trayecto
--   + columna conductorid  FK → conductor  (quién conduce)
--   + columna vehiculoid   FK → vehiculo   (en qué bus)
--   ~ estudianteid ahora es NULL (la relación N:M va en trayecto_estudiante)
-- Un trayecto = un recorrido del bus en una fecha/hora específica.
-- Puede tener N estudiantes pasajeros (ver trayecto_estudiante).

CREATE TABLE trayecto (
    trayectoid       INT         PRIMARY KEY DEFAULT nextval('seq_trayecto'),
    rutaid           INT         NOT NULL,
    conductorid      INT         NULL,        -- conductor del trayecto
    vehiculoid       INT         NULL,       -- vehículo del trayecto
    estudianteid     INT         NULL,       --  ahora opcional, usar trayecto_estudiante
    fechainicio      TIMESTAMP   NOT NULL,
    fechafin         TIMESTAMP   NULL,
    estadotrayecto   VARCHAR(30) DEFAULT 'En Progreso',
    duracionestimada INT         NULL,       -- minutos estimados del recorrido
    creado_por       INT         NULL,
    creado_en        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    modificado_por   INT         NULL,
    modificado_en    TIMESTAMP   NULL,
    estado           BOOLEAN     DEFAULT TRUE,

    CONSTRAINT chk_trayecto_estado   CHECK (estadotrayecto IN ('En Progreso', 'Finalizado', 'Cancelado')),
    CONSTRAINT chk_trayecto_fechas   CHECK (fechafin IS NULL OR fechafin >= fechainicio),
    CONSTRAINT chk_trayecto_duracion CHECK (duracionestimada IS NULL OR duracionestimada > 0),

    CONSTRAINT fk_trayecto_ruta       FOREIGN KEY (rutaid)       REFERENCES ruta(rutaid),
    CONSTRAINT fk_trayecto_conductor  FOREIGN KEY (conductorid)  REFERENCES conductor(conductorid),  -- NUEVO
    CONSTRAINT fk_trayecto_vehiculo   FOREIGN KEY (vehiculoid)   REFERENCES vehiculo(vehiculoid),    -- NUEVO
    CONSTRAINT fk_trayecto_estudiante FOREIGN KEY (estudianteid) REFERENCES estudiante(estudianteid),
    CONSTRAINT fk_trayecto_creado_por FOREIGN KEY (creado_por)   REFERENCES usuario(usuarioid)
);

COMMENT ON COLUMN trayecto.conductorid IS
    'Conductor asignado al trayecto. Es quien envía las coordenadas GPS desde su celular.';
COMMENT ON COLUMN trayecto.vehiculoid IS
    'Vehículo utilizado en el trayecto.';
COMMENT ON COLUMN trayecto.estudianteid IS
    'Campo legacy de v1.0. Usar trayecto_estudiante para la relación N:M actualizada.';


-- TABLA: trayecto_estudiante  
-- Relación N:M entre trayecto y estudiante.
-- Un bus puede llevar múltiples estudiantes en el mismo trayecto.
-- El conductor marca el estado de cada pasajero en tiempo real:
--   Pendiente  → estudiante esperado pero aún no recogido
--   A Bordo    → conductor marcó ✓ que subió al bus
--   Entregado  → conductor marcó ✓ que llegó al colegio
--   Ausente    → no se presentó en la parada de recogida
-- El padre recibe notificación automática al cambiar a 'A Bordo' y 'Entregado'
CREATE TABLE trayecto_estudiante (
    id               INT          PRIMARY KEY DEFAULT nextval('seq_tray_est'),
    trayectoid       INT          NOT NULL,
    estudianteid     INT          NOT NULL,
    estado_pasajero  VARCHAR(30)  DEFAULT 'Pendiente',
    parada_subida    INT          NULL,       -- parada donde subió
    parada_bajada    INT          NULL,       -- parada donde bajó / fue entregado
    hora_subida      TIMESTAMP    NULL,       -- hora real de subida
    hora_bajada      TIMESTAMP    NULL,       -- hora real de bajada / entrega
    observacion      TEXT         NULL,       -- nota del conductor si hay novedad
    creado_en        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    estado           BOOLEAN      DEFAULT TRUE,

    -- Un estudiante solo aparece una vez por trayecto
    CONSTRAINT uq_trayecto_estudiante  UNIQUE (trayectoid, estudianteid),

    CONSTRAINT chk_pasajero_estado     CHECK (estado_pasajero IN ('Pendiente', 'A Bordo', 'Entregado', 'Ausente')),

    CONSTRAINT fk_traye_trayecto       FOREIGN KEY (trayectoid)    REFERENCES trayecto(trayectoid),
    CONSTRAINT fk_traye_estudiante     FOREIGN KEY (estudianteid)  REFERENCES estudiante(estudianteid),
    CONSTRAINT fk_traye_parada_subida  FOREIGN KEY (parada_subida) REFERENCES parada(paradaid),
    CONSTRAINT fk_traye_parada_bajada  FOREIGN KEY (parada_bajada) REFERENCES parada(paradaid)
);

COMMENT ON TABLE trayecto_estudiante IS
    'Pasajeros de cada trayecto. El conductor marca en tiempo real el estado de cada estudiante (subió, fue entregado, estuvo ausente). El padre recibe notificación automática al cambiar estado.';
COMMENT ON COLUMN trayecto_estudiante.estado_pasajero IS
    'Pendiente: aún no recogido. A Bordo: subió al bus (✓ conductor). Entregado: llegó al destino (✓ conductor). Ausente: no se presentó en la parada.';


-- TABLA: coordenadas
-- NOTA: velocidad se mantiene pero SOLO el Admin la ve.
--       El padre NUNCA recibe este campo en las respuestas de la API
CREATE TABLE coordenadas (
    coordenadaid   INT          PRIMARY KEY DEFAULT nextval('seq_coordenadas'),
    trayectoid     INT          NOT NULL,
    latitud        DECIMAL(9,6) NOT NULL,
    longitud       DECIMAL(9,6) NOT NULL,
    fechahora      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    velocidad      DECIMAL(5,2) NULL,   -- solo visible para Admin (detección de bus varado)
    creado_por     INT          NULL,
    creado_en      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    modificado_por INT          NULL,
    modificado_en  TIMESTAMP    NULL,
    estado         BOOLEAN      DEFAULT TRUE,

    CONSTRAINT chk_coord_latitud   CHECK (latitud  BETWEEN -90  AND 90),
    CONSTRAINT chk_coord_longitud  CHECK (longitud BETWEEN -180 AND 180),
    CONSTRAINT chk_coord_velocidad CHECK (velocidad IS NULL OR velocidad >= 0),

    CONSTRAINT fk_coord_trayecto   FOREIGN KEY (trayectoid) REFERENCES trayecto(trayectoid),
    CONSTRAINT fk_coord_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

COMMENT ON COLUMN coordenadas.velocidad IS
    'Velocidad en km/h. Solo visible para el Administrador. El Admin usa este dato para detectar buses varados (velocidad = 0 por varios minutos). El padre nunca recibe este campo.';


-- TABLA: notificacion
--   tipoevento agrega 'Trafico' y 'BusVarado'
--   Trafico   → conductor reporta trancón manualmente con botón en la app
--   BusVarado → sistema detecta automáticamente velocidad = 0 por > 5 min
CREATE TABLE notificacion (
    notificacionid INT         PRIMARY KEY DEFAULT nextval('seq_notificacion'),
    trayectoid     INT         NULL,
    reportadopor   INT         NULL,        -- usuarioid de quien generó la notif
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

    -- Tipos de evento — versión final
    CONSTRAINT chk_notif_tipoevento  CHECK (tipoevento IN (
        -- Eventos de pasajero (notifican al padre del estudiante específico)
        'EstudianteABordo',   -- conductor marcó que el estudiante subió al bus
        'EstudianteAusente',  -- conductor marcó que el estudiante NO se presentó en la parada
        'ProximoLlegar',      -- bus a menos de 300m de la parada del padre
        'Llegada',            -- bus llegó al colegio, todos los estudiantes entregados
        -- Eventos de ruta y tráfico
        'Retraso',            -- bus llegará tarde (sin causa específica)
        'CambioRuta',         -- admin modificó la ruta permanentemente en el sistema
        'ViaObstruida',       -- vía cerrada o bloqueada, conductor debió desviar
        'DesvioTemporal',     -- desvío puntual por obra, accidente u obstáculo en la vía
        'Trafico',            -- conductor reportó trancón manualmente desde la app
        -- Eventos de seguridad
        'BusVarado',          -- sistema detectó bus sin movimiento por más de 5 minutos
        'Emergencia',         -- emergencia reportada por conductor o admin
        -- General
        'Otro'                -- cualquier novedad que no encaje en los tipos anteriores
    )),
    CONSTRAINT chk_notif_estadoenvio CHECK (estadoenvio IN ('Enviado', 'Fallido', 'Pendiente')),

    CONSTRAINT fk_notif_trayecto   FOREIGN KEY (trayectoid)   REFERENCES trayecto(trayectoid),
    CONSTRAINT fk_notif_reportado  FOREIGN KEY (reportadopor) REFERENCES usuario(usuarioid),
    CONSTRAINT fk_notif_creado_por FOREIGN KEY (creado_por)   REFERENCES usuario(usuarioid)
);

COMMENT ON COLUMN notificacion.tipoevento IS
    'EstudianteABordo: conductor marcó que subió. EstudianteAusente: no se presentó en la parada. ProximoLlegar: bus a 300m de la parada del padre. ViaObstruida: vía cerrada, conductor debió desviar. DesvioTemporal: desvío puntual. Trafico: trancón reportado por conductor. BusVarado: 0 km/h por más de 5 min.';


-- TABLA: notificacion_recibe
--   (Admin puede enviar alertas al conductor también)

CREATE TABLE notificacion_recibe (
    notificacionid INT         NOT NULL,
    receptorid     INT         NOT NULL,
    receptortipo   VARCHAR(20) NOT NULL,
    fecharecibo    TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    leida          BOOLEAN     DEFAULT FALSE,

    CONSTRAINT pk_notificacion_recibe PRIMARY KEY (notificacionid, receptorid),

    -- CAMBIO: agregado 'Conductor'
    CONSTRAINT chk_receptor_tipo CHECK (receptortipo IN ('Padre', 'Admin', 'Conductor')),

    CONSTRAINT fk_notifrecibe_notif    FOREIGN KEY (notificacionid) REFERENCES notificacion(notificacionid),
    CONSTRAINT fk_notifrecibe_receptor FOREIGN KEY (receptorid)     REFERENCES usuario(usuarioid)
);


-- TABLA: confignotificacion
--   alertatrafico       → recibir aviso cuando el conductor reporte trancón
--   alertabusvarado     → recibir aviso cuando el sistema detecte bus varado
--   alertaproximollegada → recibir aviso cuando el bus esté cerca de la parada

CREATE TABLE confignotificacion (
    configid              INT     PRIMARY KEY DEFAULT nextval('seq_confignotif'),
    usuarioid             INT     NOT NULL,
    alertaretraso         BOOLEAN DEFAULT TRUE,
    alertacambioruta      BOOLEAN DEFAULT TRUE,
    alertallegada         BOOLEAN DEFAULT TRUE,
    alertatrafico              BOOLEAN DEFAULT TRUE,   -- aviso cuando conductor reporte trancón
    alertabusvarado            BOOLEAN DEFAULT TRUE,   -- aviso cuando sistema detecte bus varado
    alertaproximollegada       BOOLEAN DEFAULT TRUE,   -- aviso cuando bus esté a menos de 300m
    alertaestudianteabordo     BOOLEAN DEFAULT TRUE,   -- aviso cuando su hijo suba al bus (✓ conductor)
    alertaestudianteausente    BOOLEAN DEFAULT TRUE,   -- aviso cuando su hijo no se presente en la parada
    creado_por            INT     NULL,
    creado_en             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_por        INT     NULL,
    modificado_en         TIMESTAMP NULL,
    estado                BOOLEAN DEFAULT TRUE,

    CONSTRAINT uq_confignotif_usuario UNIQUE (usuarioid),

    CONSTRAINT fk_confignotif_usuario    FOREIGN KEY (usuarioid)  REFERENCES usuario(usuarioid),
    CONSTRAINT fk_confignotif_creado_por FOREIGN KEY (creado_por) REFERENCES usuario(usuarioid)
);

COMMENT ON COLUMN confignotificacion.alertaproximollegada IS
    'Enviar notificación al padre cuando el bus esté a menos de 300 metros de la parada donde recoge a su hijo.';
COMMENT ON COLUMN confignotificacion.alertabusvarado IS
    'Enviar notificación cuando el sistema detecte que el bus lleva más de 5 minutos sin movimiento.';
COMMENT ON COLUMN confignotificacion.alertatrafico IS
    'Enviar notificación cuando el conductor reporte trancón manualmente desde su app.';
COMMENT ON COLUMN confignotificacion.alertaestudianteabordo IS
    'Enviar notificación al padre cuando el conductor marque que su hijo subió al bus (estado A Bordo).';
COMMENT ON COLUMN confignotificacion.alertaestudianteausente IS
    'Enviar notificación al padre cuando el conductor marque que su hijo no se presentó en la parada (estado Ausente).';




-- 3. SEGURIDAD Y AUDITORÍA

-- TABLA: registro
CREATE TABLE registro (
    registroid   INT          PRIMARY KEY DEFAULT nextval('seq_registro'),
    usuarioid    INT          NOT NULL,
    tipoaccion   VARCHAR(100) NOT NULL,
    descripcion  VARCHAR(500) NULL,
    fechahora    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    ip_origen    VARCHAR(50)  NULL,
    dispositivo  VARCHAR(100) NULL,
    estadoaccion VARCHAR(50)  DEFAULT 'Exitoso',

    CONSTRAINT chk_registro_estado CHECK (estadoaccion IN ('Exitoso', 'Fallido', 'Parcial')),

    CONSTRAINT fk_registro_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);


-- TABLA: roles

CREATE TABLE roles (
    rolid       INT          PRIMARY KEY DEFAULT nextval('seq_roles'),
    nombrerol   VARCHAR(50)  NOT NULL,
    descripcion VARCHAR(255) NULL,

    CONSTRAINT uq_roles_nombre UNIQUE (nombrerol)
);


-- TABLA: usuario_rol

CREATE TABLE usuario_rol (
    usuarioid       INT       NOT NULL,
    rolid           INT       NOT NULL,
    fechaasignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_usuario_rol PRIMARY KEY (usuarioid, rolid),

    CONSTRAINT fk_usuariorol_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid),
    CONSTRAINT fk_usuariorol_rol     FOREIGN KEY (rolid)     REFERENCES roles(rolid)
);

-- TABLA: permisos

CREATE TABLE permisos (
    permisoid     INT          PRIMARY KEY DEFAULT nextval('seq_permisos'),
    nombrepermiso VARCHAR(50)  NOT NULL,
    descripcion   VARCHAR(255) NULL,

    CONSTRAINT uq_permisos_nombre UNIQUE (nombrepermiso)
);


-- TABLA: rol_permiso

CREATE TABLE rol_permiso (
    rolid           INT       NOT NULL,
    permisoid       INT       NOT NULL,
    fechaasignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_rol_permiso PRIMARY KEY (rolid, permisoid),

    CONSTRAINT fk_rolpermiso_rol     FOREIGN KEY (rolid)     REFERENCES roles(rolid),
    CONSTRAINT fk_rolpermiso_permiso FOREIGN KEY (permisoid) REFERENCES permisos(permisoid)
);


-- TABLA: auditoria

CREATE TABLE auditoria (
    auditoriaid INT          PRIMARY KEY DEFAULT nextval('seq_auditoria'),
    usuarioid   INT          NULL,
    accion      VARCHAR(255) NULL,
    fecha       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(500) NULL,
    ip_origen   VARCHAR(50)  NULL,
    aplicacion  VARCHAR(255) NULL,

    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);


-- TABLA: sesion_usuario

CREATE TABLE sesion_usuario (
    sesionid     INT         PRIMARY KEY DEFAULT nextval('seq_sesion_usuario'),
    usuarioid    INT         NOT NULL,
    fechainicio  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    fechafin     TIMESTAMP   NULL,
    ip_origen    VARCHAR(50) NULL,
    estadosesion VARCHAR(50) NULL,

    CONSTRAINT chk_sesion_fechas CHECK (fechafin IS NULL OR fechafin >= fechainicio),
    CONSTRAINT chk_sesion_estado CHECK (estadosesion IN ('Activa', 'Cerrada', 'Expirada')),

    CONSTRAINT fk_sesion_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);


-- TABLA: log_errores

CREATE TABLE log_errores (
    errorid     INT          PRIMARY KEY DEFAULT nextval('seq_log_errores'),
    fecha       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    usuarioid   INT          NULL,
    tipoerror   VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    ip_origen   VARCHAR(50)  NULL,

    CONSTRAINT fk_logerror_usuario FOREIGN KEY (usuarioid) REFERENCES usuario(usuarioid)
);


-- TABLA: configuracion_seguridad

CREATE TABLE configuracion_seguridad (
    configuracionid     INT          PRIMARY KEY DEFAULT nextval('seq_config_seguridad'),
    nombreconfiguracion VARCHAR(100) NOT NULL,
    valorconfiguracion  VARCHAR(500) NULL,
    descripcion         VARCHAR(255) NULL,

    CONSTRAINT uq_config_nombre UNIQUE (nombreconfiguracion)
);


-- TABLA: politicas_contrasenas

CREATE TABLE politicas_contrasenas (
    politicaid           INT     PRIMARY KEY DEFAULT nextval('seq_politicas'),
    minlongitud          INT     DEFAULT 8,
    maxlongitud          INT     DEFAULT 20,
    requieremayusculas   BOOLEAN DEFAULT TRUE,
    requiereminusculas   BOOLEAN DEFAULT TRUE,
    requirenumeros       BOOLEAN DEFAULT TRUE,
    requieresimbolos     BOOLEAN DEFAULT TRUE,
    caducidaddias        INT     DEFAULT 90,
    intentosfallidosmax  INT     DEFAULT 5,

    CONSTRAINT chk_politica_longitud  CHECK (minlongitud > 0 AND maxlongitud >= minlongitud),
    CONSTRAINT chk_politica_caducidad CHECK (caducidaddias > 0),
    CONSTRAINT chk_politica_intentos  CHECK (intentosfallidosmax > 0)
);


-- 4. ÍNDICES


-- ---- Trayecto ----
CREATE INDEX ix_trayecto_fechainicio ON trayecto(fechainicio);
CREATE INDEX ix_trayecto_estudiante  ON trayecto(estudianteid);
CREATE INDEX ix_trayecto_ruta        ON trayecto(rutaid);
CREATE INDEX ix_trayecto_estado      ON trayecto(estadotrayecto);
CREATE INDEX ix_trayecto_conductor   ON trayecto(conductorid);   -- NUEVO
CREATE INDEX ix_trayecto_vehiculo    ON trayecto(vehiculoid);    -- NUEVO

-- ---- Coordenadas ----
CREATE INDEX ix_coordenadas_trayecto  ON coordenadas(trayectoid);
CREATE INDEX ix_coordenadas_fechahora ON coordenadas(fechahora DESC);

-- ---- Notificación ----
CREATE INDEX ix_notificacion_trayecto   ON notificacion(trayectoid);
CREATE INDEX ix_notificacion_tipoevento ON notificacion(tipoevento);
CREATE INDEX ix_notificacion_fechahora  ON notificacion(fechahora DESC);

-- ---- Parada ----
CREATE INDEX ix_parada_ruta ON parada(rutaid);

-- ---- Estudiante ----
CREATE INDEX ix_estudiante_usuario ON estudiante(usuarioid);
CREATE INDEX ix_estudiante_ruta    ON estudiante(rutaid);

-- ---- Registro y Auditoría ----
CREATE INDEX ix_registro_usuario  ON registro(usuarioid, fechahora DESC);
CREATE INDEX ix_auditoria_usuario ON auditoria(usuarioid, fecha DESC);
CREATE INDEX ix_sesion_usuario    ON sesion_usuario(usuarioid, fechainicio DESC);

-- ---- Notificacion_Recibe ----
CREATE INDEX ix_notifrecibe_receptor ON notificacion_recibe(receptorid);

-- ---- Conductor (NUEVOS) ----
CREATE INDEX ix_conductor_usuario ON conductor(usuarioid);
CREATE INDEX ix_conductor_estado  ON conductor(estado);

-- ---- Vehiculo (NUEVOS) ----
CREATE INDEX ix_vehiculo_ruta    ON vehiculo(rutaid);
CREATE INDEX ix_vehiculo_estado  ON vehiculo(estadovehiculo);
CREATE INDEX ix_vehiculo_placa   ON vehiculo(placa);

-- ---- Trayecto_Estudiante (NUEVOS) ----
CREATE INDEX ix_traye_trayecto   ON trayecto_estudiante(trayectoid);
CREATE INDEX ix_traye_estudiante ON trayecto_estudiante(estudianteid);
CREATE INDEX ix_traye_estado     ON trayecto_estudiante(estado_pasajero);


SELECT
    table_name                              AS tabla,
    COUNT(*)                                AS columnas
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN (
    'usuario','ruta','conductor','vehiculo','estudiante','parada',
    'trayecto','trayecto_estudiante','coordenadas','notificacion',
    'notificacion_recibe','confignotificacion','registro','roles',
    'usuario_rol','permisos','rol_permiso','auditoria','sesion_usuario',
    'log_errores','configuracion_seguridad','politicas_contrasenas'
  )
GROUP BY table_name
ORDER BY table_name;

