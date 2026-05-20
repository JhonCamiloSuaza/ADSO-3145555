# Microservices — Transición y Estructura Distribuida

**Audiencia**: Arquitectos de software, DevOps, equipos de infraestructura cloud.

**Cuándo usar**: Sistemas altamente escalables con alta concurrencia o equipos de desarrollo grandes y autónomos. Muestra cómo dividir el sistema monolítico en microservicios independientes que se comunican a través de la red (HTTP/REST, gRPC, colas de mensajería).

```txt
Microservices
│
├── Gateway (Punto de entrada único / API Gateway)
│   ├── Routing (Redirección a servicios internos)
│   └── GlobalAuth (Validación previa de tokens JWT)
│
├── Auth Service (Microservicio de Autenticación)
│   ├── Port: 8081
│   ├── Database: AuthDB (PostgreSQL)
│   └── Responsabilidad: Login, LDAP, firma de tokens JWT
│
├── Instructor Service (Microservicio de Gestión de Profesores)
│   ├── Port: 8082
│   ├── Database: InstructorDB (PostgreSQL)
│   └── Responsabilidad: Catálogo y carga horaria semanal de docentes
│
├── Environment Service (Microservicio de Gestión de Espacios)
│   ├── Port: 8083
│   ├── Database: EnvironmentDB (PostgreSQL)
│   └── Responsabilidad: Capacidad y disponibilidad de salones / laboratorios
│
├── Schedule Service (Microservicio de Gestión y Validación de Horarios)
│   ├── Port: 8084
│   ├── Database: ScheduleDB (PostgreSQL)
│   ├── Communication: Event-Driven (RabbitMQ / Redis)
│   └── Responsabilidad: Creación de horarios y validación de triple restricción
│
└── Notification Service (Microservicio Asíncrono de Avisos)
    ├── Communication: Event-Driven (Consume cola "schedule.changed")
    └── Responsabilidad: Envío de correos (SMTP / SendGrid)
```

## Ventajas y Desventajas
- **Ventajas**: Escalabilidad independiente para cada servicio (ej. puedes escalar solo el servicio de horarios si hay mucha consulta sin gastar recursos en los otros). Tolerancia a fallos aislada y libertad tecnológica.
- **Desventajas**: Altísima complejidad operativa (monitoreo, tracing distribuido, orquestación con Docker/Kubernetes). Latencia de red debido a la comunicación interservicios y complejidad en el manejo de consistencia eventual de datos.
