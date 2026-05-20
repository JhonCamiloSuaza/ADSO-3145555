# AllProject — Estructura (Tradicional por Capas)

**Audiencia**: Desarrolladores y diseñadores de software.

**Cuándo usar**: Proyectos de tamaño pequeño a mediano, o con fines de aprendizaje, donde separar las responsabilidades físicas por tipo de artefacto (capas globales) facilita encontrar los componentes técnicos.

```txt
AllProject
│
├── Entity
│   ├── Security (User, Role, Token)
│   ├── Inventory (Ambiente, Instructor, Ficha)
│   └── Schedule (Horario, Conflict)
│
├── IRepository (Interfaces de Persistencia)
│   ├── SecurityRepository
│   ├── InventoryRepository
│   └── ScheduleRepository
│
├── Repository (Implementación ORM / SQL)
│   ├── SecurityRepositoryImpl
│   ├── InventoryRepositoryImpl
│   └── ScheduleRepositoryImpl
│
├── IService (Interfaces de Lógica de Negocio)
│   ├── SecurityService
│   ├── InventoryService
│   └── ScheduleService
│
├── Service (Implementación de Negocio)
│   ├── SecurityServiceImpl
│   ├── InventoryServiceImpl
│   └── ScheduleServiceImpl
│
├── Controller (Controladores REST / HTTP)
│   ├── SecurityController
│   ├── InventoryController
│   └── ScheduleController
│
├── DTO (Data Transfer Objects)
│   ├── SecurityDTOs (LoginRequest, TokenResponse)
│   ├── InventoryDTOs (AmbienteDTO, InstructorDTO)
│   └── ScheduleDTOs (HorarioDTO, ConflictDTO)
│
├── IDTO (Mapeadores de DTO a Entidad)
│   ├── SecurityMapper
│   ├── InventoryMapper
│   └── ScheduleMapper
│
└── Utils
    ├── JWT (Manejo de tokens)
    ├── ProcessInventory (Validaciones de inventario)
    └── ConflictValidator (Validación de triple restricción de horarios)
```

## Ventajas y Desventajas
- **Ventajas**: Muy fácil de entender para principiantes, estructura estandarizada y directa.
- **Desventajas**: Baja cohesión por dominio. Si deseas modificar la entidad Horario, debes tocar archivos en 7 carpetas diferentes a lo largo de todo el proyecto.
