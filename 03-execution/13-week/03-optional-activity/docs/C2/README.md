# C2 — Containers (Contenedores)

## ¿Qué es C2?
Descompone el sistema central en sus **aplicaciones y almacenes de datos principales**. Muestra las decisiones tecnológicas clave y los protocolos de comunicación utilizados (REST, SQL, HTTPS).

## Audiencia
Desarrolladores, arquitectos y personal de operaciones (DevOps).

## Contenido de este nivel

| Archivo | Descripción |
|---------|-------------|
| `structure.md` | Árbol completo de contenedores (MVP + Full) con tabla comparativa |
| `variants/minimal.md` | Variante MVP: 3 contenedores (Web UI, API Server, Database) |
| `variants/full.md` | Variante Full: 9 contenedores con alta disponibilidad y escalado horizontal |

## Variantes disponibles

- **Minimal (MVP)** → Para prototipos y entornos locales. Un servidor, base de datos embebida, sin cache ni workers externos.
- **Full (Producción)** → Para ambientes de alta disponibilidad. Incluye Load Balancer, réplicas de API, PostgreSQL con replicación, Redis, Auth Service, Background Workers, Object Storage y ELK Stack.
