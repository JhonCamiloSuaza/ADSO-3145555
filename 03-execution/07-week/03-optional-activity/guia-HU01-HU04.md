# 📘 Guía Completa: Liquibase + Git con Pull Requests
### Proyecto: Sistema de Biblioteca
### Desde crear el repositorio hasta HU-04

---

## 📁 Estructura Final del Proyecto

```
Tu_Proyecto/
├── 01_tables/
│   ├── .gitkeep
│   ├── 00-changelog.yaml
│   ├── 01-create-person.sql
│   └── 02-create-libro.sql
├── 02_views/
│   └── .gitkeep
├── 03_functions/
│   └── .gitkeep
├── 04_procedures/
│   └── .gitkeep
├── 05_triggers/
│   └── .gitkeep
├── 06_indexes/
│   └── .gitkeep
├── 07_materialized_views/
│   └── .gitkeep
├── 08_types/
│   └── .gitkeep
├── 09_inserts/
│   ├── .gitkeep
│   ├── 00-changelog.yaml
│   ├── 01-insert-person.sql
│   └── 02-insert-libro.sql
├── 10_updates/
│   └── .gitkeep
├── 11_rollbacks/
│   ├── 01_tables/
│   │   ├── .gitkeep
│   │   ├── 01-create-person-rollback.sql
│   │   └── 02-create-libro-rollback.sql
│   └── 09_inserts/
│       ├── .gitkeep
│       ├── 01-insert-person-rollback.sql
│       └── 02-insert-libro-rollback.sql
├── docker-compose.yml
├── liquibase.properties
└── postgresql-42.7.3.jar
```

---

## ⚙️ Archivos de Configuración

### `liquibase.properties`
```properties
changeLogFile=01_tables/00-changelog.yaml
url=jdbc:postgresql://localhost:5432/NOMBRE_BD
username=postgres
password= TU_PASSWORD
driver=org.postgresql.Driver
classpath=postgresql-42.7.3.jar
```

>  Cambia `NOMBRE_BD` por el nombre de tu base de datos y `TU_PASSWORD` por tu contraseña.
>  El `changeLogFile` cambia en cada HU según la carpeta que se esté trabajando.

---

### `docker-compose.yml`
```yaml
version: '3.8'
services:
  liquibase:
    image: liquibase/liquibase:latest
    container_name: bd_liquibase_2
    volumes:
      - .:/liquibase/changelog
      - ./postgresql-42.7.3.jar:/liquibase/lib/postgresql-42.7.3.jar
    command: >
      --url=jdbc:postgresql://host.docker.internal:5432/NOMBRE_BD
      --username=postgres
      --password=TU_PASSWORD
      --changeLogFile=01_tables/00-changelog.yaml
      --searchPath=/liquibase/changelog
      update
```

> ⚠️ Cambia `NOMBRE_BD` y `TU_PASSWORD` por los tuyos.
> ⚠️ El `--changeLogFile` cambia en cada HU según la carpeta que se esté trabajando.

---

## 🌿 PASO 1: Crear el Repositorio y Clonar

Primero crea el repositorio vacío en GitHub. Luego en la terminal de VS Code:

```bash
# Clonar el repositorio desde GitHub
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git

# Entrar a la carpeta del proyecto
cd TU_REPOSITORIO
```

**¿Qué hace cada comando?**
- `git clone` → descarga el repositorio de GitHub a tu computador
- `cd` → entra a la carpeta del proyecto

---

## 🌿 PASO 2: Crear las Ramas Principales

Las ramas `dev` y `qa` **ambas salen de `main`**.

```bash
# Crear rama dev desde main
git checkout -b dev
```
> `git checkout -b dev` → crea la rama `dev` y te cambia a ella al mismo tiempo.

```bash
# Subir la rama dev a GitHub
git push origin dev
```
> `git push origin dev` → sube la rama `dev` a GitHub para que sea visible.

```bash
# Volver a main para crear qa desde main
git checkout main
```
> `git checkout main` → te cambia a la rama `main`.

```bash
# Crear rama qa desde main
git checkout -b qa

# Subir la rama qa a GitHub
git push origin qa
```

**Verificar que tienes las 3 ramas:**
```bash
git branch
```
> Debe mostrar: `main`, `dev`, `qa`

✅ Al terminar tienes: `main`, `dev`, `qa`

---
---
---

# 📗 HU-01: Crear Tabla `person`

---

## 🌿 PASO 3: Crear las Ramas Hijas de HU-01

Cada historia de usuario tiene 3 ramas hijas, una por cada rama madre.

```bash
# HU-01-dev sale de dev
git checkout dev
git checkout -b HU-01-dev
git push origin HU-01-dev
```

```bash
# HU-01-qa sale de qa
git checkout qa
git checkout -b HU-01-qa
git push origin HU-01-qa
```

```bash
# HU-01-main sale de main
git checkout main
git checkout -b HU-01-main
git push origin HU-01-main
```

**Verificar ramas:**
```bash
git branch
```
> Debe mostrar: `HU-01-dev`, `HU-01-qa`, `HU-01-main`, `dev`, `qa`, `main`

---

## 📝 PASO 4: Trabajar en `HU-01-dev`

```bash
# Cambiarse a la rama HU-01-dev
git checkout HU-01-dev
```

Crea **todas las carpetas** del proyecto con un archivo `.gitkeep` dentro de cada una:
```
01_tables/   02_views/   03_functions/   04_procedures/
05_triggers/  06_indexes/  07_materialized_views/  08_types/
09_inserts/   10_updates/
11_rollbacks/01_tables/
11_rollbacks/09_inserts/
```

Y copia a la raíz del proyecto:
- `docker-compose.yml`
- `liquibase.properties`
- `postgresql-42.7.3.jar`

Luego crea los siguientes archivos con su contenido:

---

### `liquibase.properties`
```properties
changeLogFile=01_tables/00-changelog.yaml
url=jdbc:postgresql://localhost:5432/NOMBRE_BD
username=postgres
password=TU_PASSWORD
driver=org.postgresql.Driver
classpath=postgresql-42.7.3.jar
```

---

### `docker-compose.yml`
```yaml
version: '3.8'
services:
  liquibase:
    image: liquibase/liquibase:latest
    container_name: bd_liquibase_2
    volumes:
      - .:/liquibase/changelog
      - ./postgresql-42.7.3.jar:/liquibase/lib/postgresql-42.7.3.jar
    command: >
      --url=jdbc:postgresql://host.docker.internal:5432/NOMBRE_BD
      --username=postgres
      --password=TU_PASSWORD
      --changeLogFile=01_tables/00-changelog.yaml
      --searchPath=/liquibase/changelog
      update
```

---

### `01_tables/00-changelog.yaml`
```yaml
databaseChangeLog:
  - changeSet:
      id: 01_tables_person
      author: tu_correo@gmail.com
      context: dev
      labels: HU-01
      comment: creacion tabla person
      changes:
        - sqlFile:
            path: 01_tables/01-create-person.sql
            endDelimiter: \nGO
            stripComments: false
        - tagDatabase:
            tag: v1.0.1
      rollback:
        - sqlFile:
            path: 11_rollbacks/01_tables/01-create-person-rollback.sql
```

**¿Qué significa cada campo?**
- `id` → identificador único del changeset, no se puede repetir en todo el proyecto
- `author` → tu correo, identifica quién hizo el cambio
- `context` → ambiente donde se ejecuta (dev, qa, prod)
- `labels` → historia de usuario a la que pertenece
- `comment` → descripción del cambio
- `changes` → el script SQL que se va a ejecutar
- `tagDatabase` → versión del cambio para rollback
- `rollback` → el script que deshace el cambio

---

### `01_tables/01-create-person.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:01_tables_person
CREATE TABLE person (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT TRUE
);
```

**¿Qué significa cada línea?**
- `--liquibase formatted sql` → le dice a Liquibase que este archivo es suyo, es obligatorio
- `--changeset correo:id` → identifica el cambio con el autor y un id único
- `id UUID PRIMARY KEY DEFAULT gen_random_uuid()` → id único que se genera automáticamente
- `VARCHAR(100) NOT NULL` → texto de máximo 100 caracteres, obligatorio
- `UNIQUE NOT NULL` → no se puede repetir y es obligatorio
- `TIMESTAMPTZ DEFAULT NOW()` → fecha con zona horaria, se pone automáticamente
- `BOOLEAN DEFAULT TRUE` → verdadero o falso, por defecto verdadero

---

### `11_rollbacks/01_tables/01-create-person-rollback.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:01_tables_person_rollback
DROP TABLE IF EXISTS person;
```

> ⚠️ `DROP TABLE IF EXISTS` elimina la tabla si existe, deshaciendo el cambio.

---

## 🔍 PASO 5: Verificar que Liquibase Funciona

Antes de hacer commit, siempre verifica:

```bash
docker-compose up
```

**¿Qué debe mostrar?**
```
Running Changeset: 01_tables/00-changelog.yaml::01_tables_person
Liquibase: Update has been successful. Rows affected: 0
```

> ⚠️ Si muestra error, revisa los archivos antes de continuar.
> ⚠️ Asegúrate que el contenedor de PostgreSQL esté prendido primero.

---

## 💾 PASO 6: Commit y Push a `HU-01-dev`

```bash
# Agregar todos los archivos al staging
git add .
```
> `git add .` → prepara todos los archivos para el commit.

```bash
# Crear el commit con un mensaje descriptivo
git commit -m "HU-01: creacion tabla person"
```
> `git commit -m` → guarda los cambios con un mensaje descriptivo.

```bash
# Subir los cambios a GitHub
git push origin HU-01-dev
```
> `git push origin HU-01-dev` → sube los cambios a GitHub.

---

## 🔀 PASO 7: Pull Request `HU-01-dev` → `dev`

1. Ve a **GitHub** → tu repositorio
2. Verás un botón **"Compare & pull request"** para `HU-01-dev`
3. Asegúrate que diga: **base:** `dev` ← **compare:** `HU-01-dev`
4. Escribe el título: `HU-01: creacion tabla person`
5. Clic en **"Create pull request"**
6. Clic en **"Merge pull request"**
7. Clic en **"Confirm merge"**

```bash
# Traer los cambios de dev a tu máquina local
git checkout dev
git pull origin dev
```

> `git pull origin dev` → descarga los cambios del PR que hiciste en GitHub.

---

## 🔀 PASO 8: Pull Request `HU-01-qa` → `qa`

```bash
# Cambiarse a HU-01-qa
git checkout HU-01-qa
```

> Pega manualmente los mismos archivos que pusiste en `HU-01-dev`.

```bash
git add .
git commit -m "HU-01: creacion tabla person"
git push origin HU-01-qa
```

**En GitHub:**
1. **base:** `qa` ← **compare:** `HU-01-qa`
2. Título: `HU-01: creacion tabla person`
3. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout qa
git pull origin qa
```

---

## 🔀 PASO 9: Pull Request `HU-01-main` → `main`

```bash
# Cambiarse a HU-01-main
git checkout HU-01-main
```

> Pega manualmente los mismos archivos que pusiste en `HU-01-dev`.

```bash
git add .
git commit -m "HU-01: creacion tabla person"
git push origin HU-01-main
```

**En GitHub:**
1. **base:** `main` ← **compare:** `HU-01-main`
2. Título: `HU-01: creacion tabla person`
3. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout main
git pull origin main
```

> ✅ HU-01 completada en todas las ramas!

---
---
---

# 📙 HU-02: Inserts Tabla `person`

---

## ⚠️ Qué cambia en HU-02

Debes actualizar el `changeLogFile` en **dos archivos**:

**`liquibase.properties`** → cambia esta línea:
```properties
changeLogFile=09_inserts/00-changelog.yaml
```

**`docker-compose.yml`** → cambia esta línea:
```yaml
--changeLogFile=09_inserts/00-changelog.yaml
```

> ✅ Solo cambia esa línea, el resto queda igual.

---

## 🌿 PASO 10: Crear las Ramas Hijas de HU-02

```bash
git checkout dev
git checkout -b HU-02-dev
git push origin HU-02-dev

git checkout qa
git checkout -b HU-02-qa
git push origin HU-02-qa

git checkout main
git checkout -b HU-02-main
git push origin HU-02-main
```

---

## 📝 PASO 11: Trabajar en `HU-02-dev`

```bash
git checkout HU-02-dev
```

---

### `liquibase.properties` (actualizado)
```properties
changeLogFile=09_inserts/00-changelog.yaml
url=jdbc:postgresql://localhost:5432/NOMBRE_BD
username=postgres
password=TU_PASSWORD
driver=org.postgresql.Driver
classpath=postgresql-42.7.3.jar
```

---

### `docker-compose.yml` (actualizado)
```yaml
version: '3.8'
services:
  liquibase:
    image: liquibase/liquibase:latest
    container_name: bd_liquibase_2
    volumes:
      - .:/liquibase/changelog
      - ./postgresql-42.7.3.jar:/liquibase/lib/postgresql-42.7.3.jar
    command: >
      --url=jdbc:postgresql://host.docker.internal:5432/NOMBRE_BD
      --username=postgres
      --password=TU_PASSWORD
      --changeLogFile=09_inserts/00-changelog.yaml
      --searchPath=/liquibase/changelog
      update
```

---

### `09_inserts/00-changelog.yaml`
```yaml
databaseChangeLog:
  - changeSet:
      id: 09_inserts_person
      author: tu_correo@gmail.com
      context: dev
      labels: HU-02
      comment: inserts tabla person
      changes:
        - sqlFile:
            path: 09_inserts/01-insert-person.sql
            endDelimiter: \nGO
            stripComments: false
        - tagDatabase:
            tag: v1.0.2
      rollback:
        - sqlFile:
            path: 11_rollbacks/09_inserts/01-insert-person-rollback.sql
```

---

### `09_inserts/01-insert-person.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:09_inserts_person
INSERT INTO person (id, first_name, last_name, email, phone, created_at, status)
VALUES
    (gen_random_uuid(), 'Carlos', 'García', 'carlos.garcia@email.com', '3101234567', NOW(), TRUE),
    (gen_random_uuid(), 'María', 'López', 'maria.lopez@email.com', '3209876543', NOW(), TRUE),
    (gen_random_uuid(), 'Andrés', 'Martínez', 'andres.martinez@email.com', '3154567890', NOW(), TRUE);
```

**¿Qué hace este script?**
- `INSERT INTO person` → inserta registros en la tabla `person`
- `gen_random_uuid()` → genera un UUID único automáticamente
- `NOW()` → pone la fecha y hora actual

---

### `11_rollbacks/09_inserts/01-insert-person-rollback.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:09_inserts_person_rollback
DELETE FROM person WHERE email IN (
    'carlos.garcia@email.com',
    'maria.lopez@email.com',
    'andres.martinez@email.com'
);
```

> ⚠️ Este rollback elimina los registros insertados usando el email como identificador.

---

## 🔍 PASO 12: Verificar que Liquibase Funciona

```bash
docker-compose up
```

**¿Qué debe mostrar?**
```
Running Changeset: 09_inserts/00-changelog.yaml::09_inserts_person
Liquibase: Update has been successful. Rows affected: 3
```

> `Rows affected: 3` → se insertaron 3 personas correctamente ✅

---

## 💾 PASO 13: Commit y Push a `HU-02-dev`

```bash
git add .
git commit -m "HU-02: inserts tabla person"
git push origin HU-02-dev
```

---

## 🔀 PASO 14: Pull Request `HU-02-dev` → `dev`

**En GitHub:**
1. **base:** `dev` ← **compare:** `HU-02-dev`
2. Título: `HU-02: inserts tabla person`
3. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout dev
git pull origin dev
```

---

## 🔀 PASO 15: Pull Request `HU-02-qa` → `qa`

```bash
git checkout HU-02-qa
# Pegar los mismos archivos manualmente
git add .
git commit -m "HU-02: inserts tabla person"
git push origin HU-02-qa
```

**En GitHub:**
1. **base:** `qa` ← **compare:** `HU-02-qa`
2. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout qa
git pull origin qa
```

---

## 🔀 PASO 16: Pull Request `HU-02-main` → `main`

```bash
git checkout HU-02-main
# Pegar los mismos archivos manualmente
git add .
git commit -m "HU-02: inserts tabla person"
git push origin HU-02-main
```

**En GitHub:**
1. **base:** `main` ← **compare:** `HU-02-main`
2. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout main
git pull origin main
```

> ✅ HU-02 completada en todas las ramas!

---
---
---

# 📚 HU-03: Crear Tabla `libro`

---

## ⚠️ Qué cambia en HU-03

Debes actualizar el `changeLogFile` en **dos archivos**:

**`liquibase.properties`** → cambia esta línea:
```properties
changeLogFile=01_tables/00-changelog.yaml
```

**`docker-compose.yml`** → cambia esta línea:
```yaml
--changeLogFile=01_tables/00-changelog.yaml
```

> ⚠️ También se actualiza el `01_tables/00-changelog.yaml` agregando el changeset de `libro` al final. No se crea uno nuevo.

---

## 🌿 PASO 17: Crear las Ramas Hijas de HU-03

```bash
git checkout dev
git checkout -b HU-03-dev
git push origin HU-03-dev

git checkout qa
git checkout -b HU-03-qa
git push origin HU-03-qa

git checkout main
git checkout -b HU-03-main
git push origin HU-03-main
```

---

## 📝 PASO 18: Trabajar en `HU-03-dev`

```bash
git checkout HU-03-dev
```

---

### `liquibase.properties` (actualizado)
```properties
changeLogFile=01_tables/00-changelog.yaml
url=jdbc:postgresql://localhost:5432/NOMBRE_BD
username=postgres
password=TU_PASSWORD
driver=org.postgresql.Driver
classpath=postgresql-42.7.3.jar
```

---

### `docker-compose.yml` (actualizado)
```yaml
version: '3.8'
services:
  liquibase:
    image: liquibase/liquibase:latest
    container_name: bd_liquibase_2
    volumes:
      - .:/liquibase/changelog
      - ./postgresql-42.7.3.jar:/liquibase/lib/postgresql-42.7.3.jar
    command: >
      --url=jdbc:postgresql://host.docker.internal:5432/NOMBRE_BD
      --username=postgres
      --password=TU_PASSWORD
      --changeLogFile=01_tables/00-changelog.yaml
      --searchPath=/liquibase/changelog
      update
```

---

### `01_tables/00-changelog.yaml` (actualizado - se agrega changeset de libro al final)
```yaml
databaseChangeLog:
  - changeSet:
      id: 01_tables_person
      author: tu_correo@gmail.com
      context: dev
      labels: HU-01
      comment: creacion tabla person
      changes:
        - sqlFile:
            path: 01_tables/01-create-person.sql
            endDelimiter: \nGO
            stripComments: false
        - tagDatabase:
            tag: v1.0.1
      rollback:
        - sqlFile:
            path: 11_rollbacks/01_tables/01-create-person-rollback.sql

  - changeSet:
      id: 01_tables_libro
      author: tu_correo@gmail.com
      context: dev
      labels: HU-03
      comment: creacion tabla libro
      changes:
        - sqlFile:
            path: 01_tables/02-create-libro.sql
            endDelimiter: \nGO
            stripComments: false
        - tagDatabase:
            tag: v1.0.3
      rollback:
        - sqlFile:
            path: 11_rollbacks/01_tables/02-create-libro-rollback.sql
```

> ⚠️ El changeset de `person` ya existía. Solo se agrega el de `libro` debajo.
> ⚠️ Liquibase detecta que `person` ya fue ejecutado y solo ejecuta `libro`.

---

### `01_tables/02-create-libro.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:01_tables_libro
CREATE TABLE libro (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    anio_publicacion INT,
    cantidad_disponible INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    created_by UUID,
    updated_by UUID,
    deleted_by UUID,
    status BOOLEAN DEFAULT TRUE
);
```

**¿Qué significa cada campo?**
- `titulo VARCHAR(200) NOT NULL` → título del libro, obligatorio
- `autor VARCHAR(150) NOT NULL` → nombre del autor, obligatorio
- `isbn VARCHAR(20) UNIQUE NOT NULL` → código único del libro, no se puede repetir
- `anio_publicacion INT` → año de publicación, opcional
- `cantidad_disponible INT DEFAULT 0` → libros disponibles, por defecto 0
- Los 7 campos de auditoría son iguales en todas las tablas

---

### `11_rollbacks/01_tables/02-create-libro-rollback.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:01_tables_libro_rollback
DROP TABLE IF EXISTS libro;
```

---

## 🔍 PASO 19: Verificar que Liquibase Funciona

```bash
docker-compose up
```

**¿Qué debe mostrar?**
```
Running Changeset: 01_tables/00-changelog.yaml::01_tables_libro
Liquibase: Update has been successful. Rows affected: 0
```

> ⚠️ El changeset de `person` dirá `Previously run: 1` porque ya fue ejecutado antes.
> Solo el de `libro` aparece como nuevo con `Run: 1`.

---

## 💾 PASO 20: Commit y Push a `HU-03-dev`

```bash
git add .
git commit -m "HU-03: creacion tabla libro"
git push origin HU-03-dev
```

---

## 🔀 PASO 21: Pull Request `HU-03-dev` → `dev`

**En GitHub:**
1. **base:** `dev` ← **compare:** `HU-03-dev`
2. Título: `HU-03: creacion tabla libro`
3. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout dev
git pull origin dev
```

---

## 🔀 PASO 22: Pull Request `HU-03-qa` → `qa`

```bash
git checkout HU-03-qa
# Pegar los mismos archivos manualmente
git add .
git commit -m "HU-03: creacion tabla libro"
git push origin HU-03-qa
```

**En GitHub:**
1. **base:** `qa` ← **compare:** `HU-03-qa`
2. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout qa
git pull origin qa
```

---

## 🔀 PASO 23: Pull Request `HU-03-main` → `main`

```bash
git checkout HU-03-main
# Pegar los mismos archivos manualmente
git add .
git commit -m "HU-03: creacion tabla libro"
git push origin HU-03-main
```

**En GitHub:**
1. **base:** `main` ← **compare:** `HU-03-main`
2. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout main
git pull origin main
```

> ✅ HU-03 completada en todas las ramas!

---
---
---

# 📖 HU-04: Inserts Tabla `libro`

---

## ⚠️ Qué cambia en HU-04

Debes actualizar el `changeLogFile` en **dos archivos**:

**`liquibase.properties`** → cambia esta línea:
```properties
changeLogFile=09_inserts/00-changelog.yaml
```

**`docker-compose.yml`** → cambia esta línea:
```yaml
--changeLogFile=09_inserts/00-changelog.yaml
```

> ⚠️ También se actualiza el `09_inserts/00-changelog.yaml` agregando el changeset de `libro` al final.

---

## 🌿 PASO 24: Crear las Ramas Hijas de HU-04

```bash
git checkout dev
git checkout -b HU-04-dev
git push origin HU-04-dev

git checkout qa
git checkout -b HU-04-qa
git push origin HU-04-qa

git checkout main
git checkout -b HU-04-main
git push origin HU-04-main
```

---

## 📝 PASO 25: Trabajar en `HU-04-dev`

```bash
git checkout HU-04-dev
```

---

### `liquibase.properties` (actualizado)
```properties
changeLogFile=09_inserts/00-changelog.yaml
url=jdbc:postgresql://localhost:5432/NOMBRE_BD
username=postgres
password=TU_PASSWORD
driver=org.postgresql.Driver
classpath=postgresql-42.7.3.jar
```

---

### `docker-compose.yml` (actualizado)
```yaml
version: '3.8'
services:
  liquibase:
    image: liquibase/liquibase:latest
    container_name: bd_liquibase_2
    volumes:
      - .:/liquibase/changelog
      - ./postgresql-42.7.3.jar:/liquibase/lib/postgresql-42.7.3.jar
    command: >
      --url=jdbc:postgresql://host.docker.internal:5432/NOMBRE_BD
      --username=postgres
      --password=TU_PASSWORD
      --changeLogFile=09_inserts/00-changelog.yaml
      --searchPath=/liquibase/changelog
      update
```

---

### `09_inserts/00-changelog.yaml` (actualizado - se agrega changeset de libro al final)
```yaml
databaseChangeLog:
  - changeSet:
      id: 09_inserts_person
      author: tu_correo@gmail.com
      context: dev
      labels: HU-02
      comment: inserts tabla person
      changes:
        - sqlFile:
            path: 09_inserts/01-insert-person.sql
            endDelimiter: \nGO
            stripComments: false
        - tagDatabase:
            tag: v1.0.2
      rollback:
        - sqlFile:
            path: 11_rollbacks/09_inserts/01-insert-person-rollback.sql

  - changeSet:
      id: 09_inserts_libro
      author: tu_correo@gmail.com
      context: dev
      labels: HU-04
      comment: inserts tabla libro
      changes:
        - sqlFile:
            path: 09_inserts/02-insert-libro.sql
            endDelimiter: \nGO
            stripComments: false
        - tagDatabase:
            tag: v1.0.4
      rollback:
        - sqlFile:
            path: 11_rollbacks/09_inserts/02-insert-libro-rollback.sql
```

> ⚠️ El changeset de `person` ya existía. Solo se agrega el de `libro` debajo.

---

### `09_inserts/02-insert-libro.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:09_inserts_libro
INSERT INTO libro (id, titulo, autor, isbn, anio_publicacion, cantidad_disponible, created_at, status)
VALUES
    (gen_random_uuid(), 'Cien Años de Soledad', 'Gabriel García Márquez', '978-0-06-088328-7', 1967, 5, NOW(), TRUE),
    (gen_random_uuid(), 'El Aleph', 'Jorge Luis Borges', '978-84-206-8009-3', 1949, 3, NOW(), TRUE),
    (gen_random_uuid(), 'La Casa de los Espíritus', 'Isabel Allende', '978-84-264-1603-6', 1982, 4, NOW(), TRUE);
```

**¿Qué hace este script?**
- Inserta 3 libros en la tabla `libro`
- Cada libro tiene un `id` único generado automáticamente
- Los datos son de libros reales de autores latinoamericanos

---

### `11_rollbacks/09_inserts/02-insert-libro-rollback.sql`
```sql
--liquibase formatted sql

--changeset tu_correo@gmail.com:09_inserts_libro_rollback
DELETE FROM libro WHERE isbn IN (
    '978-0-06-088328-7',
    '978-84-206-8009-3',
    '978-84-264-1603-6'
);
```

> ⚠️ Este rollback elimina los libros insertados usando el `isbn` como identificador.

---

## 🔍 PASO 26: Verificar que Liquibase Funciona

```bash
docker-compose up
```

**¿Qué debe mostrar?**
```
Running Changeset: 09_inserts/00-changelog.yaml::09_inserts_libro
Liquibase: Update has been successful. Rows affected: 3
```

> ⚠️ El changeset de `person` dirá `Previously run: 1` porque ya fue ejecutado antes.
> Solo el de `libro` aparece como nuevo con `Run: 1` y `Rows affected: 3`.

---

## 💾 PASO 27: Commit y Push a `HU-04-dev`

```bash
git add .
git commit -m "HU-04: inserts tabla libro"
git push origin HU-04-dev
```

---

## 🔀 PASO 28: Pull Request `HU-04-dev` → `dev`

**En GitHub:**
1. **base:** `dev` ← **compare:** `HU-04-dev`
2. Título: `HU-04: inserts tabla libro`
3. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout dev
git pull origin dev
```

---

## 🔀 PASO 29: Pull Request `HU-04-qa` → `qa`

```bash
git checkout HU-04-qa
# Pegar los mismos archivos manualmente
git add .
git commit -m "HU-04: inserts tabla libro"
git push origin HU-04-qa
```

**En GitHub:**
1. **base:** `qa` ← **compare:** `HU-04-qa`
2. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout qa
git pull origin qa
```

---

## 🔀 PASO 30: Pull Request `HU-04-main` → `main`

```bash
git checkout HU-04-main
# Pegar los mismos archivos manualmente
git add .
git commit -m "HU-04: inserts tabla libro"
git push origin HU-04-main
```

**En GitHub:**
1. **base:** `main` ← **compare:** `HU-04-main`
2. **"Create pull request"** → **"Merge pull request"** → **"Confirm merge"**

```bash
git checkout main
git pull origin main
```

> ✅ HU-04 completada en todas las ramas!
> ✅ Proyecto hasta HU-04 completado!

---
---
---

## ⚠️ Reglas Importantes

| ✅ Hacer | ❌ No Hacer |
|---------|------------|
| Siempre trabajar en ramas hijas | Nunca hacer commits directos en `dev`, `qa`, `main` |
| Usar Pull Requests para pasar cambios | No hacer merge manual desde terminal |
| Hacer `git pull` después de cada merge | No saltarse ramas |
| Verificar con `docker-compose up` antes del commit | No hacer push sin probar |
| Prender PostgreSQL antes de correr Liquibase | No correr Liquibase sin PostgreSQL activo |
| Actualizar `changeLogFile` en cada nueva HU | No dejar el mismo changelog para todas las HU |
| Acumular changesets en el `00-changelog.yaml` | No crear un `00-changelog.yaml` nuevo por cada HU |

---

## 🔄 Flujo Completo Resumido

```
1. Crear ramas hijas desde sus madres
   git checkout dev   && git checkout -b HU-XX-dev   && git push origin HU-XX-dev
   git checkout qa    && git checkout -b HU-XX-qa    && git push origin HU-XX-qa
   git checkout main  && git checkout -b HU-XX-main  && git push origin HU-XX-main

2. Trabajar en HU-XX-dev
   git checkout HU-XX-dev
   → Pegar archivos / actualizar los que cambian
   → docker-compose up (verificar)

3. Commit y push
   git add .
   git commit -m "HU-XX: descripcion"
   git push origin HU-XX-dev

4. Pull Request en GitHub: HU-XX-dev → dev
   git checkout dev && git pull origin dev

5. Repetir pasos 2-4 para HU-XX-qa → qa
6. Repetir pasos 2-4 para HU-XX-main → main
```

---

## 📦 Resumen de Cambios por Historia de Usuario

| HU | Qué hace | Archivos nuevos | Archivos que se actualizan | `changeLogFile` |
|----|----------|-----------------|---------------------------|-----------------|
| HU-01 | Crea tabla `person` | `01_tables/00-changelog.yaml`, `01_tables/01-create-person.sql`, `11_rollbacks/01_tables/01-create-person-rollback.sql`, `docker-compose.yml`, `liquibase.properties` | — | `01_tables/00-changelog.yaml` |
| HU-02 | Inserta datos en `person` | `09_inserts/00-changelog.yaml`, `09_inserts/01-insert-person.sql`, `11_rollbacks/09_inserts/01-insert-person-rollback.sql` | `docker-compose.yml`, `liquibase.properties` | `09_inserts/00-changelog.yaml` |
| HU-03 | Crea tabla `libro` | `01_tables/02-create-libro.sql`, `11_rollbacks/01_tables/02-create-libro-rollback.sql` | `01_tables/00-changelog.yaml`, `docker-compose.yml`, `liquibase.properties` | `01_tables/00-changelog.yaml` |
| HU-04 | Inserta datos en `libro` | `09_inserts/02-insert-libro.sql`, `11_rollbacks/09_inserts/02-insert-libro-rollback.sql` | `09_inserts/00-changelog.yaml`, `docker-compose.yml`, `liquibase.properties` | `09_inserts/00-changelog.yaml` |
