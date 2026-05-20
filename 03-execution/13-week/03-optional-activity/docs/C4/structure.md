# C4 — Code (Nivel de Implementación)

## Estructura: Módulo Horarios (ByModule - Recomendado)

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
│   ├── validate()  # validaciones básicas
│   └── to_dict()   # serialización
│
├── IRepository (Interfaz)
│   ├── save(horario: Horario) → Horario
│   ├── update(id: int, horario: Horario) → Horario
│   ├── delete(id: int) → bool
│   ├── findById(id: int) → Horario?
│   ├── findAll() → List[Horario]
│   ├── findByDay(day: int) → List[Horario]
│   └── find_conflicts(horario: Horario) → List[Horario]  CRÍTICA
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
│   ├── validate_and_create(dto: HorarioDTO) → Horario  CRÍTICA
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
│   ├── update(id: int, dto: HorarioDTO)
│   │   ├── 1. Obtiene Entity actual
│   │   ├── 2. Valida nuevo DTO
│   │   ├── 3. Si campos críticos cambiaron → check_conflicts
│   │   ├── 4. Si OK → repository.update()
│   │   └── 5. Retorna: Entity actualizado
│   │
│   ├── getByInstructor(instructor_id)
│   │   ├── Retorna: horarios del instructor
│   │   └── Cálculo de carga horaria
│   │
│   └── calculate_occupancy()
│       ├── slots_used = COUNT(*) FROM horarios
│       ├── total_slots = 5 días × 24 horas / duración_promedio
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
│   │   ├── Valida: estructura y campos obligatorios
│   │   ├── Llama: service.validate_and_create(dto)
│   │   ├── Si error → 409 Conflict {error, conflicts_list}
│   │   └── Si OK → 201 Created {id, horario}
│   │
│   ├── GET /horarios/{id}
│   │   ├── Autoriza: cualquier usuario autenticado
│   │   ├── Llama: service.getById(id)
│   │   └── Retorna: 200 OK {horario}
│   │
│   ├── PUT /horarios/{id}
│   │   ├── Recibe: HorarioDTO (partial update)
│   │   ├── Valida: no crear conflictos con update
│   │   ├── Llama: service.update(id, dto)
│   │   └── Retorna: 200 OK {updated_horario}
│   │
│   ├── DELETE /horarios/{id}
│   │   ├── Verifica: no está siendo usado
│   │   ├── Llama: service.delete(id)
│   │   └── Retorna: 204 No Content
│   │
│   └── GET /horarios?day=0&instructor_id=5&ambiente_id=101
│       ├── Query params con filtros
│       ├── Llama: service.getByDay() / service.getByInstructor()
│       └── Retorna: 200 OK [horarios]
│
├── DTO
│   ├── HorarioRequestDTO
│   │   ├── atributos
│   │   │   ├── day_of_week: int (1-4)
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
│       │   ├── day_of_week: int
│       │   ├── start_time: str
│       │   ├── end_time: str
│       │   ├── instructor_id: int
│       │   ├── ambiente_id: int
│       │   ├── ficha_id: int
│       │   ├── id: int
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
│
└── Exceptions
    ├── ScheduleConflictError
    │   ├── mensaje: "Instructor XX ya asignado Lunes 09:00-10:30"
    │   └── conflicting_horarios: List[Horario]
    │
    └── InvalidHorarioError
        ├── mensaje: "start_time no puede ser >= end_time"
       
```

---


```txt
┌──────────────────────────┐
│     HORARIO              │
├──────────────────────────┤
│ id (PK)            INT   │
│ day_of_week        INT   │ (0=Lunes, 1=Martes, ... 4=Viernes)
│ start_time         TIME  │ (HH:MM:SS)
│ end_time           TIME  │ (HH:MM:SS)
│ instructor_id (FK) INT   │ → INSTRUCTOR.id
│ ambiente_id (FK)   INT   │ → AMBIENTE.id
│ ficha_id (FK)      INT   │ → FICHA.id
│ created_at         TSTAMP│
│ updated_at         TSTAMP│
└──────────────────────────┘
         ↑      ↑      ↑
    N:1  │      │      │  N:1
         │      │      │
         │      │      └─────→ ┌──────────────────┐
         │      │              │ FICHA            │
         │      │              │ (Grupo Académico)│
         │      │              └──────────────────┘
         │      │
         │      └──────→ ┌──────────────────┐
         │              │ AMBIENTE         │
         │              │ (Salón/Laboratorio)  │
         │              └──────────────────┘
         │
         └──────→ ┌──────────────────┐
                  │ INSTRUCTOR       │
                  │ (Docente)        │
                  └──────────────────┘


RELACIONES:
- HORARIO N:1 INSTRUCTOR   (muchos horarios pueden tener el mismo instructor)
- HORARIO N:1 AMBIENTE     (muchos horarios pueden usar el mismo ambiente)
- HORARIO N:1 FICHA        (muchos horarios pueden asignarse a la misma ficha)

ÍNDICES CLAVE (para optimizar detección de conflictos):
  - PRIMARY KEY: id
  - COMPOSITE: (day_of_week, instructor_id)  ← CRÍTICO para búsqueda
  - COMPOSITE: (day_of_week, ambiente_id)     ← CRÍTICO para búsqueda
  - COMPOSITE: (day_of_week, ficha_id)        ← CRÍTICO para búsqueda
  - INDEX: created_at (para ordenamientos)
```

### 2. Diagrama de Clases (Componentes del Módulo)

```txt
╔════════════════════════════════════════════════════════════════╗
║                    HORARIOS MODULE (ByModule)                  ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ HorarioEntity (DataClass / SQLAlchemy Model)            │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Attributes:                                             │  ║
║  │  - id: int (primary key)                                │  ║
║  │  - day_of_week: int (0-4)                               │  ║
║  │  - start_time: time                                     │  ║
║  │  - end_time: time                                       │  ║
║  │  - instructor_id: int (FK)                              │  ║
║  │  - ambiente_id: int (FK)                                │  ║
║  │  - ficha_id: int (FK)                                   │  ║
║  │  - created_at: datetime                                 │  ║
║  │  - updated_at: datetime                                 │  ║
║  │                                                          │  ║
║  │ Methods:                                                │  ║
║  │  - validate()  # validaciones básicas de datos           │  ║
║  │  - to_dict()   # serialización                           │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                             △                                  ║
║                             │ used_by                           ║
║                             │                                   ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ IHorarioRepository (Abstract)                            │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Methods (abstract):                                     │  ║
║  │  + create(dto: HorarioDTO) → Horario                    │  ║
║  │  + read(id: int) → Horario?                             │  ║
║  │  + update(id: int, dto: HorarioDTO) → Horario           │  ║
║  │  + delete(id: int) → bool                               │  ║
║  │  + list_all() → List[Horario]                           │  ║
║  │  + find_conflicts(horario: Horario) → List[Horario]  ★  │  ║
║  │  + find_by_day(day: int) → List[Horario]                │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                             △                                  ║
║                             │ implements                        ║
║                             │                                   ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ HorarioRepository (SQLAlchemy/ORM Implementation)        │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Implementa IHorarioRepository                           │  ║
║  │                                                          │  ║
║  │ find_conflicts(horario):  ★ CRÍTICA                      │  ║
║  │   1. Obtiene día de semana de candidate                 │  ║
║  │   2. Ejecuta query con índice compuesto                 │  ║
║  │   3. Filtra resultados por solapamiento de tiempo       │  ║
║  │   4. Verifica triple restricción                        │  ║
║  │   5. Retorna lista de conflictos                        │  ║
║  │   (Ver algoritmo en sección 3)                          │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                             △                                  ║
║                             │ inject                            ║
║                             │                                   ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ IHorarioService (Abstract)                              │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Methods (abstract):                                     │  ║
║  │  + create(dto: HorarioDTO) → Horario                    │  ║
║  │  + validate_and_create(dto: HorarioDTO) → Horario?   ★  │  ║
║  │  + list_all() → List[Horario]                           │  ║
║  │  + get_by_instructor(instr_id) → List[Horario]         │  ║
║  │  + get_by_ambiente(amb_id) → List[Horario]             │  ║
║  │  + calculate_occupancy() → float                        │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                             △                                  ║
║                             │ implements                        │
║                             │                                   ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ HorarioService (Business Logic Implementation)           │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Dependencies:                                           │  ║
║  │  - repository: IHorarioRepository                       │  ║
║  │  - conflict_validator: ConflictValidator (Util) ★       │  ║
║  │                                                          │  ║
║  │ validate_and_create(dto):  ★ CRÍTICA                     │  ║
║  │  1. Valida estructura del DTO                           │  ║
║  │  2. Verifica que instructor, ambiente, ficha existan    │  ║
║  │  3. Llama repository.find_conflicts()                   │  ║
║  │  4. Si hay conflictos → lanza ApplicationError          │  ║
║  │  5. Si OK → repository.create() → retorna Entity        │  ║
║  │                                                          │  ║
║  │ calculate_occupancy():                                  │  ║
║  │  - slots_used / total_slots_in_week                     │  ║
║  │  - target: ≥ 75%                                        │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                             △                                  ║
║                             │ inject                            ║
║                             │                                   ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ HorarioController (HTTP Endpoints)                       │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Dependencies: service: IHorarioService                  │  ║
║  │                                                          │  ║
║  │ POST /horarios                                          │  ║
║  │  - Recibe: HorarioDTO (raw)                             │  ║
║  │  - Autentica: verificar JWT                             │  ║
║  │  - Autoriza: coordinador o admin                        │  ║
║  │  - Llama: service.validate_and_create(dto)              │  ║
║  │  - Retorna: 201 Created {id, horario} o 409 Conflict    │  ║
║  │                                                          │  ║
║  │ GET /horarios/{id}                                      │  ║
║  │  - Retorna: 200 OK {horario}                            │  ║
║  │                                                          │  ║
║  │ PUT /horarios/{id}                                      │  ║
║  │  - Recibe: HorarioDTO (partial update)                  │  ║
║  │  - Valida: no crear conflictos con update               │  ║
║  │  - Retorna: 200 OK {updated_horario}                    │  ║
║  │                                                          │  ║
║  │ DELETE /horarios/{id}                                   │  ║
║  │  - Verifica: no está siendo usado por otro servicio    │  ║
║  │  - Retorna: 204 No Content                              │  ║
║  │                                                          │  ║
║  │ GET /horarios?day=0&instructor_id=5                     │  ║
║  │  - Filtrado con índices compuestos                      │  ║
║  │  - Retorna: 200 OK [horarios]                           │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                             △                                  ║
║                             │ maps                              ║
║                             │                                   ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ HorarioDTO (Request/Response DTO)                        │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ request_model:                                          │  ║
║  │  - day_of_week: int (0-4) [Lun-Vie]                     │  ║
║  │  - start_time: str ("HH:MM:SS")                         │  ║
║  │  - end_time: str ("HH:MM:SS")                           │  ║
║  │  - instructor_id: int                                   │  ║
║  │  - ambiente_id: int                                     │  ║
║  │  - ficha_id: int                                        │  ║
║  │                                                          │  ║
║  │ response_model:                                         │  ║
║  │  - (todos los anteriores) +                             │  ║
║  │  - id: int                                              │  ║
║  │  - created_at: datetime (ISO8601)                       │  ║
║  │  - updated_at: datetime (ISO8601)                       │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                                                                ║
║  ┌─────────────────────────────────────────────────────────┐  ║
║  │ ConflictValidator (Utility - Algoritmo Crítico) ★★★     │  ║
║  ├─────────────────────────────────────────────────────────┤  ║
║  │ Static method:                                          │  ║
║  │   check_interval_overlap(                               │  ║
║  │     start1, end1,                                       │  ║
║  │     start2, end2                                        │  ║
║  │   ) → bool                                              │  ║
║  │                                                          │  ║
║  │ Implementación: Ver sección 3 (Algoritmo Crítico)      │  ║
║  └─────────────────────────────────────────────────────────┘  ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
```






### 4. Flujo de Datos (End-to-End)

```
┌─────────────────────────────────────────────────────────────────┐
│ HTTP POST /horarios                                             │
│ Body: {                                                         │
│   "day_of_week": 0,      // Lunes                               │
│   "start_time": "09:00:00",                                     │
│   "end_time": "10:00:00",                                       │
│   "instructor_id": 42,                                          │
│   "ambiente_id": 101,                                           │
│   "ficha_id": 5                                                 │
│ }                                                               │
└─────────────────────────────────────────────────────────────────┘
                            ↓ [Autenticación JWT]
┌─────────────────────────────────────────────────────────────────┐
│ HorarioController.create()                                       │
│  - Autentica: ¿JWT válido?                                      │
│  - Autoriza: ¿coordinador o admin?                              │
│  - Mapea: raw JSON → HorarioDTO                                 │
└─────────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│ HorarioService.validate_and_create(dto)                         │
│  1. Valida DTO: ¿campos obligatorios?
│     - day_of_week en [0, 4]
│     - start_time < end_time
│     - duracion <= 3 horas (negocio)
│                                                                 │
│  2. Valida referencias:                                         │
│     - ¿instructor_id existe?
│     - ¿ambiente_id existe?
│     - ¿ficha_id existe?
│                            ↓                                    │
│  3. Llama repository.find_conflicts(dto)                        │
└─────────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│ HorarioRepository.find_conflicts(horario)                       │
│                                                                 │
│  Query compilada con índice compuesto:                          │
│  SELECT * FROM horarios                                         │
│  WHERE day_of_week = 0                     ← índice rápido      │
│    AND (
│      (instructor_id = 42 AND NOT (...))                         │
│      OR (ambiente_id = 101 AND NOT (...))
│      OR (ficha_id = 5 AND NOT (...))
│    )
│                                                                 │
│  ¿Resultado? [Horario{..}, Horario{..}] (2 conflictos)         │
└─────────────────────────────────────────────────────────────────┘
                            ↓ [Si hay conflictos]
┌─────────────────────────────────────────────────────────────────┐
│ HTTP 409 Conflict                                               │
│ {                                                               │
│   "error": "SCHEDULE_CONFLICT",                                 │
│   "message": "Instructor 42 ya está asignado Lunes 09:30-10:30", │
│   "conflicts": [                                                │
│     {                                                           │
│       "id": 999,                                                │
│       "day_of_week": 0,                                         │
│       "start_time": "09:30:00",                                 │
│       "end_time": "10:30:00",                                   │
│       "instructor_id": 42,                                      │
│       "reason": "same_instructor"                               │
│     }                                                           │
│   ]                                                             │
│ }                                                               │
└─────────────────────────────────────────────────────────────────┘

              O [Si NO hay conflictos]
              ↓
┌─────────────────────────────────────────────────────────────────┐
│ HorarioRepository.create(horario_entity)                        │
│  - INSERT INTO horarios (...) VALUES (...)                      │
│  - Transacción ACID: COMMIT                                     │
│  - Retorna Entity con id asignado                               │
└─────────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│ HTTP 201 Created                                                │
│ Location: /horarios/12345                                       │
│ {                                                               │
│   "id": 12345,                                                  │
│   "day_of_week": 0,                                             │
│   "start_time": "09:00:00",                                     │
│   "end_time": "10:00:00",                                       │
│   "instructor_id": 42,                                          │
│   "ambiente_id": 101,                                           │
│   "ficha_id": 5,                                                │
│   "created_at": "2026-05-20T14:35:22Z",                         │
│   "updated_at": "2026-05-20T14:35:22Z"                          │
│ }                                                               │
└─────────────────────────────────────────────────────────────────┘
```
