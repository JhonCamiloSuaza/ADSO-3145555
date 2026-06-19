# Diagnostico de arquitectura documental

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Este diagnostico resume como debe simplificarse y mantenerse la documentacion del proyecto Horarios SENA.

## 1. Documentos que aportan valor

| Documento o carpeta | Motivo |
|---------------------|--------|
| `README.md` raiz | Entrada principal al repositorio |
| `00-gobernanza/estrategia-ramas.md` | Explica promocion manual entre ramas |
| `00-gobernanza/reglas-documentacion.md` | Evita nombres confusos y documentos invisibles |
| `02-dominio/mapa-dominio.md` | Alinea la documentacion con los 10 modulos funcionales |
| `04-requisitos/requisitos-funcionales.md` | Define requisitos por modulo |
| `04-requisitos/matriz-trazabilidad.md` | Fuente canonica de trazabilidad |
| `05-arquitectura/decisiones/` | Registra decisiones importantes mediante ADR |
| `09-microservicios/catalogo-servicios.md` | Conecta modulos con servicios propuestos |
| `09-microservicios/mapa-dependencias.md` | Hace visibles dependencias entre servicios |
| `15-control-proyecto/riesgos.md` | Controla riesgos y KPIs documentales |

## 2. Documentos sobredimensionados

| Documento | Riesgo | Recomendacion |
|-----------|--------|---------------|
| `10-ambientes-publicacion/flujo-publicacion.md` | Puede confundirse con procesos tecnicos si no se redacta con cuidado | Mantenerlo como referencia conceptual de promocion manual |
| `13-operacion/*` | Puede parecer operacion real de software aun no implementado | Mantenerlo en nivel conceptual |
| `gobierno-seguridad.md` | Puede duplicar `reglas-seguridad.md` | Mantenerlo conceptual y evitar detalle operativo |
| `matriz-revision.md` | Puede volverse burocratico si agrega personas o roles ficticios | Usarlo solo como guia de revision |

## 3. Nombres confusos

| Nombre actual | Problema | Nombre recomendado |
|---------------|----------|--------------------|
| `reglas-trazabilidad.md` | Antes era `TRACEABILITY-MATRIX.md`; ahora funciona como guia, no como matriz paralela | Mantener asi |
| `validacion-escalabilidad.md` | Antes era `VALIDACION-ESCALABILIDAD.md`; ahora cumple kebab-case | Mantener asi |
| `gobierno-seguridad.md` | Antes era `SECURITY-GOVERNANCE.md`; puede duplicar seguridad practica | Fusionar si repite `reglas-seguridad.md` |
| `matriz-revision.md` | Antes era `APPROVAL-MATRIX.md`; ahora cumple kebab-case | Mantener simple |

## 4. Documentos que deberian fusionarse

| Fusion | Motivo |
|--------|--------|
| `gobierno-seguridad.md` + `reglas-seguridad.md` | Revisar en el futuro si ambos empiezan a repetir exactamente lo mismo |
| `00-gobernanza/reglas-trazabilidad.md` + `04-requisitos/matriz-trazabilidad.md` | La matriz real debe vivir solo en requisitos |
| `10-ambientes-publicacion/flujo-publicacion.md` + `00-gobernanza/estrategia-ramas.md` si repiten exactamente el mismo contenido | Evita duplicar reglas del flujo manual |

## 5. Documentos faltantes ya agregados

| Documento | Proposito |
|-----------|-----------|
| `09-microservicios/mapa-dependencias.md` | Dependencias entre servicios propuestos |
| `09-microservicios/matriz-propiedad-datos.md` | Propiedad conceptual de datos |
| `09-microservicios/catalogo-eventos.md` | Eventos candidatos |
| `09-microservicios/reglas-limites-servicio.md` | Reglas para decidir limites |
| `09-microservicios/almacenamiento-documentos.md` | Reglas conceptuales de documentos y evidencias |
| `09-microservicios/checklist-servicio.md` | Checklist antes de crear carpetas reales de servicios |

## 6. Simplificacion recomendada

Mantener la estructura raiz actual porque cubre gobierno, contexto, dominio, requisitos, arquitectura, datos, APIs, UML, microservicios, calidad, manuales y control. La mejora no es borrar carpetas, sino:

- Convertir documentos vacios en plantillas o contenido minimo util.
- Evitar dos documentos con la misma fuente de verdad.
- Mantener los servicios como propuestos hasta que existan decisiones aprobadas.
- Usar `README.md` de cada carpeta como indice real.
- Promover cambios de forma manual segun `estrategia-ramas.md`.
- Archivar o fusionar documentos que se vuelvan repetitivos.

## Conclusion

La estructura actual es suficiente para un proyecto SENA Nacional si se mantiene simple. No necesita arquitectura empresarial pesada; necesita nombres claros, trazabilidad unica, plantillas utiles y una regla firme: documentar lo que existe o lo que esta formalmente propuesto, sin inventar implementacion.
