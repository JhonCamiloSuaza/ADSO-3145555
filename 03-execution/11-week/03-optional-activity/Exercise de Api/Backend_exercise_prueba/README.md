# ☕ Backend_exercise_prueba — API REST Spring Boot

## Descripción

API REST desarrollada con **Spring Boot 3.2.5** y **Java 17** para el sistema de gestión de préstamos de libros. Implementa operaciones **CRUD completas** para las 3 entidades del sistema, siguiendo los principios **SOLID** y la separación de responsabilidades.

---

## 🏗️ Arquitectura (Separación de Responsabilidades)

```
┌─────────────┐    ┌─────────────┐    ┌──────────────┐    ┌────────────┐
│ Controller  │───▶│   Service   │───▶│  Repository  │───▶│ PostgreSQL │
│ (HTTP)      │    │ (Lógica)    │    │ (JPA)        │    │ (BD)       │
└─────────────┘    └─────────────┘    └──────────────┘    └────────────┘
```

### Principios SOLID Aplicados

| Principio | Aplicación |
|-----------|-----------|
| **S** - Single Responsibility | Cada capa tiene una sola responsabilidad: Controller (HTTP), Service (lógica), Repository (datos) |
| **O** - Open/Closed | Las entidades están abiertas a extensión sin modificar el código base |
| **L** - Liskov Substitution | Los repositorios extienden `JpaRepository` sin romper el contrato |
| **I** - Interface Segregation | Cada repositorio es una interfaz específica para su entidad |
| **D** - Dependency Inversion | Inyección de dependencias vía constructor en Services y Controllers |

---

## 📂 Estructura de Carpetas

```
Backend_exercise_prueba/
├── pom.xml                            # Dependencias Maven
├── Dockerfile                         # Imagen Docker multi-stage
├── src/main/
│   ├── java/com/exercise/api/
│   │   ├── ApiApplication.java        # Clase principal Spring Boot
│   │   ├── config/
│   │   │   ├── SwaggerConfig.java     # Configuración OpenAPI/Swagger
│   │   │   └── CorsConfig.java        # Configuración CORS
│   │   ├── model/                     # Entidades JPA
│   │   │   ├── Usuario.java           # Entidad primaria
│   │   │   ├── Libro.java             # Entidad primaria
│   │   │   └── Prestamo.java          # Entidad secundaria (FK)
│   │   ├── repository/                # Repositorios JPA
│   │   │   ├── UsuarioRepository.java
│   │   │   ├── LibroRepository.java
│   │   │   └── PrestamoRepository.java
│   │   ├── service/                   # Lógica de negocio
│   │   │   ├── UsuarioService.java
│   │   │   ├── LibroService.java
│   │   │   └── PrestamoService.java
│   │   ├── controller/                # Endpoints REST
│   │   │   ├── UsuarioController.java
│   │   │   ├── LibroController.java
│   │   │   └── PrestamoController.java
│   │   └── exception/                 # Manejo de errores
│   │       ├── GlobalExceptionHandler.java
│   │       └── ResourceNotFoundException.java
│   └── resources/
│       └── application.yml            # Configuración de la app
├── postman/
│   └── Exercise_API.postman_collection.json  # Pruebas Postman
├── .github/workflows/
│   └── build-test.yml                 # CI: Build & Verify
└── README.md                          # Este archivo
```

---

## 🔌 Endpoints REST

Base URL: `http://localhost:8080/api/v1`

### 👤 Usuarios (`/api/v1/usuarios`)

| Método | Endpoint | Operación | Response |
|--------|----------|-----------|----------|
| `GET` | `/usuarios` | Consultar todos | `200` - Lista |
| `GET` | `/usuarios/{id}` | Consultar por ID | `200` / `404` |
| `POST` | `/usuarios` | Crear | `201` / `400` |
| `PUT` | `/usuarios/{id}` | Modificar | `200` / `404` |
| `DELETE` | `/usuarios/{id}` | Eliminar | `204` / `404` |

### 📚 Libros (`/api/v1/libros`)

| Método | Endpoint | Operación | Response |
|--------|----------|-----------|----------|
| `GET` | `/libros` | Consultar todos | `200` - Lista |
| `GET` | `/libros/{id}` | Consultar por ID | `200` / `404` |
| `POST` | `/libros` | Crear | `201` / `400` |
| `PUT` | `/libros/{id}` | Modificar | `200` / `404` |
| `DELETE` | `/libros/{id}` | Eliminar | `204` / `404` |

### 🔄 Préstamos (`/api/v1/prestamos`)

| Método | Endpoint | Operación | Response |
|--------|----------|-----------|----------|
| `GET` | `/prestamos` | Consultar todos | `200` - Lista |
| `GET` | `/prestamos/{id}` | Consultar por ID | `200` / `404` |
| `POST` | `/prestamos` | Crear | `201` / `400` / `404` |
| `PUT` | `/prestamos/{id}` | Modificar | `200` / `404` |
| `DELETE` | `/prestamos/{id}` | Eliminar | `204` / `404` |

---

## 🚀 Cómo Ejecutar

### Prerrequisitos
- Java 17+
- Maven 3.9+
- PostgreSQL corriendo (ver `BD_exercise_prueba`)

### Ejecución Local

```bash
# Compilar
mvn clean compile

# Ejecutar
mvn spring-boot:run

# O empaquetar y ejecutar
mvn clean package -DskipTests
java -jar target/api-1.0.0.jar
```

### Con Docker

```bash
docker build -t exercise-api .
docker run -p 8080:8080 exercise-api
```

---

## 📖 Swagger UI

Una vez ejecutada la aplicación, acceder a:

- **Swagger UI**: [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
- **API Docs JSON**: [http://localhost:8080/api-docs](http://localhost:8080/api-docs)

---

## 📬 Pruebas Postman

1. Importar el archivo `postman/Exercise_API.postman_collection.json` en Postman
2. Las variables de colección se actualizan automáticamente al crear registros
3. Ejecutar las peticiones en orden: **Crear → Consultar Todos → Consultar por ID → Modificar → Eliminar**

---

## 🔄 GitHub Actions (CI/CD)

### `build-test.yml`
- **Trigger:** Push y Pull Request a cualquier rama
- **Función:** Compila el proyecto, empaqueta el JAR y verifica el Docker build
- **Si falla:** ❌ Bloquea el merge/push

---

## 🛠️ Tecnologías y Dependencias

| Tecnología | Versión | Propósito |
|-----------|---------|-----------|
| Java | 17 | Lenguaje de programación |
| Spring Boot | 3.2.5 | Framework principal |
| Spring Data JPA | 3.2.5 | Persistencia con Hibernate |
| PostgreSQL Driver | Runtime | Conexión a BD |
| SpringDoc OpenAPI | 2.5.0 | Swagger UI |
| Lombok | Latest | Reducción de boilerplate |
| Jakarta Validation | 3.x | Validaciones de datos |
| Maven | 3.9+ | Gestión de dependencias |