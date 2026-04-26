# 🐘 09. GUÍA DE CONEXIÓN A PGADMIN

> 💡 **RESUMEN:** Esta guía te permite conectar una herramienta visual (pgAdmin) a la base de datos que está corriendo dentro de Docker.

---

## 🛠️ Configuración del Servidor

Sigue estos pasos exactos dentro de pgAdmin 4:

1.  **Botón derecho en "Servers"** -> **Register** -> **Server...**
2.  **Pestaña "General":**
    *   **Name:** `Bd_exercise_api`
3.  **Pestaña "Connection":**

| Campo | Valor a ingresar |
| :--- | :--- |
| **Host name/address** | `localhost` |
| **Port** | `5437` |
| **Maintenance database** | `Bd_exercise_api` |
| **Username** | `postgres` |
| **Password** | `camilo200804` |

---

## 🔍 Preguntas Técnicas de la Sustentación

### ❓ "¿Por qué usas el puerto 5437 y no el 5432?"
**Respuesta:** *"Porque el puerto 5432 es el que usa Postgres por defecto. Para evitar conflictos con otras bases de datos instaladas en la máquina, mapeamos el puerto interno del contenedor (5432) al puerto externo de Windows (5437) en el archivo `docker-compose.yml`"*.

### ❓ "¿Por qué el host es 'localhost' y no el nombre del contenedor?"
**Respuesta:** *"Porque pgAdmin está instalado físicamente en Windows (fuera del clúster de Docker). Para entrar al contenedor, debe pasar por el túnel de red que Docker abre en la dirección local de la máquina (localhost)"*.

---

## 📂 ¿Cómo ver los datos del Género?
Una vez conectado, navega por el árbol de la izquierda:
1. `Databases`
2. `Bd_exercise_api`
3. `Schemas`
4. `public`
5. `Tables`
6. Clic derecho en **`usuario`** -> **View/Edit Data** -> **All Rows**.
