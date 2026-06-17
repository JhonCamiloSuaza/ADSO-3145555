# Changelog

## [Unreleased]

### Added
- `setup-git-flow.ps1` y `setup-git-flow.sh`: Scripts automatizados para crear el árbol de ramas en Git con trazabilidad manual (merges `--no-ff`).

### Changed
- `00-governance/git-conventions.md` & `branch-strategy.md`: Sincronizadas y enfocadas conceptualmente en el modelo oficial de 8 ramas y promoción de ambientes.
- `00-governance/APPROVAL-MATRIX.md`: Rediseñada a nivel conceptual, removiendo SLAs rígidos y simplificando el flujo de aprobación a roles principales.
- `00-governance/SECURITY-GOVERNANCE.md` & `security-rules.md`: Simplificados y unificados conceptualmente para enfocarse en la protección ante fugas de información, uso de Mock Data (SOFIA Plus / BETOWA) y protocolo de limpieza del historial de Git, eliminando burocracia de auditoría operativa y PII corporativo.
- `.github/pull_request_template.md`: Ajustado para reflejar las ramas del flujo de promoción oficial.

### Fixed
- `00-governance/documentation-rules.md`, `definition-of-ready.md`, `definition-of-done.md`, `microservices-documentation.md`: Actualizados a estado "🟢 Estable" y asignados al Equipo de Gobernanza.
- `README.md`: Removida la referencia a `.github/CODEOWNERS` ya que se eliminó el archivo operativo correspondiente.

### Added (sesión anterior)
- `.github/CODEOWNERS`: ownership de revisión por sección del repositorio
- `05-architecture/decisions/_template-adr.md`: template standalone para crear ADRs
- `15-project-control/open-questions.md`: flujo de registro y resolución de preguntas abiertas
- `00-governance/git-conventions.md`: reglas de ramas, ambientes, releases y commits
- `00-governance/microservices-documentation.md`: flujo para documentar microservicios reales
- `00-governance/security-rules.md`: reglas contra fugas de información sensible

### Fixed
- `05-architecture/decisions/README.md`: aclarada política de ADRs deprecadas (permanecen en `records/`, no se mueven)
- `CONTRIBUTING.md`: corregida instrucción contradictoria sobre mover ADRs a `99-archive/`
- `.github/pull_request_template.md`: añadidos criterios de Definition of Ready y Done al checklist
- `09-microservices/_template/README.md`: identificado claramente como plantilla (no documento pendiente)

### Improved
- `07-api/README.md`: añadida regla de contrato canónico vs contrato de implementación
- `00-governance/documentation-rules.md`: añadida tabla de dónde van recursos visuales (`assets/` vs `08-uml/`)
- `02-domain/README.md`: añadida nota de diferenciación con `06-data/`
- `06-data/README.md`: añadida nota de diferenciación con `02-domain/`
- `14-training/README.md`: añadida tabla de audiencias y orientación para equipo de soporte
- `README.md`: añadidos CHANGELOG y CODEOWNERS a documentos de gobierno
- `CONTRIBUTING.md`: reducido a hub operativo con enlaces a reglas especializadas
- `00-governance/documentation-rules.md`: enfocado en reglas documentales, índices y diagramas

---

## [Estructura inicial]

### Added
- Estructura inicial del repositorio de documentación
