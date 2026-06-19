# Operacion conceptual

Esta carpeta describe como deberia observarse y cuidarse el sistema cuando exista. No define infraestructura real; define criterios para que la operacion futura no quede desconectada de auditoria, seguimiento y calidad.

## Proposito

Preparar al equipo para pensar en incidencias, observabilidad y continuidad desde la documentacion. Aunque no haya software implementado, ya se pueden definir que eventos, datos y procesos necesitaran cuidado operativo.

## Documentos

| Documento | Que explica | Estado |
|-----------|-------------|--------|
| [observabilidad.md](./observabilidad.md) | Que se deberia medir y observar por modulo | Definido |
| [gestion-incidentes.md](./gestion-incidentes.md) | Como registrar problemas funcionales o documentales | Definido |
| [respaldo-recuperacion.md](./respaldo-recuperacion.md) | Criterios conceptuales de continuidad | Definido |

## Que no va aqui

- Llaves o credenciales.
- Configuracion real de servidores.
- Procedimientos de produccion no aprobados.

## Regla

Operacion conceptual debe explicar como cuidar el sistema, no inventar infraestructura.
