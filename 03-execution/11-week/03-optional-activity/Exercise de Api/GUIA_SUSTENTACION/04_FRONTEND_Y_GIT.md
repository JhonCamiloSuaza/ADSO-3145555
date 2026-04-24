# 🌐 04. FRONTEND (INTERFAZ), JS Y SOLUCIÓN DE ERRORES GIT

> 💡 **RESUMEN PARA EL JURADO:** "El Frontend actúa como nuestro punto de interacción Vanilla. Implementa protección de interfaz limitando opciones con `<select>` y utiliza la librería Axios para construir un puente de comunicación asíncrono con el Backend."

---

## 🎨 1. El Proceso Completo: Integrando el "Género" en la Web

### ❓ PREGUNTA EXACTA: "¿En el frontend me va a dejar colocar el género sí o cómo es ahí?"
*   **La Respuesta de Ingeniería:** *"El Frontend no reconoce los cambios del Backend por arte de magia. Tuvimos que intervenir el código en tres fases quirúrgicas:"*
    1.  **Manipulación del DOM (`index.html`):** Para anular el riesgo de que el usuario escriba errores de ortografía en el género, eliminamos el input de texto libre y lo reemplazamos por un `<select id="usuario-genero">` con opciones estrictamente cerradas.
    2.  **Captura Asíncrona (`usuarios.js - save()`):** Modificamos el evento del botón Guardar. Instruimos a Axios para que atrapara el valor exacto del HTML (`document.getElementById`) y lo serializara dentro del Payload JSON que viaja por HTTP hacia Spring Boot.
    3.  **Renderizado Condicional (`usuarios.js - renderTable()`):** Para manejar la Deuda Técnica de los usuarios antiguos que poseían el campo `null`, aplicamos el operador de coalescencia lógica (`||`): `${u.genero || 'No Especificado'}`. Si la API devuelve un vacío, la interfaz lo intercepta y pinta elegantemente 'No Especificado'.

---

## ⚔️ 2. Resolución Técnica de Errores en Git

El Frontend nos presentó un reto particular de repositorios. A diferencia del Backend que descargamos desde un clon, esta carpeta nació "huérfana" en tu computadora.

### ❓ PREGUNTA EXACTA: "Ahora necesito entrar a cada carpeta para subir cambios"
*   **La Explicación de Arquitectura al Profesor:** *"Trabajamos bajo un modelo Desacoplado. Esto significa que cada pieza (Backend, Frontend, BD) requiere su propio repositorio aislado y su propio despliegue. Si subiéramos todo en un 'Monolito' enorme, un fallo en el pipeline del Frontend congelaría injustamente el servidor de Java. Al aislarlos, aumentamos la tolerancia a fallos de todo el clúster."*

### EL ERROR 1: La Carpeta Huérfana
*   *El Comando:* `git add .`
*   *El Error Exacto de Consola:* `fatal: not a git repository (or any of the parent directories): .git`
*   *La Resolución Técnica:* "La consola arrojó este fatal porque la carpeta del Frontend era un simple directorio de Windows. Le faltaba la carpeta oculta `.git` que le otorga las capacidades de Versionamiento. Lo curamos ejecutando `git init` para darle poderes de rastreo local, y luego `git remote add origin [URL]` para tender el puente de conexión directo al servidor de GitHub."

### EL ERROR 2: El Conflicto de Historiales (La Batalla Remota)
*   *El Comando:* `git push -u origin main`
*   *El Error Exacto de Consola:* `! [rejected] main -> main (fetch first)`
*   *La Resolución Técnica:* "Ocurrió un conflicto de fusión. Al crear el repositorio vacío en GitHub.com, la plataforma auto-generó un archivo `README.md`. Al ejecutar el push, mi máquina detectó que la nube tenía archivos ajenos, y por protocolo de seguridad, bloqueó la subida para no destruir trabajo remoto."
*   **El Comando de Victoria (Force Push):** `git push -f origin main`. 
    *Explicación al profesor:* *"Dado que mi entorno local de Windows era la única fuente oficial de verdad, apliqué un comando de Fuerza Bruta (`-f`). Esto obligó al servidor remoto de GitHub a purgar su historial falso y aceptar incondicionalmente mi carpeta local como la versión definitiva de producción."*
