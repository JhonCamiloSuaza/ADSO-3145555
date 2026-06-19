# Checklist de preparacion de servicio

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Antes de crear una carpeta en `09-microservicios/servicios/<servicio>/`, validar:

| Pregunta | Si/No | Evidencia |
|----------|-------|-----------|
| El servicio tiene responsabilidad clara? |  |  |
| Esta relacionado con uno o mas modulos funcionales? |  |  |
| Tiene datos propios o responsabilidad conceptual sobre datos? |  |  |
| Sus dependencias estan registradas en `mapa-dependencias.md`? |  |  |
| Sus eventos candidatos estan en `catalogo-eventos.md`, si aplica? |  |  |
| Existe requisito o historia relacionada? |  |  |
| Existe ADR si cambia una decision arquitectonica importante? |  |  |
| No se estan inventando usuarios, credenciales ni repos reales? |  |  |
| El nombre es claro y usa kebab-case? |  |  |

## Resultado

- Si la mayoria de respuestas son "No", mantenerlo como modulo documentado.
- Si las respuestas son "Si" y hay decision registrada, crear carpeta desde `_plantilla/`.
