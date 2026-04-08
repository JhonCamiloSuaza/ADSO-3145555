# Architecture Decision Record (ADR-001): Normalización del Modelo a 3FN y Eliminación de Constantes Codificadas (Hardcoding)

**Autor:** Jhon Camilo Suaza Sanchez (jhoncamilosuaza_00165)  
**Fecha:** Abril 2026  
**Estatus:** Aceptado e Implementado  
**Contexto:**
Durante la auditoría del esquema inicial de base de datos aeronáutica (SQL V1), se idenficó una persistente violación a la Tercera Forma Normal (3FN), así como la utilización de restricciones de revisión excluyentes (`CHECK CONSTRAINTS`) para el manejo de los dominios semánticos (géneros, tipos de pasajeros, estados de vuelo). Esta práctica acoplaba fuertemente las reglas de negocio al código fuente de la tabla, limitando severamente la extensibilidad horizontal del sistema.

Ejemplos críticos encontrados:
* `gender_code IN ('F', 'M', 'X')`
* `passenger_type IN ('ADULT', 'CHILD', 'INFANT')`
* `status_code IN ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')`

Añadir, modificar o depreciar un estado exigía hacer bloqueos exclusivos a nivel de tabla (`ALTER TABLE`), arriesgando la disponibilidad en entornos de producción transaccionales 24/7.

Adicionalmente, se encontró que las tablas transaccionales puente, como `seat_assignment`, sufrían de redundancia estructural al incluir llaves compuestas innecesarias transitivas (`flight_segment_id`), abriendo la puerta a posibles anomalías de inserción de datos cruzados.

---

## DECISIÓN 1: Migración de Restricciones CHECK a Catálogos Independientes
* **La Decisión:** Trasladar cualquier conjunto de valores enumerados codificados numéricamente o como cadenas dentro de las sentencias SQL hacia un esquema de llaves foráneas y entidades paramétricas dinámicas.
* **Solución Implementada:** 
  Las validaciones estáticas se convirtieron en tablas independientes administrables y normalizadas:
  1. `gender (gender_id, gender_code, gender_name)`
  2. `passenger_type (type_code, type_name)`
  3. `payment_transaction_type`, `maintenance_status`, `validation_result`, `baggage_status`, etc.
* **Consecuencia:** Escalabilidad dinámica superior. Al delegar estas validaciones a llaves foráneas (`FOREIGN KEY`), un panel administrativo backend puede crear nuevos tipos (Ej. un nuevo estado de equipaje) usando simples inyecciones transaccionales (DML `INSERT`), sin jamás recurrir a sentencias administradoras sobre la arquitectura de la base de datos (DDL).

---

## DECISIÓN 2: Destrucción de Dependencias Transitivas (Cumplimiento de la Tercera Forma Normal 3FN)
* **La Decisión:** Eliminar atributos que dependan de otra propiedad que no fuera estrictamente la llave principal dentro de tablas transaccionales.
* **Solución Implementada:** 
  El caso de uso más representativo recayó sobre la tabla `seat_assignment`. Originalmente se exigía guardar explícitamente tanto la llave `flight_segment_id` como `ticket_segment_id`, violando la regla de integridad de dependencia ya que la relación original transitiva podía deducirse a través de sub-uniones SQL (JOINs) `ticket_segment → flight_segment`. Se eliminó la obligación estricta de tener ambas en el dominio local aislando la clave primaria necesaria.
* **Consecuencia:** 
  Se mitiga radicalmente el riesgo de errores en la inserción (Ej. que la API grabe accidentalmente un ticket_segment de un vuelo distinto al que ampara el asiento). 

---

## DECISIÓN 3: Optimización Estructural de Lectura mediante Índices (Indexing)
* **La Decisión:** Preparar la base de datos para la ingesta de altos volúmenes de consultas backend mediante caminos rápidos en memoria.
* **Solución Implementada:**
  Se crearon más de **45 índices exclusivos B-tree** sobre llaves secundarias en toda la base de datos, entre ellas:
  * `idx_person_gender_id`
  * `idx_fare_route` abarcando `(origin_airport_id, destination_airport_id)`
* **Consecuencia:** A pesar del riesgo que implica usar una estructura relacional tan unida por catálogos ajenos dictaminando que las sentencias `SELECT` van a requerir masivos `JOIN`, los índices creados sobre las dependencias anulan este posible cuello de botella y entregan lecturas a niveles competentes para operaciones empresariales.

---

### Impacto y Conclusiones Finales

El proceso de purificación mediante las técnicas descritas modernizó el Esquema V1 posicionándolo sin contratiempos arquitectónicos en un pilar estandarizado **100% normalizado a 3FN**. 

* **Positivo:** Eliminación de redundancia transaccional. Elevada tasa de mantenibilidad a largo plazo sin reconstrucciones costosas ante cambios mínimos de catálogo.
* **Riesgos Controlados:** Cierto nivel de verbosidad incrementada en las sentencias de desarrollo del Backend debido al número de entidades que participarán forzosamente en peticiones complejas (JOIN).

La reestructuración representó una mejoría fundacional crítica.
