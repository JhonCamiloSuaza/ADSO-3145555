# C4 — Módulo: Security (Code)

**Audiencia**: Desarrolladores de software y arquitectos del equipo.

**Cuándo usar**: Implementación del módulo de seguridad, autenticación y autorización.

```txt
Security Module
│
├── Entity
│   ├── atributos
│   │   ├── id: int (PK)
│   │   ├── username: str
│   │   ├── password_hash: str
│   │   ├── email: str
│   │   ├── role: enum (ADMIN, COORDINATOR, INSTRUCTOR, ENVIRONMENT_ADMIN)
│   │   ├── is_active: bool
│   │   ├── created_at: datetime
│   │   └── updated_at: datetime
│   ├── constructor
│   ├── Getter (para cada atributo)
│   ├── Setter (para cada atributo)
│   ├── validate()         # valida formato de email, longitud de password
│   └── to_dict()          # serialización (excluye password_hash)
│
├── IRepository (Interfaz)
│   ├── save(user: User) → User
│   ├── update(id: int, user: User) → User
│   ├── delete(id: int) → bool
│   ├── findById(id: int) → User?
│   ├── findAll() → List[User]
│   ├── findByUsername(username: str) → User?
│   └── findByRole(role: str) → List[User]
│
├── Repository (Implementación ORM)
│   ├── Implementa: IRepository
│   ├── save(user) → INSERT INTO users
│   ├── update(id, user) → UPDATE users
│   ├── delete(id) → DELETE FROM users
│   ├── findById(id) → SELECT * FROM users WHERE id = ?
│   ├── findByUsername(username) → SELECT * FROM users WHERE username = ?
│   └── findByRole(role) → SELECT * FROM users WHERE role = ?
│
├── IService (Interfaz)
│   ├── login(username: str, password: str) → TokenDTO
│   ├── logout(token: str) → bool
│   ├── register(dto: UserDTO) → User
│   ├── getById(id: int) → User?
│   ├── getAll() → List[User]
│   ├── update(id: int, dto: UserDTO) → User
│   └── delete(id: int) → bool
│
├── Service (Lógica de Negocio)
│   ├── Implementa: IService
│   ├── Inyecta: repository, jwt_util
│   │
│   ├── login(username, password)
│   │   ├── 1. Busca usuario por username en repository
│   │   ├── 2. Verifica hash del password (bcrypt)
│   │   ├── 3. Si inválido → raise AuthenticationError(401)
│   │   ├── 4. Si OK → genera JWT con rol y expiración
│   │   └── 5. Retorna: TokenDTO {access_token, expires_in}
│   │
│   └── register(dto: UserDTO)
│       ├── 1. Valida que username/email no existan
│       ├── 2. Hashea password con bcrypt
│       ├── 3. Crea Entity y persiste en repository
│       └── 4. Retorna: User creado
│
├── Controller (HTTP Endpoints)
│   ├── Inyecta: service
│   │
│   ├── POST /auth/login
│   │   ├── Recibe: {username, password}
│   │   ├── Llama: service.login(username, password)
│   │   ├── Si error → 401 Unauthorized
│   │   └── Si OK → 200 OK {access_token, expires_in}
│   │
│   ├── POST /auth/register
│   │   ├── Recibe: UserDTO
│   │   └── Retorna: 201 Created {user}
│   │
│   └── POST /auth/logout
│       ├── Invalida token JWT
│       └── Retorna: 200 OK
│
├── DTO
│   ├── LoginRequestDTO
│   │   ├── atributos
│   │   │   ├── username: str
│   │   │   └── password: str
│   │   ├── constructor
│   │   ├── Getter
│   │   └── Setter
│   │
│   ├── TokenDTO
│   │   ├── atributos
│   │   │   ├── access_token: str
│   │   │   ├── token_type: str ("Bearer")
│   │   │   └── expires_in: int (segundos)
│   │   ├── constructor
│   │   ├── Getter
│   │   └── Setter
│   │
│   └── UserDTO
│       ├── atributos
│       │   ├── username: str
│       │   ├── password: str
│       │   ├── email: str
│       │   └── role: str
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
│   └── JWT
│       ├── generate(payload: dict, secret: str, expires: int) → str
│       ├── verify(token: str, secret: str) → dict
│       └── decode(token: str) → dict
│
└── Exceptions
    ├── AuthenticationError
    │   └── mensaje: "Credenciales inválidas"
    └── UnauthorizedError
        └── mensaje: "No tiene permisos para realizar esta acción"
```

Ver `docs/C4/structure.md` para el documento completo con diagramas de clases y flujos end-to-end.
