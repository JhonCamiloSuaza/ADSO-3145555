# Matriz simple de revision documental

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este documento define una revision manual sencilla para los cambios del repositorio. No usa nombres de personas, correos, usuarios reales ni cargos corporativos ficticios.

## Regla principal

Cada cambio documental debe ser revisado por al menos una persona distinta a quien lo escribio. La revision valida claridad, ubicacion, trazabilidad y ausencia de informacion sensible.

## Matriz por seccion

| Seccion | Que se revisa | Evidencia minima |
|---------|---------------|------------------|
| `00-gobernanza` | Reglas, ramas, convenciones y trazabilidad documental | README actualizado y regla clara |
| `01-contexto` | Contexto, alcance y glosario | El alcance no contradice requisitos |
| `02-dominio` | Modulos, entidades, reglas y eventos de negocio | Modulo o regla enlazada |
| `03-producto` | Vision, roadmap y backlog | Relacion con alcance del proyecto |
| `04-requisitos` | Requisitos funcionales, no funcionales e historias | Matriz de trazabilidad actualizada |
| `05-arquitectura` | Vistas, decisiones y ADR | Decision registrada si aplica |
| `06-datos` | Modelos y diccionario de datos | Propiedad de datos coherente |
| `07-api` | Lineamientos y contratos API | Requisito o servicio relacionado |
| `08-uml` | Diagramas y fuentes editables | Fuente y exportacion enlazadas |
| `09-microservicios` | Catalogo, limites, dependencias y eventos | Servicio propuesto alineado a modulo |
| `10-ambientes-publicacion` | Ambientes y referencias tecnicas | No agregar automatizaciones obligatorias |
| `11-calidad` | Calidad documental y revision | Checklist aplicado |
| `12-experiencia-usuario` | Navegacion, wireframes y sistema visual | Flujo o pantalla relacionada |
| `13-operacion` | Operacion conceptual e incidencias | Mantener nivel documental |
| `14-manuales` | Manuales y onboarding | Lenguaje entendible para usuarios |
| `15-control-proyecto` | Riesgos, dependencias y preguntas | Riesgo o pregunta con accion clara |
| `99-archivo` | Documentos deprecados | Motivo de archivo registrado |

## Checklist de aprobacion manual

- [ ] El documento tiene proposito claro.
- [ ] El nombre del archivo es entendible.
- [ ] El archivo esta en la carpeta correcta.
- [ ] El README de la carpeta fue actualizado.
- [ ] La trazabilidad fue actualizada si aplica.
- [ ] No hay credenciales, secretos, correos, usuarios reales ni datos sensibles.
- [ ] El cambio puede promoverse manualmente segun `estrategia-ramas.md`.
