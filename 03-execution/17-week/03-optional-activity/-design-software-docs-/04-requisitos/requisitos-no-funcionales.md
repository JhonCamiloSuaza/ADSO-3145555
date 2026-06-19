# Requisitos no funcionales

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Estos requisitos describen atributos de calidad del sistema y de la documentacion. No definen herramientas obligatorias ni configuraciones reales.

## Requisitos base

| ID | Categoria | Requisito | Evidencia documental |
|----|-----------|-----------|----------------------|
| RNF-001 | Disponibilidad | La arquitectura debe considerar disponibilidad para jornadas academicas y procesos de coordinacion. | `05-arquitectura/vision-general.md` |
| RNF-002 | Seguridad | La documentacion no debe incluir secretos, credenciales, usuarios reales ni informacion sensible innecesaria. | `00-gobernanza/reglas-seguridad.md` |
| RNF-003 | Trazabilidad | Todo requisito funcional debe relacionarse con modulo y servicio propuesto. | `04-requisitos/matriz-trazabilidad.md` |
| RNF-004 | Mantenibilidad | Todo documento nuevo debe tener proposito, ubicacion e indice en README. | `00-gobernanza/reglas-documentacion.md` |
| RNF-005 | Escalabilidad documental | La estructura debe permitir agregar servicios, APIs, diagramas y manuales sin reorganizar todo el repo. | `09-microservicios/checklist-servicio.md` |
| RNF-006 | Auditabilidad | Los cambios documentales deben promoverse manualmente por ramas visibles. | `00-gobernanza/estrategia-ramas.md` |
| RNF-007 | Claridad | Los nombres de archivos deben ser descriptivos y evitar abreviaturas ambiguas. | `00-gobernanza/reglas-documentacion.md` |

## Regla

Los requisitos no funcionales deben medirse mediante evidencia documental o criterio de revision. No se deben inventar metricas tecnicas que aun no puedan validarse.
