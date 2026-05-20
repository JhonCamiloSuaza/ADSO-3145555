# DDD — Domain Driven Design (Diseño Guiado por el Dominio)

**Audiencia**: Arquitectos de software, desarrolladores senior.

**Cuándo usar**: Sistemas empresariales de alta complejidad con reglas de negocio cambiantes o críticas, donde es fundamental aislar el núcleo de negocio de la tecnología subyacente (base de datos, controladores HTTP, frameworks externos).

```txt
DDD
│
├── Domain (El Núcleo del Negocio - Puro, sin dependencias externas)
│   ├── Entities (Horario, Ambiente, Instructor, Ficha, User)
│   ├── ValueObjects (TimeInterval, EmailAddress, Capacity)
│   ├── Aggregates (ScheduleAggregate)
│   ├── RepositoryInterfaces (IHorarioRepository, IUserRepository)
│   └── DomainServices (ScheduleConflictService - Reglas de triple restricción)
│
├── Application (Casos de Uso del Sistema)
│   ├── UseCases (CreateScheduleUseCase, ValidateInstructorLoadUseCase)
│   ├── DTOs (RequestDTO, ResponseDTO)
│   └── Interfaces (IEmailNotificationService, IAuthTokenService)
│
├── Infrastructure (Detalles Tecnológicos e Implementaciones)
│   ├── Persistence (Conexión a DB, Migraciones ORM)
│   ├── Repositories (HorarioRepositoryImpl, UserRepositoryImpl)
│   ├── Security (Implementación de JWT, Encriptación Bcrypt)
│   └── ExternalServices (SendGridEmailService, LDAPAuthService)
│
└── Presentation (Capa de Entrada y Comunicación Externa)
    ├── Controllers (HorarioController, AuthController, AdminController)
    ├── Serializers (Convertidores de datos JSON/XML)
    └── Middleware (Validación de tokens, manejo global de excepciones)
```

## Ventajas y Desventajas
- **Ventajas**: Aislamiento total del negocio. Si cambias de base de datos (ej. SQLite a PostgreSQL) o de framework web, la capa `Domain` e incluso `Application` permanecen intactas. Facilita enormemente las pruebas unitarias.
- **Desventajas**: Mayor cantidad de archivos y carpetas, curva de aprendizaje empinada, puede ser un sobrediseño ("Overengineering") para aplicaciones CRUD sencillas.
