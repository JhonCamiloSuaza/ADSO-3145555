# Architecture Decision Record (ADR-005): Elección del Motor de Base de Datos (PostgreSQL)

ID: ADR-005
Autor: Jhon Camilo Suaza Sanchez
**Fecha:** Abril 2026  
**Estatus:** Aceptado e Implementado  
**Contexto:**
El proyecto de la Aerolínea consiste en un sistema de alta criticidad: maneja facturación, asientos con restricciones lógicas complejas de overbooking, transacciones de lealtad (millas) y flujos que exigen que **bajo ninguna circunstancia se pueda perder o corromper un dato** (por ejemplo, cobrar un ticket pero no asignarlo por un fallo de conexión). 
Se requería evaluar qué motor de persistencia utilizar (NoSQL vs. SQL relacional, y dentro de los relacionales, MySQL vs PostgreSQL).

---

## La Decisión
Establecer **PostgreSQL** (específicamente la versión Alpine 15/16 en Docker) como el Sistema de Gestión de Bases de Datos Relacional (RDBMS) central para el proyecto.

**Solución Implementada:** 
Toda la arquitectura del esquema se ajustó para aprovechar funciones exclusivas de PostgreSQL que otros motores no soportan o lo hacen deficientemente:
1. Funciones nativas robustas (`EXTENSIONS pgcrypto`) para manejo de UUIDs como el `gen_random_uuid()`.
2. Integración de tipos de datos híbridos como **`JSONB`** para construir la tabla de "Caja Negra" o log de auditoría inalterable.
3. Lenguaje procedimental subyacente poderoso (`PL/pgSQL`) para crear las reglas de negocio, como la intercepción de compras caducadas o de abordajes erróneos, a un nivel ultra veloz justo antes de la transacción (`BEFORE UPDATE`).

---

## Justificación
1. **Transaccionalidad y ACID Absoluto:** Postgre prioriza la fiabilidad por encima de todo. Permite blindar las tablas de ventas mediante rigurosos `CHECK CONSTRAINTS` nativos para obligar a que por ejemplo una tarifa mantenga lógica espacial y de fechas (`refund_penalty_amount >= 0`, o `valid_to >= valid_from`).
2. **Capacidad Híbrida (JSON):** Mientras un motor NoSQL (como MongoDB) no permite relaciones robustas de llaves foráneas, MySQL carece de una gestión JSON óptima. PostgreSQL permite lo mejor de los dos mundos: un esquema de Relaciones Foráneas estricto (para vuelos y asientos) pero con columnas NoSQL robustas (JSONB) para archivar los `OLD_DATA` en nuestro `audit_log`.
