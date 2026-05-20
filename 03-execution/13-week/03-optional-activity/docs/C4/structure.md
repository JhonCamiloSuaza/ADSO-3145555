# C4 — Code (Nivel de Implementación)

## Estructura de Documentación

```txt
docs/C4
├── structure.md           # este archivo
├── guidelines.md          # criterios: qué documentar a nivel código
├── algorithms/
│   ├── conflict-detection.md     # pseudocódigo del motor crítico
│   └── time-slot-overlap.md      # matemática de intervalos
└── modules/
    └── horarios/                 # Módulo crítico: Sistema de Horarios
        ├── README.md             # descripción del módulo
        ├── erd.md                # modelo de datos (entidades y relaciones)
        ├── class_diagram.md      # componentes (Entity, Repository, Service...)
        ├── data_flow.md          # flujos de datos y transformaciones
        ├── implementation_notes.md
        └── src/                  # Estructura REAL del código (ByModule)
            ├── entity/
            │   ├── Horario.py           # @dataclass o SQLAlchemy Model
            │   └── __init__.py
            ├── repository/
            │   ├── IHorarioRepository.py   # Interfaz abstracta
            │   ├── HorarioRepository.py    # Implementación ORM
            │   └── __init__.py
            ├── service/
            │   ├── IHorarioService.py      # Interfaz abstracta
            │   ├── HorarioService.py       # Lógica de negocio
            │   └── __init__.py
            ├── controller/
            │   ├── HorarioController.py    # Endpoints REST
            │   └── __init__.py
            ├── dto/
            │   ├── HorarioDTO.py           # Request/Response models (Pydantic)
            │   ├── HorarioMapper.py        # Mapeo Entity ↔ DTO
            │   └── __init__.py
            ├── utils/
            │   ├── ConflictValidator.py    # Algoritmo de detección (CRÍTICO)
            │   ├── TimeUtils.py            # Utilidades de horarios
            │   └── __init__.py
            ├── exceptions/
            │   ├── ScheduleConflictError.py
            │   ├── InvalidHorarioError.py
            │   └── __init__.py
            └── __init__.py
```

### Mapeo: Documentación ↔ Código Real

| Documentación | Código Real | Propósito |
|---------------|------------|----------|
| `erd.md` | `entity/Horario.py` | Atributos, tipos, relaciones FK |
| `class_diagram.md` | `repository/`, `service/`, `controller/` | Interfaces, implementaciones, dependencias |
| `data_flow.md` | Flujo completo HTTP → ORM | End-to-end de POST /horarios |
| `implementation_notes.md` | `utils/ConflictValidator.py` | Algoritmo optimizado con índices |

## Por qué C4 es Crítico

C4 documenta la **implementación de componentes críticos** a nivel código:
- Modelo de datos (entidades, relaciones, índices).
- Arquitectura de capas por módulo.
- Algoritmos complejos (validación de conflictos).
- Flujos de transformación de datos.

**Solo documentamos módulos críticos** para la integridad del sistema. En este caso: `horarios`, porque todas las funciones de negocio dependen de que la detección de conflictos sea correcta.

---

## Módulo HORARIOS (Crítico)

### 1. Entity-Relationship Diagram (ERD)

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

### 3. Algoritmo Crítico: Detección de Conflictos

#### Matemática de Solapamiento de Intervalos

```
Dos intervalos [start1, end1] y [start2, end2] se solapan SÍ Y SOLO SÍ:
  start1 < end2 AND start2 < end1

Dicho de otra forma, NO se solapan si:
  end1 <= start2  OR  start1 >= end2
                  ↓
       Por lo tanto SÍ se solapan si:
  NOT (end1 <= start2  OR  start1 >= end2)

Ejemplo 1:
  Horario A: Lunes 09:00 - 10:00
  Horario B: Lunes 09:30 - 10:30
  ¿Solapan? SÍ (ambos usan el aula en 09:30-10:00)

Ejemplo 2:
  Horario A: Lunes 09:00 - 10:00
  Horario B: Lunes 10:00 - 11:00
  ¿Solapan? NO (A termina exactamente cuando B comienza)

Ejemplo 3:
  Horario A: Lunes 09:00 - 10:00
  Horario B: Martes 09:00 - 10:00
  ¿Solapan? NO (días diferentes)
```


#### Complejidad y Performance

```
Sin optimización (búsqueda lineal):
  - Complejidad: O(n * m) donde n=horarios del día, m=conflictos
  - Con 1000 horarios/día: muy lento (inaceptable)

Con índices compuestos:
  - Complejidad: O(log n + k) donde k=conflictos encontrados
  - Con 1000 horarios/día y 10 conflictos: ~20ms ✓

Métrica de éxito:
  - Latencia p95 de create_horario: < 200ms
  - Incluye: validación + detección + insert
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
