# Estrategia de calidad documental

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Como este repositorio es documental, la calidad se valida revisando claridad, trazabilidad, consistencia y seguridad de la informacion.

## Criterios de revision

| Criterio | Pregunta de control |
|----------|---------------------|
| Claridad | El documento se entiende sin explicacion adicional? |
| Proposito | El documento aporta una decision, regla, matriz, plantilla o contexto util? |
| Trazabilidad | Esta relacionado con requisito, modulo, servicio, API, evento o ADR cuando aplica? |
| Ubicacion | Esta en la carpeta correcta? |
| Nombre | Usa un nombre descriptivo en kebab-case? |
| Seguridad | Evita correos, usuarios reales, credenciales, secretos y datos sensibles? |
| Mantenibilidad | Tiene un responsable conceptual y puede actualizarse sin duplicar informacion? |

## Checklist para PR documental

- [ ] El cambio tiene alcance claro.
- [ ] Los archivos nuevos estan enlazados desde el README de su carpeta.
- [ ] No se agregaron secretos ni datos sensibles.
- [ ] No se duplico informacion que ya tenia fuente canonica.
- [ ] Si hay nuevo requisito, se actualizo `04-requisitos/matriz-trazabilidad.md`.
- [ ] Si hay nuevo servicio propuesto, se actualizo `09-microservicios/catalogo-servicios.md`.
- [ ] Si hay decision arquitectonica importante, se creo o actualizo un ADR.

## Evidencia aceptada

Para documentacion, la evidencia puede ser:

- Enlace a requisito.
- Enlace a ADR.
- Matriz actualizada.
- Diagrama registrado en `08-uml/indice-diagramas.md`.
- Checklist de PR completado.

No se exigen pruebas automatizadas para promover documentos, salvo que el equipo decida agregar validaciones simples de formato en el futuro.
