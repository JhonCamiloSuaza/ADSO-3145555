# 🌐 01. EL SISTEMA ORQUESTADO (DOCKER Y FLUJO GENERAL)

> 💡 **RESUMEN PARA EL JURADO:** "Este no es un proyecto tradicional de una sola carpeta. Es una arquitectura distribuida (Microservicios-like) donde el Frontend, Backend y la Base de Datos viven en repositorios independientes pero se comunican gracias a la red interna de Docker Compose."

---

## 🏗️ 1. Arquitectura de Microservicios vs Monolito
Decidimos separar el proyecto en 3 carpetas independientes. 
**¿Por qué?** Porque si todo estuviera en un "Monolito" (una sola carpeta), un error fatal en el Frontend tumbaría también el servidor y la base de datos. Al estar aislados, aumentamos la **resiliencia** del sistema. Si una pieza se cae, el resto sigue protegido.

## 🐳 2. Docker Compose: El Director de Orquesta
El archivo `docker-compose.yml` une los 3 repositorios. Crea una **red interna virtual (`exercise_network`)** para que el Backend pueda hablar con Postgres sin exponer la base de datos entera al internet público, previniendo ataques externos.

### ❓ PREGUNTA EXACTA: "¿Cuál le doy? v View in Docker Desktop, o View Config..."
*   **La Solución:** ¡A ninguno! Ese es un menú interactivo automático que muestran las nuevas versiones de Docker. Solo significa que el servidor está corriendo y ha capturado la consola. La regla de oro es **minimizar la terminal y NUNCA presionar `Ctrl+C`**, porque eso detiene el flujo eléctrico del servidor y apaga la API.

**Comandos vitales que debes saber:**
*   🚀 `docker-compose up --build`: Reconstruye todo el código fuente desde cero y prende los servidores.
*   🛑 `docker-compose down`: Apaga limpiamente los contenedores y destruye la red temporal.
*   🔍 `docker ps`: Muestra los contenedores activos en la máquina virtual.

## 🔄 3. El Flujo End-to-End (Prueba Maestra E2E)
Si te piden probar que el sistema entero sirve, haz lo siguiente en vivo:

1.  Ve al `index.html` (Frontend) en tu navegador.
2.  Crea un usuario con género "Masculino" (Explica: *El Frontend captura los datos del DOM y usa la librería Axios para mandarlos por protocolo HTTP*).
3.  Ve a Swagger (`http://localhost:8080/swagger-ui/index.html`) y ejecuta un `GET /usuarios`. 
4.  **Explicación Definitiva al Profesor:** *"Acabamos de ver el ciclo End-to-End completo. El cliente (Vanilla JS y HTML) envió un JSON, Axios tomó la petición y la disparó al contenedor de Spring Boot. Spring Boot interceptó el mensaje, aplicó las validaciones del DTO, y a través del ORM Hibernate escribió directamente en el volumen físico de PostgreSQL. Swagger nos confirma como un espejo que la persistencia fue 100% exitosa en la base de datos."*

### ❓ PREGUNTA EXACTA: "¿Lo que hicimos fueron solo pruebas, cierto?"
*   **La Respuesta para el Profesor:** *"No. Hicimos dos cosas propias de un nivel Arquitecto:*
    1.  *Desarrollo Real:* Escribimos código permanente en los 3 repositorios para agregar una característica real (el campo Género).
    2.  *Pruebas de Caja Negra (QA):* Usamos Swagger y la Web para someter nuestro propio código a estrés, comprobando que rechaza datos basura y procesa los válidos. Ejecutamos el ciclo de vida del software completo: Programación + Aseguramiento de Calidad."*
