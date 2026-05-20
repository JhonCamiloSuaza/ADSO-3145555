# ByModule — Estructura Organizada por Dominios / Módulos

**Audiencia**: Desarrolladores, arquitectos de software, equipos ágiles.

**Cuándo usar**: **Esta es la arquitectura recomendada para el proyecto.** Se utiliza en sistemas medianos y grandes porque agrupa los archivos por dominio de negocio (cohesión funcional), permitiendo que un equipo o desarrollador sea dueño de un módulo completo sin interferir con otros.

```txt
ByModule
│
├── Security (Módulo de Autenticación y Autorización)
│   ├── Entity (User, Role, Token)
│   ├── IRepository (SecurityRepository)
│   ├── Repository (SecurityRepositoryImpl)
│   ├── IService (SecurityService)
│   ├── Service (SecurityServiceImpl)
│   ├── Controller (SecurityController)
│   ├── DTO (LoginRequest, TokenResponse)
│   ├── IDTO (SecurityMapper)
│   └── Utils (JWT)
│
├── Inventory (Módulo de Catálogos de Ambientes, Instructores y Fichas)
│   ├── Entity (Ambiente, Instructor, Ficha)
│   ├── IRepository (InventoryRepository)
│   ├── Repository (InventoryRepositoryImpl)
│   ├── IService (InventoryService)
│   ├── Service (InventoryServiceImpl)
│   ├── Controller (InventoryController)
│   ├── DTO (AmbienteDTO, InstructorDTO, FichaDTO)
│   ├── IDTO (InventoryMapper)
│   └── Utils (ProcessInventory)
│
├── Schedule (Módulo de Asignación y Gestión de Horarios)
│   ├── Entity (Horario)
│   ├── IRepository (ScheduleRepository)
│   ├── Repository (ScheduleRepositoryImpl)
│   ├── IService (ScheduleService)
│   ├── Service (ScheduleServiceImpl)
│   ├── Controller (ScheduleController)
│   ├── DTO (HorarioDTO)
│   ├── IDTO (ScheduleMapper)
│   └── Utils (ConflictValidator - Triple Restricción)
│
└── Observation (Módulo de Novedades y Seguimiento)
    ├── Entity (Observation)
    ├── IRepository (ObservationRepository)
    ├── Repository (ObservationRepositoryImpl)
    ├── IService (ObservationService)
    ├── Service (ObservationServiceImpl)
    ├── Controller (ObservationController)
    ├── DTO (ObservationDTO)
    └── IDTO (ObservationMapper)
```

## Ventajas y Desventajas
- **Ventajas**: Altísima cohesión. Los archivos que cambian juntos están juntos en la misma carpeta física. Facilita la división de tareas, la mantenibilidad del código y la futura migración a microservicios.
- **Desventajas**: Requiere disciplina para no crear acoplamientos innecesarios o referencias circulares entre módulos.
