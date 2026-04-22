# 🐳 Docker Compose - PostgreSQL + Liquibase

Este archivo define dos servicios principales:

* **PostgreSQL** → Base de datos
* **Liquibase** → Herramienta de migraciones

---

## 📦 Estructura General

```yaml
services:
  postgres:
    image: postgres:15
    container_name: postgres-liquibase
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: *****
      POSTGRES_DB: Taller_Prueba
    ports:
      - "5436:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  liquibase:
    image: liquibase/liquibase
    container_name: postgres-liquibase-taller_prueba
    depends_on:
      - postgres
    volumes:
      - ./:/liquibase/changelog
      - ./postgresql-42.7.9.jar:/liquibase/lib/postgresql.jar
    working_dir: /liquibase/changelog
    command: >
      --url=jdbc:postgresql://postgres:5432/Taller_Prueba
      --username=postgres
      --password=camilo200804
      --driver=org.postgresql.Driver
      --changeLogFile=changelog-master.yaml
      update

volumes:
  postgres_data:
```

---

## 🐘 Servicio: PostgreSQL

Configuración del contenedor de base de datos.

* **Imagen:** `postgres:15`
* **Contenedor:** `postgres-liquibase`
* **Base de datos:** `Taller_Prueba`
* **Usuario:** `postgres`
* **Puerto externo:** `5436`
* **Puerto interno:** `5432`

### 🔹 Variables de entorno

| Variable          | Valor     |
| ----------------- | --------- |
| POSTGRES_USER     | postgres  |
| POSTGRES_PASSWORD | camilo200804 |
| POSTGRES_DB       | Taller_Prueba   |

### 🔹 Volumen

* `postgres_data` → Persistencia de datos

---

## 🔄 Servicio: Liquibase

Herramienta encargada de ejecutar migraciones sobre la base de datos.

* **Imagen:** `liquibase/liquibase`
* **Contenedor:** `postgres-liquibase-taller_prueba`
* **Dependencia:** PostgreSQL

### 🔹 Volúmenes

| Ruta local                | Ruta contenedor                 |
| ------------------------- | ------------------------------- |
| `./`                      | `/liquibase/changelog`          |
| `./postgresql-42.7.9.jar` | `/liquibase/lib/postgresql.jar` |

### 🔹 Configuración de ejecución

* **URL:** `jdbc:postgresql://postgres:5432/Taller_Prueba`
* **Usuario:** `postgres`
* **Password:** `camilo200804`
* **Driver:** `org.postgresql.Driver`
* **Changelog:** `01_tables/00-changelog.yaml`

### 🔹 Comando ejecutado

```bash
liquibase update
```

---

## ⚙️ Volúmenes

```yaml
volumes:
  postgres_data:
```

Se utiliza para mantener la información de la base de datos incluso si el contenedor se elimina.

---

## 🚀 Ejecución del proyecto

Para levantar los servicios:

```bash
docker compose up -d
```

Para ver logs de Liquibase:

```bash
docker logs liquibase-container
```

---

## ⚠️ Consideraciones importantes

* Liquibase usa el nombre del servicio `postgres` como host.
* El puerto `5436` solo aplica para conexiones desde el host (tu PC).
* Asegúrate de que el archivo `00-changelog.yaml` exista en la ruta indicada.
* El driver JDBC debe estar disponible en la ruta especificada.

---

## ✅ Buenas prácticas

* Mantener consistencia entre credenciales
* Versionar los changelogs
* Organizar migraciones por carpetas (ej: `01_tables`, `02_data`, etc.)
* Evitar hardcodear contraseñas en producción