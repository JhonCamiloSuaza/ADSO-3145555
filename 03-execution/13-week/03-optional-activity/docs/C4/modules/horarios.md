# C4 — Módulo: Horarios (Code)

**Audiencia**: Desarrolladores de software y arquitectos del equipo.

**Cuándo usar**: Implementación del módulo de horarios, revisión de lógica crítica de conflictos.

```txt
Horarios Module
│
├── Entity
│   ├── atributos
│   │   ├── id: int (PK)
│   │   ├── day_of_week: int (0-4: Lun-Vie)
│   │   ├── start_time: time
│   │   ├── end_time: time
│   │   ├── instructor_id: int (FK)
│   │   ├── ambiente_id: int (FK)
│   │   ├── ficha_id: int (FK)
│   │   ├── created_at: datetime
│   │   └── updated_at: datetime
│   ├── constructor
│   ├── Getter (para cada atributo)
│   ├── Setter (para cada atributo)
│   ├── validate()     # validaciones básicas
│   └── to_dict()      # serialización
│
├── IRepository (Interfaz)
│   ├── save(horario: Horario) → Horario
│   ├── update(id: int, horario: Horario) → Horario
│   ├── delete(id: int) → bool
│   ├── findById(id: int) → Horario?
│   ├── findAll() → List[Horario]
│   ├── findByDay(day: int) → List[Horario]
│   └── find_conflicts(horario: Horario) → List[Horario]  # CRÍTICA
│
├── Repository (Implementación ORM)
│   ├── Implementa: IRepository
│   ├── save(horario) → INSERT INTO horarios
│   ├── update(id, horario) → UPDATE horarios
│   ├── delete(id) → DELETE FROM horarios
│   ├── findById(id) → SELECT * FROM horarios WHERE id = ?
│   ├── findAll() → SELECT * FROM horarios
│   ├── findByDay(day) → SELECT * WHERE day_of_week = ? [índice compuesto]
│   └── find_conflicts(horario)
│       ├── SELECT * FROM horarios
│       ├── WHERE day_of_week = :day
│       ├── AND NOT (end_time <= :start OR start_time >= :end)
│       ├── AND (instructor_id = :instr OR ambiente_id = :amb OR ficha_id = :ficha)
│       └── Retorna: List[Horario] con conflictos
│
├── IService (Interfaz)
│   ├── create(dto: HorarioDTO) → Horario
│   ├── validate_and_create(dto: HorarioDTO) → Horario  # CRÍTICA
│   ├── update(id: int, dto: HorarioDTO) → Horario
│   ├── delete(id: int) → bool
│   ├── getById(id: int) → Horario?
│   ├── getAll() → List[Horario]
│   ├── getByInstructor(instructor_id: int) → List[Horario]
│   ├── getByAmbiente(ambiente_id: int) → List[Horario]
│   └── calculate_occupancy() → float (%)
│
├── Service (Lógica de Negocio)
│   ├── Implementa: IService
│   ├── Inyecta: repository, conflict_validator
│   │
│   ├── validate_and_create(dto: HorarioDTO)
│   │   ├── 1. Valida estructura del DTO
│   │   ├── 2. Verifica FK: instructor, ambiente, ficha existen
│   │   ├── 3. Llama: repository.find_conflicts(dto)
│   │   ├── 4. Si hay conflictos → raise ApplicationError(409)
│   │   ├── 5. Si OK → repository.save()
│   │   └── 6. Retorna: Entity con id asignado
│   │
│   └── calculate_occupancy()
│       ├── slots_used = COUNT(*) FROM horarios
│       ├── total_slots = 5 días × horas disponibles
│       ├── occupancy = slots_used / total_slots
│       └── target: ≥ 75%
│
├── Controller (HTTP Endpoints)
│   ├── Inyecta: service
│   │
│   ├── POST /horarios
│   │   ├── Recibe: HorarioDTO (raw JSON)
│   │   ├── Auth: Verifica JWT válido
│   │   ├── Autoriza: coordinador o admin
│   │   ├── Llama: service.validate_and_create(dto)
│   │   ├── Si error → 409 Conflict {error, conflicts_list}
│   │   └── Si OK → 201 Created {id, horario}
│   │
│   ├── GET /horarios/{id}
│   │   ├── Autoriza: cualquier usuario autenticado
│   │   └── Retorna: 200 OK {horario}
│   │
│   ├── PUT /horarios/{id}
│   │   ├── Recibe: HorarioDTO (partial update)
│   │   └── Retorna: 200 OK {updated_horario}
│   │
│   └── DELETE /horarios/{id}
│       ├── Verifica: no está siendo usado
│       └── Retorna: 204 No Content
│
├── DTO
│   ├── HorarioRequestDTO
│   │   ├── atributos
│   │   │   ├── day_of_week: int (0-4)
│   │   │   ├── start_time: str ("HH:MM:SS")
│   │   │   ├── end_time: str ("HH:MM:SS")
│   │   │   ├── instructor_id: int
│   │   │   ├── ambiente_id: int
│   │   │   └── ficha_id: int
│   │   ├── constructor
│   │   ├── Getter
│   │   └── Setter
│   │
│   └── HorarioResponseDTO
│       ├── atributos
│       │   ├── id: int
│       │   ├── day_of_week: int
│       │   ├── start_time: str
│       │   ├── end_time: str
│       │   ├── instructor_id: int
│       │   ├── ambiente_id: int
│       │   ├── ficha_id: int
│       │   ├── created_at: datetime (ISO8601)
│       │   └── updated_at: datetime (ISO8601)
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
│   └── ConflictValidator
│       └── check_interval_overlap(start1, end1, start2, end2) → bool
│
└── Exceptions
    ├── ScheduleConflictError
    │   ├── mensaje: "Instructor XX ya asignado Lunes 09:00-10:30"
    │   └── conflicting_horarios: List[Horario]
    └── InvalidHorarioError
        └── mensaje: "start_time no puede ser >= end_time"
```

Ver `docs/C4/structure.md` para el documento completo con diagramas de clases y flujos end-to-end.
