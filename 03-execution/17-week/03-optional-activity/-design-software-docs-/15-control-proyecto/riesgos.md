# Riesgos del proyecto documental

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este documento registra riesgos de documentacion, arquitectura y trazabilidad. No reemplaza una matriz corporativa; es una herramienta simple para que el equipo sepa que puede afectar la calidad del repositorio.

## Escala

| Nivel | Significado |
|-------|-------------|
| Bajo | Puede corregirse sin afectar entregas principales |
| Medio | Puede generar retrabajo o confusion entre equipos |
| Alto | Puede bloquear trazabilidad, revision o toma de decisiones |

## Riesgos iniciales

| ID | Riesgo | Nivel | Impacto | Mitigacion |
|----|--------|-------|---------|------------|
| R-001 | Crear demasiados documentos sin contenido real | Alto | El equipo no sabe que leer ni que mantener | Mantener solo documentos con proposito claro y README actualizado |
| R-002 | Usar nombres tecnicos confusos | Medio | Baja adopcion por parte de companeros | Usar kebab-case y nombres descriptivos |
| R-003 | Duplicar matrices de trazabilidad | Alto | Se pierde la fuente de verdad | Mantener la matriz canonica en `04-requisitos/matriz-trazabilidad.md` |
| R-004 | Inventar microservicios como si ya existieran | Alto | Se confunde documentacion con implementacion | Documentar servicios como propuestos hasta que exista decision aprobada |
| R-005 | Mezclar dominio, APIs y arquitectura en un solo documento | Medio | Se dificulta mantenimiento | Separar por carpetas y enlazar entre documentos |
| R-006 | Agregar credenciales, usuarios reales o datos sensibles | Alto | Riesgo de seguridad documental | Aplicar `00-gobernanza/reglas-seguridad.md` |
| R-007 | Promover cambios sin revision manual | Medio | Llegan errores a ramas estables | Seguir `00-gobernanza/estrategia-ramas.md` |

## KPI documentales sugeridos

| KPI | Meta inicial |
|-----|--------------|
| Documentos enlazados desde su README | 100% |
| Requisitos con modulo asociado | 100% |
| Requisitos con servicio propuesto asociado | 80% o mas |
| Documentos con estado claro | 100% |
| Documentos duplicados o sin proposito | 0 criticos |
| Secretos o datos sensibles publicados | 0 |
