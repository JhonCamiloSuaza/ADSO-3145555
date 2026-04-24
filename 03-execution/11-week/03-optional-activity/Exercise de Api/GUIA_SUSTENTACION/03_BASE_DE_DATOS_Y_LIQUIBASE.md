# 🗄️ 03. BASE DE DATOS (LIQUIBASE, VOLUMENES Y DATOS)

> 💡 **RESUMEN PARA EL JURADO:** "Nuestra Base de Datos no utiliza scripts de SQL manuales, lo cual es arcaico. Utilizamos Liquibase para tener un Control de Versiones estricto del esquema, y volúmenes de Docker para asegurar que la información no sea efímera."

---

## 🏛️ 1. El Dilema de los Registros Anteriores (NOT NULL)

### ❓ PREGUNTA EXACTA: "Y si dejamos el género obligatorio, ¿qué pasa con los anteriores registros que tengo?"
*   **La Explicación Maestra al Profesor:** *"Si hubiéramos puesto `nullable: false` (obligatorio estricto) en el archivo DDL de Liquibase, habría ocurrido un 'Crash' catastrófico. PostgreSQL, al intentar crear la columna, escanearía la tabla y vería que los registros heredados (Juan, María) no tienen ese dato. Al violar la restricción de obligatoriedad, abortaría la migración y el contenedor moriría en el arranque. La convención profesional es crear la columna opcional en la BD para proteger el historial, e inyectar la obligación restrictiva a nivel de API (Java)."*

### ❓ PREGUNTA EXACTA: "Entonces a los datos anteriores, cuando ya suba los cambios, ¿les puedo poner el género o no?"
*   **La Respuesta:** *"Absolutamente. Liquibase aplica una compensación asignándoles el valor `null` por defecto para no romper la BD. Para poblarlos, simplemente usamos la interfaz web (Frontend) o el método `PUT` de la API para editar al usuario; la transacción sobreescribirá el `null` con el valor real (Ej. Masculino)."*

## 🧠 2. Datos Semilla vs Cerebro en Vivo

### ❓ PREGUNTA EXACTA: "Acá en mi código veo que tengo como 3 personas, pero allá en la web tengo como 5. ¿Por qué eso no se ve reflejado acá en el código? ¿Eso es una Base de Datos Interna o cómo es?"
*   **La Explicación Arquitectónica:** *"Existen dos dimensiones separadas: Los 'Datos Semilla' (Seed Data) y los 'Datos Transaccionales'. Los 3 usuarios que ves en el código YAML (archivo DML) son únicamente un inyector de arranque para que el entorno no nazca en blanco. Sin embargo, los usuarios 4 y 5 que creamos por la web viajan directamente a la persistencia física del motor de PostgreSQL (el Cerebro en Vivo). El sistema de software jamás sobrescribe su propio código fuente YAML en tiempo de ejecución, por estrictas razones de seguridad."*

### Los Volúmenes Físicos de Docker (`postgres_data/`)
Agregamos la carpeta `postgres_data/` al `.gitignore`. ¿La razón? Para que los datos no se evaporen. Mapeamos un **Volumen de Docker** hacia esa carpeta local de Windows. Así, la memoria RAM del contenedor de Postgres se aterriza al disco duro físico de tu computadora. Si destruimos el contenedor de Docker, los 5 usuarios sobreviven físicamente y reviven intactos en el próximo arranque.

## 💣 3. Pruebas de CI/CD: El Sabotaje del Esquema YAML

En la base de datos no compilamos, pero validamos la pureza de la sintaxis usando la GitHub Action `liquibase-validate.yml`.

### 🔥 La Prueba del Sabotaje (Para exponer en vivo)
1.  **La Acción:** Abre `db.changelog-master.yaml` y daña la sintaxis (ejemplo: cambia `author:` por `autho:` sin la 'r'). Sube los cambios con `git push`.
2.  **El Resultado:** En GitHub, la Action fallará, marcando un Semáforo Rojo (❌).
3.  **La Explicación al Profesor:** *"Acabo de subir una migración corrupta. El Pipeline leyó el archivo maestro usando el Linter estático de Liquibase, notó que el YAML estaba mal formateado y abortó el proceso de despliegue. Si estuviéramos en la industria real, esta automatización acaba de salvar la base de datos en producción de ser corrompida por el error de tipeo de un humano."*
