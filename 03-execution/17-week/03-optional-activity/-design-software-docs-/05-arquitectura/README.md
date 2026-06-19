# Arquitectura

Esta carpeta explica las decisiones tecnicas y criterios de diseno del proyecto. No reemplaza requisitos ni dominio: los interpreta para definir como podria organizarse el sistema cuando pase de documentacion a implementacion.

## Documentos

| Documento | Proposito | Estado |
|-----------|-----------|--------|
| [vision-general.md](./vision-general.md) | Vista de arquitectura, principios y componentes conceptuales | Definido |
| [despliegue.md](./despliegue.md) | Vista conceptual de ambientes y publicacion futura | Definido |
| [aspectos-transversales.md](./aspectos-transversales.md) | Seguridad, auditoria, errores, observabilidad y resiliencia | Definido |
| [decisiones](./decisiones/) | Registro de decisiones de arquitectura mediante ADR | Definido |
| [validacion-escalabilidad.md](./validacion-escalabilidad.md) | Validacion de crecimiento documental por modulos y servicios | Definido |

## Como se usa

1. Revisar requisito y modulo afectado.
2. Identificar si el cambio modifica una decision tecnica.
3. Crear o actualizar ADR cuando corresponda.
4. Enlazar la decision con requisitos, datos, APIs o servicios.

## Regla

Arquitectura debe aclarar decisiones, no decorar documentos. Si una decision no cambia estructura, integracion, datos, seguridad o limites de servicio, probablemente no necesita ADR.
