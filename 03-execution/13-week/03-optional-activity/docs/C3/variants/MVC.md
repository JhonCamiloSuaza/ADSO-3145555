# MVC — Estructura Model-View-Controller

**Audiencia**: Desarrolladores frontend/backend y diseñadores de interfaces.

**Cuándo usar**: Aplicaciones web tradicionales donde el servidor renderiza las vistas directamente (ej. Django, Laravel, Spring Boot con Thymeleaf), o arquitecturas monolíticas simples con acoplamiento directo entre la UI y los datos.

```txt
MVC
│
├── Model (Representación de Datos y Reglas de Negocio)
│   ├── Horario (Atributos, validaciones y mapeos)
│   ├── Instructor (Información del docente)
│   ├── Ambiente (Información física de espacios)
│   ├── Ficha (Grupos de estudiantes)
│   └── User (Credenciales e información de sesión)
│
├── View (Interfaces de Usuario y Visualización)
│   ├── Dashboard (Panel de control interactivo)
│   ├── SchedulerUI (Calendario gráfico de horarios)
│   ├── LoginView (Formularios de inicio de sesión)
│   └── AdminPanel (Gestión de ambientes e instructores)
│
└── Controller (Intermediario y Flujo de Control)
    ├── AuthController (Procesa login, logout y registro)
    ├── HorarioController (Coordina la asignación y validación de horarios)
    ├── InventoryController (Gestiona las peticiones de ambientes/instructores)
    └── NavigationController (Maneja las rutas y redirecciones de vistas)
```

## Ventajas y Desventajas
- **Ventajas**: Excelente separación entre la lógica de presentación y el modelo de datos. Muy extendido y con soporte nativo en casi cualquier framework web tradicional.
- **Desventajas**: Los controladores pueden volverse masivos ("Fat Controllers") si se mezcla la lógica de negocio compleja con la lógica de flujo HTTP. No escala de forma óptima para sistemas con APIs puras desacopladas del cliente.
