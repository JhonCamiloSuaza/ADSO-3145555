# C2 — Variante Minimal / MVP (Containers)

**Audiencia**: Desarrolladores, arquitectos, DevOps.

**Cuándo usar**: Prototipos, proyectos educativos, entornos de desarrollo local.

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

Ver `docs/C2/structure.md` para la comparación MVP ↔ Full.
