# C4 — Módulo: Observation (Code)

**Audiencia**: Desarrolladores de software y arquitectos del equipo.

**Cuándo usar**: Implementación del módulo de novedades, observaciones y seguimiento de ambientes y horarios.

```txt
Observation Module
│
├── Entity
│   ├── atributos
│   │   ├── id: int (PK)
│   │   ├── description: str
│   │   ├── type: enum (INSTRUCTOR_ABSENCE, ENVIRONMENT_DAMAGE, SCHEDULE_CHANGE, OTHER)
│   │   ├── date: datetime
│   │   ├── created_by: int (FK to User)
│   │   ├── related_horario_id: int (FK to Horario, opcional)
│   │   ├── is_resolved: bool
│   │   ├── created_at: datetime
│   │   └── updated_at: datetime
│   ├── constructor
│   ├── Getter (para cada atributo)
│   ├── Setter (para cada atributo)
│   ├── validate()     # valida longitud mínima de descripción y tipo de novedad
│   └── to_dict()      # serialización
│
├── IRepository (Interfaz)
│   ├── save(observation: Observation) → Observation
│   ├── update(id: int, observation: Observation) → Observation
│   ├── delete(id: int) → bool
│   ├── findById(id: int) → Observation?
│   ├── findAll() → List[Observation]
│   ├── findByCreator(user_id: int) → List[Observation]
│   ├── findUnresolved() → List[Observation]
│   └── findByRelatedHorario(horario_id: int) → List[Observation]
│
├── Repository (Implementación ORM)
│   ├── Implementa: IRepository
│   ├── save(observation) → INSERT INTO observations
│   ├── update(id, observation) → UPDATE observations
│   ├── delete(id) → DELETE FROM observations
│   ├── findById(id) → SELECT * FROM observations WHERE id = ?
│   ├── findByCreator(user_id) → SELECT * WHERE created_by = ?
│   ├── findUnresolved() → SELECT * WHERE is_resolved = false
│   └── findByRelatedHorario(horario_id) → SELECT * WHERE related_horario_id = ?
│
├── IService (Interfaz)
│   ├── create(dto: ObservationRequestDTO, user_id: int) → Observation
│   ├── resolve(id: int, resolver_id: int) → Observation  # CRÍTICA
│   ├── update(id: int, dto: ObservationRequestDTO) → Observation
│   ├── delete(id: int) → bool
│   ├── getById(id: int) → Observation?
│   ├── getAll() → List[Observation]
│   ├── getUnresolved() → List[Observation]
│   └── getByHorario(horario_id: int) → List[Observation]
│
├── Service (Lógica de Negocio)
│   ├── Implementa: IService
│   ├── Inyecta: repository, user_repository, email_notification_service
│   │
│   ├── create(dto: ObservationRequestDTO, user_id: int)
│   │   ├── 1. Valida estructura de la observación (descripción no vacía)
│   │   ├── 2. Verifica que el usuario creador exista
│   │   ├── 3. Si hay un horario asociado, valida su existencia
│   │   ├── 4. Crea Entity con is_resolved = false y persiste en repository
│   │   ├── 5. Si el tipo es ENVIRONMENT_DAMAGE o INSTRUCTOR_ABSENCE → notificar async a coordinadores
│   │   └── 6. Retorna: Entity con id asignado
│   │
│   └── resolve(id: int, resolver_id: int)
│       ├── 1. Obtiene la observación por id en repository
│       ├── 2. Verifica si ya estaba resuelta
│       ├── 3. Verifica que el resolver_id pertenezca a un coordinador o admin
│       ├── 4. Cambia is_resolved = true
│       ├── 5. Actualiza y guarda en repository
│       └── 6. Retorna: Entity actualizada
│
├── Controller (HTTP Endpoints)
│   ├── Inyecta: service
│   │
│   ├── POST /observations
│   │   ├── Recibe: ObservationRequestDTO (JSON)
│   │   ├── Auth: Requiere JWT (Cualquier rol activo)
│   │   ├── Llama: service.create(dto, user_id_from_jwt)
│   │   └── Retorna: 201 Created {observation}
│   │
│   ├── GET /observations
│   │   ├── Auth: Requiere JWT
│   │   ├── Parámetros opcionales: unresolved=true, related_horario_id=5
│   │   └── Retorna: 200 OK [observations]
│   │
│   ├── GET /observations/{id}
│   │   └── Retorna: 200 OK {observation}
│   │
│   ├── PUT /observations/{id}/resolve
│   │   ├── Auth: Requiere JWT (Coordinador o Administrador)
│   │   ├── Llama: service.resolve(id, user_id_from_jwt)
│   │   └── Retorna: 200 OK {observation_resuelta}
│   │
│   └── DELETE /observations/{id}
│       ├── Auth: Requiere JWT (Solo creador o administrador)
│       └── Retorna: 204 No Content
│
├── DTO
│   ├── ObservationRequestDTO
│   │   ├── atributos
│   │   │   ├── description: str
│   │   │   ├── type: str ("INSTRUCTOR_ABSENCE", etc.)
│   │   │   ├── date: str (ISO8601)
│   │   │   └── related_horario_id: int (opcional)
│   │   ├── constructor
│   │   ├── Getter
│   │   └── Setter
│   │
│   └── ObservationResponseDTO
│       ├── atributos
│       │   ├── id: int
│       │   ├── description: str
│       │   ├── type: str
│       │   ├── date: str
│       │   ├── created_by: int
│       │   ├── related_horario_id: int
│       │   ├── is_resolved: bool
│       │   ├── created_at: str
│       │   └── updated_at: str
│       ├── constructor
│       ├── Getter
│       └── Setter
│
├── IDTO
│   ├── entityToDTO()
│   ├── dtoToEntity()
│   └── mapper()
│
└── Exceptions
    ├── ObservationNotFoundError
    │   └── mensaje: "Observación con ID XX no encontrada"
    └── InvalidObservationTypeError
        └── mensaje: "Tipo de novedad no es válido"
```

Ver `docs/C4/structure.md` para el documento completo con diagramas de clases y flujos end-to-end.
