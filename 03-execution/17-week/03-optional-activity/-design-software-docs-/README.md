# Horarios SENA - Repositorio de documentacion

Este repositorio centraliza la documentacion del proyecto **Horarios SENA**. Su objetivo es que cualquier integrante del equipo pueda entender el contexto, el dominio, los requisitos, la arquitectura, las APIs, los microservicios y las reglas de gobierno documental sin depender de explicaciones externas.

Este repo no contiene codigo de producto, credenciales, usuarios reales, secretos ni configuraciones operativas avanzadas.

## Como navegar

1. Empieza por [01-contexto](./01-contexto/) para entender el problema y el alcance.
2. Revisa [02-dominio](./02-dominio/) para conocer los modulos funcionales y reglas del negocio.
3. Consulta [04-requisitos](./04-requisitos/) para ver requisitos y trazabilidad.
4. Usa [05-arquitectura](./05-arquitectura/) para decisiones y vistas de arquitectura.
5. Revisa [07-api](./07-api/) y [09-microservicios](./09-microservicios/) para contratos, servicios y dependencias.
6. Consulta [00-gobernanza](./00-gobernanza/) antes de crear, mover o promover documentos.

## Estructura documental

| Carpeta | Proposito | Documento inicial |
|---------|-----------|-------------------|
| [00-gobernanza](./00-gobernanza/) | Reglas del repositorio, ramas, trazabilidad, seguridad documental y plantillas | [README](./00-gobernanza/README.md) |
| [01-contexto](./01-contexto/) | Contexto institucional, alcance y glosario | [README](./01-contexto/README.md) |
| [02-dominio](./02-dominio/) | Mapa de dominio, modulos funcionales, entidades y eventos | [mapa-dominio](./02-dominio/mapa-dominio.md) |
| [03-producto](./03-producto/) | Vision, hoja de ruta y backlog de producto | [README](./03-producto/README.md) |
| [04-requisitos](./04-requisitos/) | Requisitos funcionales, no funcionales, historias y trazabilidad | [matriz-trazabilidad](./04-requisitos/matriz-trazabilidad.md) |
| [05-arquitectura](./05-arquitectura/) | Arquitectura, decisiones ADR y aspectos transversales | [README](./05-arquitectura/README.md) |
| [06-datos](./06-datos/) | Modelos de datos, diccionario y migracion | [README](./06-datos/README.md) |
| [07-api](./07-api/) | Lineamientos y contratos API | [README](./07-api/README.md) |
| [08-uml](./08-uml/) | Indice de diagramas y fuentes editables | [indice-diagramas](./08-uml/indice-diagramas.md) |
| [09-microservicios](./09-microservicios/) | Catalogo de servicios, limites, dependencias, eventos y plantillas | [catalogo-servicios](./09-microservicios/catalogo-servicios.md) |
| [10-ambientes-publicacion](./10-ambientes-publicacion/) | Referencias de ambientes y despliegue documental, sin automatizacion obligatoria | [README](./10-ambientes-publicacion/README.md) |
| [11-calidad](./11-calidad/) | Calidad documental, revisiones y criterios de prueba | [estrategia-calidad](./11-calidad/estrategia-calidad.md) |
| [12-experiencia-usuario](./12-experiencia-usuario/) | Navegacion, wireframes y sistema visual | [README](./12-experiencia-usuario/README.md) |
| [13-operacion](./13-operacion/) | Operacion esperada, incidencias y continuidad conceptual | [README](./13-operacion/README.md) |
| [14-manuales](./14-manuales/) | Manuales de usuario, administrador y onboarding tecnico | [README](./14-manuales/README.md) |
| [15-control-proyecto](./15-control-proyecto/) | Riesgos, dependencias, preguntas abiertas y backlog tecnico | [riesgos](./15-control-proyecto/riesgos.md) |
| [99-archivo](./99-archivo/) | Documentos deprecados o reemplazados | [README](./99-archivo/README.md) |

## Modulos funcionales base

| Modulo | Nombre | Cobertura |
|--------|--------|-----------|
| M01 | Seguridad y Acceso | Multi-tenant, permisos, auditoria |
| M02 | Estructura Institucional | Regionales, centros de formacion, ubicacion especifica |
| M03 | Infraestructura | Ambientes, inventario |
| M04 | Parametrizacion | Catalogos base y configuraciones genericas |
| M05 | Programas de Formacion | Lineas, redes, diseno curricular, competencias y RAP |
| M06 | Oferta y Programas | Proyecto formativo, fichas, entregables y asociacion de aprendices |
| M07 | Actores | Instructores, aprendices y directivos |
| M08 | Horarios | Observaciones, incidencias y asignacion |
| M09 | Proyectos Formativos | Seguimiento y notificaciones |
| M10 | Coordinacion y Eventos | Eventos y coordinacion academica |

## Reglas rapidas

- Todo documento nuevo debe tener un objetivo claro y estar enlazado desde el `README.md` de su carpeta.
- La fuente canonica de trazabilidad vive en [04-requisitos/matriz-trazabilidad.md](./04-requisitos/matriz-trazabilidad.md).
- Los cambios de arquitectura deben quedar asociados a un ADR cuando cambien una decision importante.
- No se publican correos, usuarios reales, tokens, llaves, credenciales ni secretos.
- La promocion de documentacion entre ramas es manual y visible; ver [estrategia-ramas](./00-gobernanza/estrategia-ramas.md).

## Estado de madurez documental

El repositorio apunta a un nivel **Definido**: existen reglas, plantillas, flujo manual de revision y trazabilidad entre requisitos, dominio, arquitectura, APIs y microservicios. No busca ser una arquitectura empresarial pesada; busca ser clara, mantenible y escalable para el proyecto SENA Nacional.
