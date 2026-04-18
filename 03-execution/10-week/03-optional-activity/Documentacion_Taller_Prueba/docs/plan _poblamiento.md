# Plan Maestro de Poblamiento y Verificación de Datos

Este plan define la estrategia para inyectar datos de prueba garantizando la integridad referencial y permitiendo validaciones técnicas consistentes.

## 1. Estrategia de Carga (Orden de Dependencia)
Para evitar fallos de integridad (`Foreign Key Violation`), se establece el siguiente pipeline de carga:

### Fase A: Dominios Maestro (Independientes)
1.  **Geografía Base**: Continentes y Países.
2.  **Ref. Identidad**: Géneros, Tipos de Documento, Tipos de Contacto.
3.  **Ref. Seguridad**: Estados de cuenta y Catálogo de Roles.

### Fase B: Dominios Estratégicos (Dependientes de Fase A)
4.  **Geografía Detallada**: Zonas horarias, Estados, Ciudades y Distritos.
5.  **Entidades Base**: Personas (Vinculadas a Geografía e Identidad).
6.  **Estructura Aérea**: Fabricantes de aeronaves y Aerolíneas.

### Fase C: Infraestructura y Operación
7.  **Terminales y Puertas**: Aeropuertos y sus componentes internos.
8.  **Flota**: Modelos de aeronave y Aeronaves individuales.
9.  **Cuentas**: Usuarios del sistema vinculados a Personas y Roles.

### Fase D: Datos Transaccionales (Simulación)
10. **Itinerarios**: Vuelos y segmentos de vuelo.
11. **Tripulación**: Asignación de personal operativo a los vuelos.
12. **Ventas y Check-in**: Reservas, tickets y pases de abordar de prueba.

## 2. Validación y Pruebas Unitarias de Datos
Según el Item 4.8 de la guía, se han definido las siguientes validaciones automáticas:

| Tipo de Prueba | Descripción de Validación | Herramienta |
|:---|:---|:---:|
| **Integridad Referencial** | SQL comprueba que no existan huérfanos tras la carga. | Liquibase |
| **Prueba de Rollback** | Se ejecuta un rollback completo para asegurar que no queden datos residuales. | Liquibase |
| **Validación de Lógica** | Query que verifica que un avión asignado a un vuelo exista en la flota. | SQL |

## 3. Matriz de Seguimiento Técnico
*   **Scripts Documentados**: Ubicados en `02_dml/00_inserts/`.
*   **Comentarios**: Cada ChangeSet de Liquibase incluye el tag `<comments>` explicando el propósito del dato inyectado.
*   **Autoría**: Cada inserción está firmada por la HU correspondiente para trazabilidad en la tabla `databasechangelog`.
