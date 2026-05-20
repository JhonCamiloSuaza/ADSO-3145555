# C3 — Components (Componentes)

## ¿Qué es C3?
Expande un contenedor específico (el API Server) para mostrar los **módulos y capas que lo conforman**: entidades, repositorios, servicios, controladores, DTOs y utilidades.

## Audiencia
Exclusivamente desarrolladores de software y arquitectos del equipo.

## Contenido de este nivel

| Archivo | Descripción |
|---------|-------------|
| `structure.md` | Resumen de las 5 variantes de organización de componentes |
| `full.md` | Documento completo con todos los árboles detallados por variante |
| `variants/AllProject.md` | Organización tradicional por capas globales |
| `variants/ByModule.md` | Organización por dominio/módulo (recomendada) |
| `variants/MVC.md` | Patrón Model-View-Controller |
| `variants/DDD.md` | Domain Driven Design (dominios complejos) |
| `variants/Microservices.md` | Evolución hacia microservicios independientes |

## Variantes disponibles

- **AllProject** → Organiza todo el proyecto por tipo de artefacto: `Entity`, `IRepository`, `IService`, `Service`, `Controller`, `DTO`, `IDTO`, `Utils`. Útil para proyectos pequeños o educativos.
- **ByModule** → Organiza por dominio. Cada módulo (`Security`, `Inventory`, `Schedule`) contiene sus propios artefactos. **Recomendada para este proyecto.**
- **MVC** → Separa en `Model`, `View`, `Controller`. Útil para aplicaciones con renderizado en servidor.
- **DDD** → Separación profunda entre `Domain`, `Application`, `Infrastructure` y `Presentation`. Para dominios complejos.
- **Microservices** → Transición de monolito modular a servicios independientes por dominio.
