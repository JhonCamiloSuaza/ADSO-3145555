# C1 — System Context

## Estructura de Documentación

```txt
docs/C1
├── structure.md                # este archivo
├── system-context.drawio       # (opcional) diagrama visual en DrawIO
├── personas.md                 # detalle de actores y sus responsabilidades
├── interactions.md             # flujos de interacción entre actores
└── variants/
    ├── simple/
    │   ├── README.md           # resumen para stakeholders/gerencia ejecutiva
    │   ├── actors.md           # actores simplificados
    │   ├── system_boundary.md  # límites del sistema
    │   └── external_deps.md    # dependencias externas (simplificadas)
    └── expanded/
        ├── README.md           # resumen para arquitectos y equipo técnico
        ├── personas_detailed.md     # actores con detalles de API/frecuencia
        ├── interactions_detailed.md # flujos detallados por actor
        ├── business_rules.md        # reglas de negocio por contexto
        └── deployment_context.md    # consideraciones de deployment
```

## Por qué C1 es crítico

C1 presenta el **panorama general y ecosistema completo**:
- Definir el sistema central y sus límites.
- Identificar actores externos (usuarios, sistemas terceros).
- Mapear dependencias y puntos de integración.
- Establecer el contexto para decisiones de diseño en C2, C3 y C4.

## Sistema Central

```txt
┌─────────────────────────────────────────────────────────────────┐
│                   SCHEDULER SYSTEM                              │
│         Gestión Centralizada de Horarios Académicos              │
│                                                                   │
│  • Asignación de Instructores ↔ Horarios ↔ Ambientes ↔ Fichas  │
│  • Detección automática de conflictos (triple restricción)       │
│  • Reporte de carga horaria y ocupación de espacios             │
│  • Exportación de horarios para publicación                      │
└─────────────────────────────────────────────────────────────────┘
```

## Actores (Personas/Roles)

### 1. Coordinador Académico
- **Responsabilidades**: Programar fichas, asignar instructores/ambientes, resolver conflictos.
- **Interacciones**: CRUD completo de horarios, reportes de conflictos.
- **Frecuencia de uso**: 5-8 horas/semana durante semana de planeación.
- **Requisitos**: Acceso total a todas las fichas, ver conflictos en tiempo real.

### 2. Instructor
- **Responsabilidades**: Consultar su horario, validar carga horaria, solicitar cambios.
- **Interacciones**: Lectura de su horario personalizado, generación de reportes de carga.
- **Frecuencia de uso**: Consulta ocasional (1-2 veces/semana), intensiva al inicio de semestre.
- **Requisitos**: Acceso solo a su propio horario; no ve otros instructores.

### 3. Admin de Ambientes
- **Responsabilidades**: Mantener catálogo de salones/labs, capacidades, recursos (proyector, whiteboard).
- **Interacciones**: CRUD de ambientes, control de disponibilidad.
- **Frecuencia de uso**: Bajo (cambios ocasionales de infraestructura).
- **Requisitos**: Acceso a inventario de espacios; datos de entrada para algoritmo de conflictos.

### 4. Operador de TI / DevOps
- **Responsabilidades**: Deployment, monitoreo, soporte técnico, backups.
- **Interacciones**: Acceso a logs, métricas, gestión de usuarios/permisos.
- **Frecuencia de uso**: Continua (monitoreo) + semanal (mantenimiento).
- **Requisitos**: Acceso administrativo; visibilidad de performance del sistema.

## Dependencias Externas

### Servicio de Autenticación
- **Tipo**: LDAP / OAuth2 / SSO institucional.
- **Responsabilidad**: Validar identidad de usuarios contra directorio corporativo.
- **Protocolo**: HTTP/REST con tokens JWT.
- **Criticidad**: CRÍTICA — sin autenticación, no funciona el sistema.

### Servicio de Correo (SMTP)
- **Tipo**: Servidor SMTP institucional o proveedor externo (SendGrid, AWS SES).
- **Responsabilidad**: Enviar notificaciones de cambios, confirmaciones de horarios.
- **Protocolo**: SMTP / REST API.
- **Criticidad**: Media — el sistema funciona sin correo, pero la comunicación se degrada.

### Almacenamiento de Objetos (S3 / Compatible)
- **Tipo**: AWS S3, MinIO, DigitalOcean Spaces, etc.
- **Responsabilidad**: Almacenar reportes en PDF/Excel, importaciones CSV de horarios.
- **Protocolo**: S3 API compatible.
- **Criticidad**: Media — funcionalidad de reportes y backups.

### ERP Institucional (Futura Integración)
- **Tipo**: Sistema de nómina, matrículas, evaluación de desempeño.
- **Responsabilidad**: Sincronizar datos de instructores, fichas, períodos académicos.
- **Protocolo**: REST API o webhooks.
- **Criticidad**: Baja (MVP no requiere; importante para automatización futura).

## Relaciones y Flujos de Datos

```txt
Coordinador Académico
         │
         ├────────→  [ SCHEDULER SYSTEM ]  ←────────┐
         │                    │                      │
         │                    │                      │
    CRUD Horarios        Validación de          Consulta de
    Conflictos          Conflictos (crítico)    horarios
         │                    │                      │
         │                    └────────→ Instructor
         │
         ├────────→ [ Autenticación ]  ← OAuth2/JWT
         │
         ├────────→ [ Correo ]  ← Notificaciones
         │
         ├────────→ [ Almacenamiento ]  ← Reportes/Backup
         │
         └────────→ [ ERP Institucional ]  ← Sincronización (futura)

Admin de Ambientes
         │
         └────────→ [ Inventario de Espacios ]  → Motor de Conflictos
```
