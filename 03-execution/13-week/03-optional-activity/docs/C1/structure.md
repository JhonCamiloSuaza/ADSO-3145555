# C1 — System Context (Contexto del Sistema)

## Variante Simple

```txt
System Context (Simple)
│
├── Sistema Central
│   └── Scheduler System
│       ├── Módulo de Horarios
│       ├── Módulo de Seguridad
│       └── Módulo de Reportes
│
├── Actores
│   ├── Coordinador Académico
│   ├── Instructor
│   ├── Admin de Ambientes
│   └── Operador de TI
│
└── Sistemas Externos
    ├── Auth Service (LDAP / OAuth2)
    ├── Email Service (SMTP / SendGrid)
    ├── Storage Service (S3 / MinIO)
    └── ERP Institucional
```

---

## Variante Expanded

```txt
System Context (Expanded)
│
├── Sistema Central
│   └── Scheduler System
│       ├── Módulo de Horarios
│       │   ├── Crear Horario
│       │   ├── Editar Horario
│       │   ├── Eliminar Horario
│       │   ├── Consultar Horario
│       │   └── Validar Conflictos (Triple Restricción)
│       ├── Módulo de Seguridad
│       │   ├── Autenticación
│       │   ├── Autorización por Rol
│       │   └── Gestión de Usuarios
│       ├── Módulo de Inventario
│       │   ├── Gestión de Ambientes (Salones / Labs)
│       │   ├── Gestión de Instructores
│       │   └── Gestión de Fichas (Grupos Académicos)
│       └── Módulo de Reportes
│           ├── Reporte de Ocupación por Ambiente
│           ├── Reporte de Carga Horaria por Instructor
│           └── Exportación PDF / Excel
│
├── Actores Primarios
│   ├── Coordinador Académico
│   │   ├── Rol: Gestión completa de horarios y fichas
│   │   ├── Permisos: Crear, Leer, Actualizar, Eliminar (CRUD total)
│   │   ├── Canal de acceso: UI Web
│   │   └── Frecuencia: 5 – 8 horas por semana
│   ├── Instructor
│   │   ├── Rol: Consulta de su propio horario
│   │   ├── Permisos: Solo Lectura (su horario personal)
│   │   ├── Canal de acceso: UI Web / App Móvil
│   │   └── Frecuencia: 1 – 2 veces por semana
│   └── Admin de Ambientes
│       ├── Rol: Mantenimiento del catálogo de salones y laboratorios
│       ├── Permisos: CRUD sobre catálogo de espacios
│       ├── Canal de acceso: UI Web (panel admin)
│       └── Frecuencia: Bajo, cambios ocasionales
│
├── Actores Secundarios
│   ├── Operador de TI
│   │   ├── Rol: Deployment, monitoreo y backups del sistema
│   │   ├── Permisos: Acceso a logs, métricas y configuración de servidor
│   │   ├── Canal de acceso: Terminal / Panel DevOps
│   │   └── Frecuencia: Continua (monitoreo)
│   └── Administrador del Sistema
│       ├── Rol: Configuración global y gestión de usuarios
│       ├── Permisos: Acceso total al sistema
│       └── Canal de acceso: Panel de Administración
│
├── Sistemas Externos
│   ├── Auth Service
│   │   ├── Tecnología: LDAP / OAuth2
│   │   ├── Propósito: Validar credenciales contra directorio institucional
│   │   ├── Protocolo: LDAPS / HTTPS
│   │   └── Criticidad: CRÍTICA
│   ├── Email Service
│   │   ├── Tecnología: SMTP / SendGrid
│   │   ├── Propósito: Envío de notificaciones de cambios en horarios
│   │   ├── Protocolo: SMTP / HTTPS API
│   │   └── Criticidad: Media
│   ├── Storage Service
│   │   ├── Tecnología: S3 / MinIO
│   │   ├── Propósito: Almacenar reportes PDF/Excel y backups
│   │   ├── Protocolo: HTTPS (S3 API)
│   │   └── Criticidad: Media
│   └── ERP Institucional
│       ├── Tecnología: Por definir (REST / SOAP)
│       ├── Propósito: Sincronizar instructores, fichas y períodos académicos
│       ├── Protocolo: REST / SOAP
│       └── Criticidad: Baja (no requerida en MVP)
│
└── Flujos de Interacción
    ├── Coordinador Académico  →  Scheduler System  (CRUD de horarios vía UI Web)
    ├── Instructor             →  Scheduler System  (consulta su horario)
    ├── Admin de Ambientes     →  Scheduler System  (gestiona salones y labs)
    ├── Operador de TI         →  Scheduler System  (monitoreo y deployment)
    ├── Administrador          →  Scheduler System  (configuración global)
    ├── Scheduler System       →  Auth Service      (valida login de cada usuario)
    ├── Scheduler System       →  Email Service     (notifica cambios en horarios)
    ├── Scheduler System       →  Storage Service   (exporta reportes y backups)
    └── Scheduler System       →  ERP Institucional (sincroniza datos académicos)
```
