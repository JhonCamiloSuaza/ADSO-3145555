# C2 — Variante Full / Producción (Containers)

**Audiencia**: Arquitectos, DevOps, equipos de infraestructura.

**Cuándo usar**: Ambientes de producción, alta disponibilidad, escalado horizontal.

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

Ver `docs/C2/structure.md` para la comparación MVP ↔ Full.
