# Estrategia de migracion de datos

Este documento define criterios para cambios futuros de datos. No describe scripts reales porque el proyecto aun esta en fase documental.

## Principios

- Todo cambio de datos debe tener motivo de negocio.
- No se eliminan datos conceptuales sin registrar impacto.
- Los cambios deben revisar trazabilidad con requisitos y modulos.
- Las migraciones reales se documentaran cuando exista base de datos definida.

## Tipos de cambio

| Tipo | Ejemplo | Revision necesaria |
|------|---------|-------------------|
| Nuevo dato | Agregar disponibilidad de ambiente | Validar modulo responsable |
| Cambio de significado | Cambiar definicion de ficha | Actualizar glosario y requisitos |
| Nuevo catalogo | Crear estado de incidencia | Revisar parametrizacion |
| Relacion nueva | Vincular evento con horario | Revisar dominio y APIs |

## Flujo recomendado

1. Registrar necesidad en requisitos o pregunta abierta.
2. Identificar modulo responsable.
3. Actualizar diccionario de datos.
4. Actualizar matriz de trazabilidad si aplica.
5. Crear decision ADR si afecta arquitectura.
