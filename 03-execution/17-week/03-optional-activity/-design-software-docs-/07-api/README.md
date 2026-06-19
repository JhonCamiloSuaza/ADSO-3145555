# API

Esta carpeta define como se documentaran las APIs futuras del proyecto. No presenta contratos implementados; establece criterios para que, cuando existan endpoints, tengan relacion clara con requisitos, modulos y servicios propuestos.

## Proposito

Evitar que las APIs aparezcan desconectadas del negocio. Cada recurso debe responder a una necesidad funcional y a un modulo del dominio.

## Documentos

| Documento | Que explica | Estado |
|-----------|-------------|--------|
| [lineamientos.md](./lineamientos.md) | Convenciones para nombrar y organizar APIs | Definido |
| [autenticacion.md](./autenticacion.md) | Reglas conceptuales de autenticacion, permisos y auditoria | Definido |

## Relacion con microservicios

Los contratos borrador viven primero en `09-microservicios`, junto al servicio propuesto. Cuando un contrato sea estable y aprobado, podra registrarse aqui como referencia formal para consumidores.

## Que no va aqui

- Tokens.
- URLs privadas.
- Credenciales.
- Contratos inventados sin requisito.

## Regla

Toda API debe poder responder: que requisito atiende, que modulo representa, que servicio la expone y que datos consulta o modifica.
