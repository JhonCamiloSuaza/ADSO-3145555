# Almacenamiento y documentos

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este documento define reglas conceptuales para documentos, adjuntos, evidencias y reportes del proyecto.

## Alcance

Aplica a:

- Plantillas documentales.
- Evidencias de seguimiento.
- Reportes PDF.
- Adjuntos asociados a proyectos, horarios, ambientes o coordinacion.

No define tecnologia de almacenamiento, buckets, credenciales ni rutas reales.

## Reglas

- Los archivos adjuntos deben tener metadatos: tipo, modulo origen, fecha, estado y referencia al requisito o proceso.
- El contenido sensible no debe incluir datos personales innecesarios.
- Los documentos generados deben poder rastrearse al evento o accion que los origino.
- El `document-service` es el responsable conceptual del ciclo de vida documental.
- El `audit-service` registra cambios relevantes, no almacena los documentos completos.

## Relacion con modulos

| Modulo | Uso documental |
|--------|----------------|
| M05/M06 | Disenos curriculares, entregables, fichas y proyectos |
| M08 | Evidencias de observaciones e incidencias |
| M09 | Reportes de seguimiento y notificaciones |
| M10 | Soportes de eventos y coordinacion |
