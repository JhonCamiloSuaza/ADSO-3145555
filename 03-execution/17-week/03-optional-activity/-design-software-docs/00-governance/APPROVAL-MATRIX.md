# Approval Matrix

> Estado: 🟢 Estable | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Gobernanza

## Propósito

Definir de manera conceptual los roles responsables de la revisión y aprobación para cada sección del repositorio de documentación, asegurando la trazabilidad de las decisiones sin sobrecargar el flujo operativo.

## Matriz de Aprobaciones

| Sección | Descripción | Rol Revisor | Rol Aprobador | Criterio de Aceptación |
|---------|-------------|-------------|---------------|------------------------|
| `00-governance` | Reglas y políticas del repositorio | Equipo de Arquitectura | Arquitecto Lead | Consistencia con el estándar nacional |
| `01-context` | Contexto institucional y alcance | Product Owner (PO) | Product Owner (PO) | Alineación con objetivos del SENA |
| `02-domain` | Modelo de dominio y contextos | Equipo de Arquitectura | Arquitecto Lead | Correcta delimitación de contextos |
| `03-product` | Visión y backlog de producto | Product Owner (PO) | Product Owner (PO) | Roadmap de producto actualizado |
| `04-requirements` | Requisitos funcionales y no funcionales | Product Owner & QA | Product Owner (PO) | Criterios de aceptación claros |
| `05-architecture` | Vistas arquitectónicas y ADRs | Equipo de Arquitectura | Arquitecto Lead | Viabilidad técnica y registro de ADR |
| `06-data` | Modelos de datos y migración | Equipo de Arquitectura | Arquitecto Lead | Normalización y diseño de datos |
| `07-api` | Contratos y lineamientos de API | Equipo de Arquitectura | Arquitecto Lead | Cumplimiento del estándar de diseño |
| `08-uml` | Diagramas y artefactos visuales | Equipo de Arquitectura | Equipo de Arquitectura | Fuente editable y SVG incluidos |
| `09-microservices` | Catálogo e integración de servicios | Equipo de Arquitectura | Arquitecto Lead | Catálogo de servicios actualizado |
| `10-devops` | Setup local y despliegues | DevOps Lead | DevOps Lead | Automatización y scripts validados |
| `11-quality` | Estrategias de testing | QA Lead | QA Lead | Plan de pruebas documentado |
| `12-ux-ui` | Design system y prototipos | UX/UI Lead | Product Owner (PO) | Consistencia visual del sistema |
| `13-operations` | Observabilidad y resiliencia | DevOps Lead | DevOps Lead | Estrategias de monitoreo definidas |
| `14-training` | Manuales y guías de usuario | Training Lead | Product Owner (PO) | Claridad e impacto pedagógico |
| `15-project-control` | Riesgos y backlog técnico | Project Manager | Project Manager | Seguimiento de dependencias y riesgos |
| `99-archive` | Documentos históricos o deprecados | Equipo de Arquitectura | Arquitecto Lead | Historial preservado |

## Reglas de Aprobación

1. **Revisión por Pares**: Todo cambio propuesto debe ser revisado por al menos un miembro del equipo asociado al rol revisor de la sección.
2. **Aprobación de la Sección**: El rol aprobador valida la conformidad técnica o funcional antes de dar el visto bueno final.
3. **Flujo de Promoción**: Las aprobaciones se gestionan a través del flujo de Pull Requests correspondiente a cada ambiente de documentación, garantizando la trazabilidad en Git.

## Flujo de Aprobación por Ambiente

### Ambiente: `architecture-documentation-dev` → `dev`
- **Revisor**: Rol Revisor de la sección correspondiente.
- **Enfoque**: Validación de formato, completitud técnica inicial y ausencia de conflictos.

### Ambiente: `architecture-documentation-staging` → `staging`
- **Revisor**: Coordinación entre el Rol Revisor y el Rol Aprobador.
- **Enfoque**: Consistencia transversal entre secciones de arquitectura y negocio.

### Ambiente: `architecture-documentation-qa` → `qa`
- **Revisor**: Rol Aprobador de la sección.
- **Enfoque**: Validación de conformidad funcional y cumplimiento de requisitos.

### Ambiente: `architecture-documentation-main` → `main`
- **Revisor**: Product Owner y Arquitecto Lead.
- **Enfoque**: Documentación estable y definitiva lista para su publicación.

## Resolución de Conflictos y Excepciones

- **Casos de Divergencia**: Si existen diferencias de criterio en las revisiones, el Arquitecto Lead o el Product Owner actuarán como mediadores conceptuales para asegurar el consenso basado en las metas del proyecto.
- **Actualizaciones Urgentes (Hotfixes)**: Modificaciones críticas se tramitarán con prioridad conceptual, requiriendo el visto bueno directo del aprobador de la sección respectiva antes del merge.

## Roles del Proceso Documental

| Rol | Foco Principal |
|-----|----------------|
| **Arquitecto Lead** | Asegurar la cohesión técnica global, viabilidad de las ADRs y alineación de infraestructura. |
| **Product Owner (PO)** | Validar la entrega de valor, el cumplimiento de requisitos de negocio y visión institucional. |
| **DevOps Lead** | Garantizar la factibilidad del despliegue, automatización de CI/CD y observabilidad conceptual. |
| **QA Lead** | Asegurar la definición y cobertura de los criterios de aceptación y calidad de las pruebas. |

Versión: v1.0 — 2026-06-17

