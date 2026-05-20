# C4 — Módulo: Inventory (Code)

**Audiencia**: Desarrolladores de software y arquitectos del equipo.

**Cuándo usar**: Implementación del módulo de inventario (Ambientes, Instructores, Fichas).

```txt
Inventory Module
│
├── Entity
│   ├── AmbienteEntity
│   │   ├── atributos
│   │   │   ├── id: int (PK)
│   │   │   ├── name: str
│   │   │   ├── capacity: int
│   │   │   ├── type: enum (SALON, LAB, VIRTUAL)
│   │   │   ├── is_active: bool
│   │   │   ├── created_at: datetime
│   │   │   └── updated_at: datetime
│   │   ├── constructor
│   │   ├── Getter (para cada atributo)
│   │   ├── Setter (para cada atributo)
│   │   └── to_dict()
│   │
│   ├── InstructorEntity
│   │   ├── atributos
│   │   │   ├── id: int (PK)
│   │   │   ├── full_name: str
│   │   │   ├── email: str
│   │   │   ├── specialty: str
│   │   │   ├── max_hours_week: int
│   │   │   ├── is_active: bool
│   │   │   ├── created_at: datetime
│   │   │   └── updated_at: datetime
│   │   ├── constructor
│   │   ├── Getter (para cada atributo)
│   │   ├── Setter (para cada atributo)
│   │   └── to_dict()
│   │
│   └── FichaEntity
│       ├── atributos
│       │   ├── id: int (PK)
│       │   ├── code: str
│       │   ├── program: str
│       │   ├── level: str
│       │   ├── start_date: date
│       │   ├── end_date: date
│       │   └── is_active: bool
│       ├── constructor
│       ├── Getter (para cada atributo)
│       ├── Setter (para cada atributo)
│       └── to_dict()
│
├── IRepository (Interfaz)
│   ├── save(entity) → Entity
│   ├── update(id: int, entity) → Entity
│   ├── delete(id: int) → bool
│   ├── findById(id: int) → Entity?
│   ├── findAll() → List[Entity]
│   └── findByActive(is_active: bool) → List[Entity]
│
├── Repository (Implementación ORM)
│   ├── AmbienteRepository
│   │   ├── Implementa: IRepository
│   │   ├── save(ambiente) → INSERT INTO ambientes
│   │   ├── findAll() → SELECT * FROM ambientes
│   │   └── findByType(type) → SELECT * WHERE type = ?
│   │
│   ├── InstructorRepository
│   │   ├── Implementa: IRepository
│   │   ├── save(instructor) → INSERT INTO instructores
│   │   ├── findAll() → SELECT * FROM instructores
│   │   └── findBySpecialty(specialty) → SELECT * WHERE specialty = ?
│   │
│   └── FichaRepository
│       ├── Implementa: IRepository
│       ├── save(ficha) → INSERT INTO fichas
│       ├── findAll() → SELECT * FROM fichas
│       └── findByProgram(program) → SELECT * WHERE program = ?
│
├── IService (Interfaz)
│   ├── create(dto) → Entity
│   ├── update(id: int, dto) → Entity
│   ├── delete(id: int) → bool
│   ├── getById(id: int) → Entity?
│   └── getAll() → List[Entity]
│
├── Service (Lógica de Negocio)
│   ├── AmbienteService
│   │   ├── Implementa: IService
│   │   ├── Inyecta: ambienteRepository
│   │   └── create(dto) → valida capacidad > 0 → save()
│   │
│   ├── InstructorService
│   │   ├── Implementa: IService
│   │   ├── Inyecta: instructorRepository
│   │   └── create(dto) → valida max_hours > 0 → save()
│   │
│   └── FichaService
│       ├── Implementa: IService
│       ├── Inyecta: fichaRepository
│       └── create(dto) → valida start_date < end_date → save()
│
├── Controller (HTTP Endpoints)
│   ├── AmbienteController
│   │   ├── GET  /ambientes         → 200 OK [ambientes]
│   │   ├── GET  /ambientes/{id}    → 200 OK {ambiente}
│   │   ├── POST /ambientes         → 201 Created {ambiente}
│   │   ├── PUT  /ambientes/{id}    → 200 OK {updated}
│   │   └── DELETE /ambientes/{id} → 204 No Content
│   │
│   ├── InstructorController
│   │   ├── GET  /instructores         → 200 OK [instructores]
│   │   ├── GET  /instructores/{id}    → 200 OK {instructor}
│   │   ├── POST /instructores         → 201 Created {instructor}
│   │   ├── PUT  /instructores/{id}    → 200 OK {updated}
│   │   └── DELETE /instructores/{id} → 204 No Content
│   │
│   └── FichaController
│       ├── GET  /fichas         → 200 OK [fichas]
│       ├── GET  /fichas/{id}    → 200 OK {ficha}
│       ├── POST /fichas         → 201 Created {ficha}
│       ├── PUT  /fichas/{id}    → 200 OK {updated}
│       └── DELETE /fichas/{id} → 204 No Content
│
├── DTO
│   ├── AmbienteDTO
│   │   ├── atributos: name, capacity, type, is_active
│   │   ├── constructor
│   │   ├── Getter
│   │   └── Setter
│   │
│   ├── InstructorDTO
│   │   ├── atributos: full_name, email, specialty, max_hours_week
│   │   ├── constructor
│   │   ├── Getter
│   │   └── Setter
│   │
│   └── FichaDTO
│       ├── atributos: code, program, level, start_date, end_date
│       ├── constructor
│       ├── Getter
│       └── Setter
│
├── IDTO
│   ├── entityToDTO()
│   ├── dtoToEntity()
│   └── mapper()
│
├── Utils
│   └── ProccessInventory
│       ├── validateCapacity(capacity: int) → bool
│       ├── validateDateRange(start: date, end: date) → bool
│       └── validateHoursLimit(hours: int) → bool
│
└── Exceptions
    ├── InvalidAmbienteError
    │   └── mensaje: "Capacidad del ambiente debe ser mayor a 0"
    ├── InvalidInstructorError
    │   └── mensaje: "Horas máximas semanales deben ser mayor a 0"
    └── InvalidFichaError
        └── mensaje: "Fecha de inicio debe ser anterior a fecha de fin"
```

Ver `docs/C4/structure.md` para el documento completo con diagramas de clases y flujos end-to-end.
