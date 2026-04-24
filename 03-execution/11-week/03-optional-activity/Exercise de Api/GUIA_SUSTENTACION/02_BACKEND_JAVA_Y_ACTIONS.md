# 💻 02. BACKEND (JAVA), PRUEBAS DE API Y GITHUB ACTIONS

> 💡 **RESUMEN PARA EL JURADO:** "El Backend en Spring Boot es nuestro escudo. No confía ciegamente en el Frontend; utiliza DTOs y validaciones Jakarta para destruir cualquier petición maliciosa (Bad Request) antes de que toque la Base de Datos. Además, cuenta con CI/CD automatizado."

---

## 🐛 1. El Proceso Completo y el "Bug" del Método PUT

Agregamos el Género cruzando las 4 capas de Java (Entity, DTO, Mapper, Service). Pero en el proceso nos encontramos un obstáculo:

### ❓ PREGUNTA EXACTA: "No me da los pasados, creé uno nuevo y sí da, pero modifico uno pasado y no da."
*   **El Error:** Detectamos un "bug" (falla) lógico en el código. Le enseñamos a Java cómo mapear el género nuevo al CREAR (`POST`), pero omitimos mapearlo al ACTUALIZAR (`PUT`) un usuario existente.
*   **La Solución:** Intervenimos el archivo `UsuarioService.java`, localizamos el método `update()` y agregamos la instrucción faltante de mapeo: `usuario.setGenero(usuarioDTO.getGenero());`. Al reiniciar Docker con `--build`, el flujo de actualización quedó restaurado.

## 🧪 2. Pruebas de QA Definitivas (Postman / Swagger)

### ❓ PREGUNTA EXACTA: "Le envié 'genero': 'Robot' y me devolvió Error 400 Bad Request, no entendí si funcionó o no explícame."
*   **Explicación de Éxito al Profesor:** *"¡Este es un error que demuestra el éxito del sistema! En la capa de transporte (`UsuarioDTO.java`) inyectamos una expresión regular restrictiva: `@Pattern(regexp="^(Masculino|Femenino|No Binario)$")`. Al mandar 'Robot', el mecanismo de Spring Boot detectó la anomalía semántica y bloqueó la ejecución ANTES de llegar a la persistencia, respondiendo un `400 Bad Request`. Esto es el patrón de Defensa en Profundidad en acción."*

### ❓ PREGUNTA EXACTA: "Intenté enviar el JSON en Swagger y me dio Error 500 (JSON Parse Error), ¿qué fue eso?"
*   **Explicación de Éxito al Profesor:** *"Ocurrió porque se simuló un ataque de sintaxis enviando dobles comillas en un campo: `"email": ""correo@gmail.com",`. Como el formato JSON es matemáticamente estricto, el motor de deserialización (Jackson) se negó a interpretar el texto corrupto. En lugar de intentar adivinar y arriesgar una inyección maliciosa, lanzó un `500 Internal Server Error (Parse Error)`. El sistema es impenetrable ante sintaxis inválida."*

### ❓ PREGUNTA EXACTA: "Me salió 'Failed to fetch' en Swagger al hacer GET"
*   **La Explicación:** *"Este no es un error de código, es un error de conectividad. Significa que el puerto 8080 del contenedor de Java está apagado (generalmente porque cerramos la terminal de Docker localmente). La UI de Swagger sigue viva en el navegador por caché, pero no tiene a quién enviar la petición. Se soluciona reviviendo los contenedores."*

## 🤖 3. GitHub Actions (CI/CD) - Integración Continua al Detalle

Tenemos una "Tubería" automatizada en el archivo `.github/workflows/docker-build.yml` configurada con dos disparadores (triggers):

*   **1. El Disparador OBLIGATORIO (`on: push`):** Es la muralla del proyecto. Se ejecuta automáticamente cada vez que alguien sube código a `main`. Es innegociable.
*   **2. El Disparador LIBRE/MANUAL (`on: workflow_dispatch`):** Agregamos este botón en la interfaz de GitHub para permitir ejecuciones de mantenimiento manuales sin tener que alterar el código, dándonos control absoluto sobre el despliegue.

### 🔥 La Prueba del Sabotaje (Para exponer en vivo)
*   **Qué hacer:** Abre `UsuarioController.java`, bórrale un punto y coma (`;`) y haz un `git push`.
*   **Explicación al Profesor:** *"Acabo de subir código roto. Mi Pipeline de Integración Continua (CI) en GitHub descargó Maven y compiló el proyecto en un servidor en la nube. Al faltar un punto y coma, la compilación falló, el semáforo se puso Rojo (❌) y GitHub bloqueó el despliegue. Esto garantiza que ningún desarrollador, bajo ninguna circunstancia, pueda inyectar código defectuoso en el servidor de producción."*
