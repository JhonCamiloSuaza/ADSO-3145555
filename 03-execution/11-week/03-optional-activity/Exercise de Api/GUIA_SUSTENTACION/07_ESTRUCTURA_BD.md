# 🗄️ 07. ESTRUCTURA DE LA BASE DE DATOS (LIQUIBASE)

> 💡 **PARA ALGUIEN QUE NO SABE:** Imagina que la Base de Datos es un **Edificio de Archivos**. Liquibase es el **Arquitecto** que tiene los planos para construir nuevos cajones o meter nuevas carpetas de información.

---

## 🏗️ El Concepto: "Base de Datos como Código"
En este proyecto no entramos a la base de datos a escribir comandos SQL que se olvidan. Escribimos archivos de configuración (YAML) que quedan guardados para siempre. Esto se llama **Migración de Base de Datos**.

### 📂 1. El Archivo `db.changelog-master.yaml` (El Plano Maestro / El Índice)
*   **Responsabilidad:** Decidir el orden de construcción. Es el archivo que lee Docker al arrancar.
*   **Lenguaje Sencillo:** Es el índice de un libro. Si quieres saber qué se ha construido en el edificio, miras este archivo.
*   **Término Técnico:** **Master Changelog**.
*   **Ejemplo de Código:**
    ```yaml
    databaseChangeLog:
      - include: file: changelog/ddl/001-create-usuario.yaml
      - include: file: changelog/ddl/009-add-genero.yaml # <-- El último cambio
    ```

### 📂 2. La Carpeta `ddl` (Los Planos de Estructura)
*   **Responsabilidad:** Crear y modificar la forma de las tablas. No toca los datos, solo las columnas.
*   **Lenguaje Sencillo:** Aquí se decide si un cuarto tendrá 2 o 3 ventanas. Aquí creamos el cajón del "Género".
*   **Término Técnico:** **Data Definition Language**.
*   **Ejemplo de Código (Archivo `009-add-genero.yaml`):**
    ```yaml
    changes:
      - addColumn:
          tableName: usuario
          columns:
            - column:
                name: genero
                type: varchar(20) # Define el tamaño del texto
    ```

### 📂 3. La Carpeta `dml` (Los Muebles / Los Habitantes)
*   **Responsabilidad:** Poblar la base de datos con información real.
*   **Lenguaje Sencillo:** Es la gente que vive en el edificio. Aquí anotamos que Juan y María son los primeros en mudarse.
*   **Término Técnico:** **Data Manipulation Language**. Inserta los "Datos Semilla".
*   **Ejemplo de Código:**
    ```yaml
    changes:
      - insert:
          tableName: usuario
          columns:
            - column: {name: nombre, value: "Juan"}
    ```

### 📂 4. La Carpeta `dcl` (Las Llaves / La Seguridad)
*   **Responsabilidad:** Controlar quién puede entrar y quién no.
*   **Término Técnico:** **Data Control Language**. Maneja privilegios (GRANT, REVOKE).

---

## 🔍 ¿Cómo sabe Liquibase qué archivos ya ejecutó?
Si el profesor te pregunta: *"¿Por qué cuando reinicias Docker no se vuelven a crear las mismas tablas?"*
*   **Respuesta Ganadora:** Liquibase crea automáticamente una tabla llamada `databasechangelog` dentro de PostgreSQL. Ahí anota el `id` de cada archivo que ya leyó. Si ya lo leyó una vez, no lo vuelve a hacer. ¡Es un sistema inteligente!

---

## 🔗 Datos de Conexión Reales
*   **Motor:** PostgreSQL 16.
*   **Puerto Real:** `5437` (Entrada para que programas externos hablen con el contenedor).
*   **Persistencia:** Carpeta `postgres_data`. Es la caja fuerte física en tu disco duro donde los datos viven para siempre.
*   **URL para Postman:** [http://localhost:8080/api/v1/usuarios](http://localhost:8080/api/v1/usuarios)
