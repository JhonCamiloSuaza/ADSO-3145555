# Entidades y reglas de negocio

Este documento define las entidades principales del dominio Horarios SENA y las reglas que no deben romperse cuando se escriban requisitos, APIs, modelos de datos o microservicios.

## Como leer este documento

Las entidades representan conceptos del negocio, no tablas de base de datos. Una entidad puede convertirse despues en tabla, recurso API o parte de un servicio, pero aqui se documenta primero su significado.

## Entidades principales por modulo

| Modulo | Entidades principales | Que representan |
|--------|----------------------|-----------------|
| M01 Seguridad y Acceso | Usuario, Perfil, Permiso, Sesion, Registro de auditoria | Control de acceso, trazabilidad y seguridad documental |
| M02 Estructura Institucional | Regional, Centro de formacion, Sede, Ubicacion | Organizacion territorial e institucional del SENA |
| M03 Infraestructura | Ambiente, Recurso, Inventario, Disponibilidad | Espacios y elementos disponibles para actividades formativas |
| M04 Parametrizacion | Catalogo, Parametro, Valor de catalogo | Configuraciones reutilizables por varios modulos |
| M05 Programas de Formacion | Programa, Linea, Red, Tipo de formacion, Diseno curricular, Competencia, RAP | Estructura academica base |
| M06 Oferta y Programas | Ficha, Proyecto formativo, Entregable, Asociacion de aprendiz | Oferta concreta y ejecucion academica |
| M07 Actores | Instructor, Aprendiz, Directivo, Rol academico | Personas que participan en el proceso formativo |
| M08 Horarios | Horario, Franja, Asignacion, Observacion, Incidencia | Planeacion de tiempo, espacios y actores |
| M09 Proyectos Formativos | Seguimiento, Alerta, KPI, Notificacion | Control del avance y calidad del proyecto formativo |
| M10 Coordinacion y Eventos | Evento, Agenda, Coordinacion, Participante | Actividades de coordinacion academica |

## Reglas generales

1. Un dato debe tener un modulo responsable.
2. Los catalogos y parametros se administran desde M04, aunque otros modulos los consuman.
3. La estructura institucional se define antes de ambientes, programas, fichas y horarios.
4. Un horario no debe existir sin ficha, instructor, ambiente o actividad relacionada.
5. Un proyecto formativo debe estar asociado a programa, ficha y entregables.
6. Las incidencias y observaciones deben conservar trazabilidad.
7. Las acciones relevantes deben poder auditarse.
8. Los documentos, evidencias y reportes deben estar asociados a un modulo o proceso.

## Reglas por modulo

### M01 Seguridad y Acceso

- Todo usuario debe tener un perfil o conjunto de permisos.
- Las acciones sensibles deben generar registro de auditoria.
- No se documentan usuarios reales, correos ni credenciales en este repositorio.

### M02 Estructura Institucional

- Una regional puede tener varios centros de formacion.
- Un centro puede tener varias ubicaciones o sedes.
- Otros modulos deben referenciar la estructura institucional, no redefinirla.

### M03 Infraestructura

- Un ambiente pertenece a una ubicacion institucional.
- Un ambiente puede tener inventario asociado.
- La disponibilidad de un ambiente afecta directamente la asignacion de horarios.

### M04 Parametrizacion

- Un catalogo base debe tener nombre, descripcion y valores permitidos.
- Los parametros deben ser entendibles por negocio, no solo por tecnologia.
- No se deben duplicar catalogos entre modulos.

### M05 Programas de Formacion

- Un programa debe tener estructura curricular clara.
- Las competencias y RAP pertenecen al diseno curricular.
- Los cambios en diseno curricular impactan fichas, proyectos y horarios.

### M06 Oferta y Programas

- Una ficha representa una oferta concreta de formacion.
- Un proyecto formativo debe relacionarse con ficha, programa y entregables.
- La asociacion de aprendices a proyectos debe quedar trazable.

### M07 Actores

- Un aprendiz puede estar asociado a ficha y proyecto formativo.
- Un instructor puede participar en horarios, proyectos y eventos.
- Un directivo participa en revision, seguimiento o coordinacion.

### M08 Horarios

- La asignacion de horarios debe considerar ficha, instructor, ambiente y disponibilidad.
- Una incidencia debe indicar que afecto y en que contexto ocurrio.
- Las observaciones sirven para seguimiento y mejora.

### M09 Proyectos Formativos

- El seguimiento debe relacionarse con proyecto formativo.
- Los KPIs deben medir estado, avance o calidad.
- Las notificaciones deben estar asociadas a un evento o cambio relevante.

### M10 Coordinacion y Eventos

- Un evento debe tener fecha, objetivo, participantes y modulo relacionado.
- La coordinacion no reemplaza horarios, pero puede depender de ellos.
- Las actividades de coordinacion deben poder consultarse como parte del seguimiento academico.

## Orden logico de construccion del dominio

1. M01 Seguridad y Acceso.
2. M02 Estructura Institucional.
3. M04 Parametrizacion.
4. M03 Infraestructura.
5. M05 Programas de Formacion.
6. M06 Oferta y Programas.
7. M07 Actores.
8. M08 Horarios.
9. M09 Proyectos Formativos.
10. M10 Coordinacion y Eventos.

Este orden permite construir primero las bases, luego la oferta academica, despues los actores y finalmente la planeacion, seguimiento y coordinacion.
