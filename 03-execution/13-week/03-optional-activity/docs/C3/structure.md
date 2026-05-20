# C3 — Components

## Estructura

```txt
docs/C3
├── structure.md           # este archivo
├── full.md                # documento completo con todas las variantes
├── README.md              # resumen de opciones
└── variants/
    ├── AllProject/
    │   ├── README.md      # Por capas (Entity, Repository, Service...)
    │   └── example_tree.txt
    ├── ByModule/
    │   ├── README.md      # Por dominio (recomendado)
    │   ├── example_tree.txt
    │   └── module_structure.md
    ├── MVC/
    │   ├── README.md      # Model-View-Controller (para UI)
    │   └── example_tree.txt
    ├── DDD/
    │   ├── README.md      # Domain Driven Design (dominios complejos)
    │   └── example_tree.txt
    └── Microservices/
        ├── README.md      # Evolución a microservicios
        └── example_tree.txt
```

## Por qué

- C3 descompone un contenedor (p.ej. API Server) en **componentes y módulos**.
- Existen múltiples patrones de organización; la elección depende del tamaño del proyecto y del equipo.

## Variantes principales

### 1. AllProject (Tradicional por Capas)

Organización por tipo de artefacto (capas globales):

```txt
AllProject
├── Entity/
│   ├── Security
│   └── Inventory
├── IRepository/
├── IService/
├── Service/
├── Controller/
├── DTO/
└── Utils/
```

**Uso**: Proyectos muy pequeños o educativos. **Desventaja**: Baja cohesión por dominio.

### 2. ByModule (Por Dominio) — RECOMENDADO

Organización por módulo/dominio. Cada módulo contiene sus propios artefactos:

```txt
ByModule
├── Security/
│   ├── Entity
│   ├── IRepository
│   ├── Service
│   ├── Controller
│   └── Utils/JWT
├── Inventory/
├── Schedule/
│   └── Utils/ConflictValidator
└── Observation/
```

**Uso**: Proyectos medianos/grandes. **Ventaja**: Alta cohesión, facilita equipos y escalado.

### 3. MVC (Model-View-Controller)

Patrón clásico, útil para capas de UI:

```txt
MVC
├── Model/
│   ├── Horario
│   ├── Instructor
│   └── Ambiente
├── View/
│   ├── Dashboard
│   └── SchedulerUI
└── Controller/
    └── HorarioController
```

**Uso**: Aplicaciones con renderizado servidor o UI compleja.

### 4. DDD (Domain Driven Design)

Separación profunda entre dominio, aplicación e infraestructura:

```txt
DDD
├── Domain/
│   ├── Entities
│   ├── ValueObjects
│   ├── Aggregates
│   ├── RepositoryInterfaces
│   └── DomainServices
├── Application/
│   ├── UseCases
│   ├── DTOs
│   └── Interfaces
├── Infrastructure/
│   ├── Persistence
│   ├── Repositories
│   └── ExternalServices
└── Presentation/
    ├── Controllers
    └── Views
```

**Uso**: Dominios complejos con reglas de negocio críticas.

### 5. Evolución a Microservicios

Transición de monolito modular a servicios independientes:

```txt
Monolithic Modular         →         Microservices
├── Security                         ├── Auth Service
├── Schedule                         ├── Schedule Service
├── Instructor                       ├── Instructor Service
├── Environment                      ├── Environment Service
├── Observation                      ├── Observation Service
└── Reports                          └── Report Service
```

**Uso**: Cuando se necesita escalabilidad independiente por dominio.

---

Ver `full.md` para el documento completo del compañero con todos los árboles detallados.
