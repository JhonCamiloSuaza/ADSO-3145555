# C2 — Containers (Contenedores)

## Variante MVP (Minimal)

```txt
Containers (MVP)
│
├── Web UI
│   ├── Framework: React / Vue / Vite
│   ├── Lenguaje: JavaScript / TypeScript
│   ├── Protocolo de salida: HTTP REST JSON
│   └── Responsabilidades
│       ├── Renderizar interfaz de usuario
│       ├── Validar formularios antes de enviar
│       ├── Gestionar sesión y token JWT
│       └── Consumir endpoints del API Server
│
├── API Server
│   ├── Framework: FastAPI / Express / Spring Boot
│   ├── Lenguaje: Python / Node.js / Java
│   ├── Protocolo de entrada: HTTP REST JSON
│   ├── Protocolo de salida: SQL Queries
│   └── Responsabilidades
│       ├── Lógica de negocio
│       ├── Validación de conflictos de horarios
│       ├── Autenticación y generación de JWT
│       └── Endpoints CRUD (Horarios, Instructores, Ambientes, Fichas)
│
└── Database
    ├── Motor: PostgreSQL / SQLite
    ├── Tipo: Relacional
    ├── Protocolo: TCP / SQL
    ├── Tablas
    │   ├── Horarios
    │   ├── Instructores
    │   ├── Ambientes
    │   ├── Fichas (Grupos Académicos)
    │   └── Usuarios
    └── Índices
        ├── (day_of_week, instructor_id)
        ├── (day_of_week, ambiente_id)
        └── (day_of_week, ficha_id)
```

---

## Variante Full (Producción)

```txt
Containers (Full)
│
├── Web UI
│   ├── Framework: React + Vite
│   ├── Hosting: CDN (CloudFront / CloudFlare)
│   ├── Protocolo de salida: HTTPS
│   └── Características
│       ├── PWA habilitado (soporte offline)
│       └── Cache de assets estáticos (CSS, JS, imágenes)
│
├── Load Balancer
│   ├── Tecnología: Nginx / AWS ALB
│   ├── Protocolo de salida: HTTP interno
│   └── Responsabilidades
│       ├── Distribuir tráfico entre réplicas de API
│       ├── Terminación TLS / SSL
│       └── Health Checks automáticos
│
├── API Server (Réplicas)
│   ├── Instancia API-1
│   │   ├── Framework: FastAPI
│   │   └── Puerto: 8000
│   ├── Instancia API-2
│   │   ├── Framework: FastAPI
│   │   └── Puerto: 8001
│   ├── Instancia API-N
│   │   ├── Framework: FastAPI
│   │   └── Puerto: 800x
│   └── Características de cada instancia
│       ├── Stateless (sin estado compartido)
│       ├── Conecta a Pool de DB
│       └── Conecta a Redis Cache
│
├── Database
│   ├── PostgreSQL Primary
│   │   ├── Tipo: Escrituras (INSERT, UPDATE, DELETE)
│   │   └── Replicación: Streaming hacia Replica
│   └── PostgreSQL Replica
│       ├── Tipo: Lecturas (SELECT)
│       └── Modo: Read-Only
│
├── Cache
│   └── Redis
│       ├── TTL: 1 hora
│       ├── Sessions JWT activas
│       ├── Horarios consultados frecuentemente
│       └── Resultados de reportes recientes
│
├── Auth Service
│   ├── Tecnología: LDAP / OAuth2
│   └── Responsabilidades
│       ├── Validar credenciales del usuario
│       ├── Generar y firmar tokens JWT
│       └── Gestionar expiración de sesiones
│
├── Background Worker
│   ├── Tecnología: Celery / RQ
│   ├── Cola de mensajes: Redis / RabbitMQ
│   └── Tareas
│       ├── Exportación de reportes PDF / Excel
│       ├── Importación masiva de datos desde CSV
│       ├── Sincronización futura con ERP Institucional
│       └── Envío de emails de notificación (async)
│
├── Object Storage
│   ├── Tecnología: AWS S3 / MinIO
│   └── Contenido almacenado
│       ├── Reportes PDF generados
│       ├── Exportaciones Excel / CSV
│       └── Backups incrementales de la base de datos
│
└── Logging y Monitoreo
    ├── ELK Stack
    │   ├── Elasticsearch  (indexación de logs)
    │   ├── Logstash       (recolección y parseo)
    │   └── Kibana         (visualización y dashboards)
    ├── Prometheus
    │   ├── Métricas de rendimiento de la API
    │   └── Alertas por umbral (latencia, errores)
    └── Grafana
        └── Dashboards de métricas en tiempo real
```

---

## Comparación MVP ↔ Full

```txt
Aspecto               MVP                             Full
────────────────────────────────────────────────────────────────────
Réplicas de API       1 instancia directa             N réplicas + Load Balancer
Base de Datos         SQLite / PostgreSQL local        PostgreSQL Primary + Replica
Caché                 Ninguno                         Redis (TTL 1 hora)
Autenticación         JWT validado localmente en DB   Servicio externo LDAP / OAuth2
Generación Reportes   Síncrona (bloquea el hilo)      Asíncrona (Background Worker)
Almacenamiento        Disco local del servidor        Object Storage 
Monitoreo de Logs     stdout (consola del servidor)   ELK Stack + Prometheus + Grafana
Failover              Reinicio manual                 Recuperación automática
```
