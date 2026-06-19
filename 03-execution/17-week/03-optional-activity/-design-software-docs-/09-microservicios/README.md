# Microservicios propuestos

Esta carpeta traduce los 10 modulos funcionales del dominio a una vista tecnica de servicios propuestos. Su objetivo no es inventar implementaciones, sino dejar claros los limites, dependencias, datos y eventos que el equipo debera considerar cuando el proyecto avance.

## Idea principal

El proyecto puede iniciar como monolito modular. Eso significa que primero se organizan responsabilidades y reglas de negocio; despues, si el proyecto lo justifica, algunos limites podran convertirse en servicios separados. Esta carpeta prepara esa evolucion sin obligarla.

## Documentos

| Documento | Proposito | Cuando usarlo |
|-----------|-----------|---------------|
| [catalogo-servicios.md](./catalogo-servicios.md) | Lista servicios propuestos y su relacion con modulos | Para explicar la vista tecnica inicial |
| [reglas-limites-servicio.md](./reglas-limites-servicio.md) | Define criterios para separar o mantener responsabilidades juntas | Antes de proponer un nuevo servicio |
| [mapa-dependencias.md](./mapa-dependencias.md) | Muestra dependencias entre servicios y modulos | Para revisar impacto de cambios |
| [matriz-propiedad-datos.md](./matriz-propiedad-datos.md) | Asigna responsabilidad conceptual sobre datos | Para evitar datos duplicados |
| [catalogo-eventos.md](./catalogo-eventos.md) | Registra eventos de dominio candidatos | Para entender comunicacion futura |
| [patrones-comunicacion.md](./patrones-comunicacion.md) | Explica comunicacion sincronica y asincronica | Para disenar integraciones |
| [almacenamiento-documentos.md](./almacenamiento-documentos.md) | Define manejo conceptual de documentos y evidencias | Para documentar reportes o adjuntos |
| [checklist-servicio.md](./checklist-servicio.md) | Valida si un servicio esta listo para documentarse | Antes de crear carpeta en `servicios` |
| [_plantilla](./_plantilla/) | Estructura base para un servicio aprobado | Al crear documentacion real de servicio |
| [servicios](./servicios/) | Espacio para servicios aprobados | Solo cuando exista decision registrada |

## Relacion con dominio

Los modulos de `02-dominio/modulos` explican el negocio. Esta carpeta explica una posible organizacion tecnica. Un servicio puede cubrir varios modulos si eso reduce complejidad y mantiene trazabilidad.

## Regla

No crear carpetas reales de servicios para aparentar avance. Un servicio entra a `servicios` cuando tenga alcance, datos, dependencias y decision documentada.
