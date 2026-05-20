# C1 — Variante Simple (System Context)

**Audiencia**: Ejecutivos, gerentes de producto, stakeholders no técnicos.

**Cuándo usar**: Reuniones de negocio, presentaciones ejecutivas, inicio del proyecto.

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

Ver `docs/C1/structure.md` para la versión completa con roles, permisos y flujos de interacción.
