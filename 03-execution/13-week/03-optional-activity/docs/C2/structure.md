# C2 — Containers

## Estructura de Documentación

```txt
docs/C2
├── structure.md           # este archivo
├── containerization.md    # principios de descomposición
├── diagrams/
│   ├── minimal.drawio     # MVP
│   └── full.drawio        # Producción
├── variants/
│   ├── minimal/
│   │   ├── README.md      # MVP: Web UI + API + Database (rápido)
│   │   ├── architecture.md    # Diagrama ASCII y descripción
│   │   └── tech_stack.md      # Tecnologías: FastAPI, SQLite
│   └── full/
│       ├── README.md      # Producción: +Auth, Worker, Storage, Cache
│       ├── architecture.md    # Diagrama ASCII detallado
│       └── scaling_strategy.md
└── components/
    ├── web_ui.md          # SPA (React/Vue/Angular)
    ├── api_server.md      # FastAPI / Node.js
    ├── database.md        # PostgreSQL o SQLite
    ├── auth_service.md    # LDAP / OAuth2
    ├── worker.md          # Background jobs (Celery)
    ├── cache.md           # Redis / Memcached
    └── storage.md         # S3 / MinIO
```

## Por qué C2 es crítico

C2 descompone el sistema en **aplicaciones y almacenes de datos** (contenedores):
- Define la arquitectura ejecutable (qué procesos corren).
- Establece límites de escalabilidad independiente.
- Identifica puntos de fallo crítico.
- Base para decisiones de tecnología en C3 y C4.

---

## Variante 1: MINIMAL (MVP - Prototipo Rápido)

### Arquitectura

```txt
┌─────────────────────────────────────────────────────────────┐
│                    USUARIOS FINALES                         │
└─────────────────┬───────────────────────────────────────────┘
                  │ HTTP/HTTPS (puerto 80/443)
                  ↓
┌─────────────────────────────────────────────────────────────┐
│  Web UI (SPA - React/Vue/Angular)                          │
│  • Interfaz de usuario responsiva                          │
│  • Validación de datos en cliente                          │
│  • Comunicación REST con API                               │
│  Tecnología: Node.js express / Vite dev server             │
└─────────────────┬───────────────────────────────────────────┘
                  │ REST API (JSON)
                  │ endpoints: POST /horarios, GET /horarios/{id}, etc.
                  ↓
┌─────────────────────────────────────────────────────────────┐
│  API Server (FastAPI / Node.js Express / Flask)            │
│  • Lógica de negocio (validación de conflictos)            │
│  • Gestión de autenticación con JWT                        │
│  • Endpoints CRUD para recursos                           │
│  Tecnología: FastAPI (Python) recomendado                  │
└─────────────────┬───────────────────────────────────────────┘
                  │ SQL Queries
                  │ Connection pooling
                  ↓
┌─────────────────────────────────────────────────────────────┐
│  Database (SQLite para MVP / PostgreSQL producción)         │
│  • Tablas: Horarios, Instructores, Ambientes, Fichas      │
│  • Índices en day_of_week, instructor_id, ambiente_id     │
│  • Relaciones FK entre tablas                             │
│  Tecnología: SQLite (0 configuración, perfecto para MVP)  │
└─────────────────────────────────────────────────────────────┘
```

### Responsabilidades por Contenedor

| Contenedor | Responsabilidad | Protocolo | Datos Almacenados |
|-----------|-----------------|-----------|-------------------|
| **Web UI** | Renderización, eventos, llamadas API | HTTP REST JSON | Estado local (caché de sesión) |
| **API** | Lógica de negocio, validación, autorización | HTTP REST / SQL | En memoria (cachés de corta duración) |
| **Database** | Persistencia de estado, ACID | SQL / JDBC | Tablas: Horarios, Instructores, Ambientes, Fichas |

### Flujo de una Operación (Ejemplo: Crear Horario)

```
Coordinador: Click "Crear Horario"
    │
    ↓
[Web UI] - Valida campos
    │
    ↓ POST /api/horarios { day_of_week, start_time, end_time, instructor_id, ambiente_id, ficha_id }
[API Server] - Recibe DTO
    │
    ├─ Autentica JWT
    ├─ Valida que instructor, ambiente, ficha existan
    ├─ Llama ConflictValidator.find_conflicts()
    │  └─ SELECT * FROM horarios WHERE [intersección]
    ├─ Si NO hay conflicto: INSERT INTO horarios ...
    ├─ Si HAY conflicto: Retorna 409 Conflict con detalles
    │
    ↓ Response 201 Created {id, horario}
[Web UI] - Muestra notificación de éxito
```

---

## Variante 2: FULL (Producción - Robusto y Escalable)

### Arquitectura Completa

```txt
┌──────────────────────────────────────────────────────────────────┐
│                    USUARIOS FINALES                              │
└──────────────────┬────────────────────────────────────────────────┘
                   │ HTTP/HTTPS (CDN cachea assets)
                   ↓
┌──────────────────────────────────────────────────────────────────┐
│  Web UI (SPA - React/Vue, servida desde CDN)                    │
│  • Cache de static assets (CSS, JS, imgs)                       │
│  • Progressive Web App (offline capability)                     │
│  Tecnología: Webpack / Vite + CDN (CloudFlare, AWS CloudFront)  │
└──────────────────┬────────────────────────────────────────────────┘
                   │ REST API (JSON)
                   ↓
┌──────────────────────────────────────────────────────────────────┐
│  Load Balancer (ej. Nginx, AWS ALB)                             │
│  • Distribuye tráfico entre N instancias de API Server          │
│  • Terminación TLS/SSL                                          │
│  • Health checks                                                │
└──────────────────┬────────────────────────────────────────────────┘
        │          │          │
        ↓          ↓          ↓
   ┌────────┐ ┌────────┐ ┌────────┐
   │ API-1  │ │ API-2  │ │ API-N  │  (replicas horizontales)
   │FastAPI │ │FastAPI │ │FastAPI │  • Cada instancia stateless
   │:8000   │ │:8001   │ │:800x   │  • Conecta a DB pool + Cache
   └────────┘ └────────┘ └────────┘
        │          │          │
        └──────────┬──────────┘
                   │ SQL (connection pool)
                   ├─ Lectura: primaria
                   └─ Escritura: réplica con failover
                   ↓
         ┌─────────────────────────┐
         │  PostgreSQL Primary     │  (escrituras)
         │  • Replicación streaming│
         │  • Índices en horarios  │
         └────────────┬────────────┘
                      │ async replication
                      ↓
         ┌─────────────────────────┐
         │  PostgreSQL Replica     │  (lecturas)
         │  • Read-only            │
         └─────────────────────────┘

        ┌──────────────────────────────────────┐
        │  Redis / Memcached (Cache)           │
        │  • Cache de horarios frecuentes      │
        │  • Sessions JWT                      │
        │  • TTL: 1 hora                       │
        └──────────────────────────────────────┘

        ┌──────────────────────────────────────┐
        │  Auth Service (LDAP / OAuth2)        │
        │  • Validación de credenciales        │
        │  • Generación de JWT                 │
        └──────────────────────────────────────┘

        ┌──────────────────────────────────────┐
        │  Background Worker (Celery / RQ)     │
        │  • Exportación de reportes (PDF/XLS) │
        │  • Importación de CSV                │
        │  • Sincronización con ERP (futura)   │
        └──────────────────────────────────────┘

        ┌──────────────────────────────────────┐
        │  Object Storage (S3 / MinIO)         │
        │  • Reportes generados (PDF)          │
        │  • Backups incrementales             │
        │  • Exports (CSV, Excel)              │
        └──────────────────────────────────────┘

        ┌──────────────────────────────────────┐
        │  Logging & Monitoring                │
        │  • ELK Stack (Elasticsearch, Kibana) │
        │  • Prometheus + Grafana              │
        │  • DataDog / New Relic (optional)    │
        └──────────────────────────────────────┘
```

### Responsabilidades en Producción

| Contenedor | Responsabilidad | Tecnología |
|-----------|-----------------|-------------|
| **Web UI** | Interfaz, estado local, llamadas API | React + Vite + CDN |
| **Load Balancer** | Distribuir tráfico, TLS termination | Nginx / AWS ALB |
| **API Server (N)** | Lógica de negocio, validación | FastAPI (replicas) |
| **PostgreSQL** | Persistencia ACID, replicación | Primary + Replica |
| **Cache** | Acelerar lecturas frecuentes | Redis TTL 1h |
| **Auth Service** | Validar identidades, generar JWT | LDAP / OAuth2 |
| **Worker** | Reportes, ETL, trabajos async | Celery + RQ |
| **Object Storage** | Almacenar reportes y backups | S3 / MinIO |
| **Logging** | Trazabilidad, debugging, alertas | ELK + Prometheus |

### Diferencias MVP ↔ Producción

| Aspecto | MVP | Producción |
|--------|-----|------------|
| **Database** | SQLite (1 archivo) | PostgreSQL (replicado) |
| **API Replicas** | 1 | 3+ (behind load balancer) |
| **Cache** | None | Redis (1h TTL) |
| **Auth** | JWT simple en DB | LDAP / OAuth2 service |
| **Reportes** | Síncronos (esperar) | Background worker async |
| **Storage** | Filesystem | S3 / MinIO |
| **Logging** | stdout | ELK Stack + alertas |
| **Failover** | Manual | Automático |
| **Escalabilidad** | Vertical | Horizontal |

---

## Decisiones de Diseño

### Por qué FastAPI en la capa API
- Soporte nativo de async/await (I/O-bound operations)
- Documentación automática Swagger
- Type hints → validación automática
- Performance comparable a Go

### Por qué PostgreSQL en producción
- Soporte de índices complejos (BTREE, GIN)
- Full-text search para reportes
- Replicación nativa
- JSONB para datos semi-estructurados (futuros reportes)

### Por qué Redis para caché
- Cachea horarios frecuentes (operación de lectura masiva)
- Sessions JWT → no volver a DB
- TTL automático (invalida después de 1h)
- Mejora latencia p95 de API
