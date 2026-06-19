# Guia de contribucion documental

Este repositorio contiene la arquitectura documental del proyecto Horarios SENA. Toda contribucion debe mejorar claridad, trazabilidad o mantenimiento de la documentacion.

## Regla principal

No trabajar directamente sobre `dev`, `staging`, `qa` o `main`. Los cambios documentales se revisan y promueven manualmente.

## Antes de editar

1. Leer el `README.md` raiz.
2. Identificar la carpeta correcta.
3. Revisar `00-gobernanza/reglas-documentacion.md`.
4. Confirmar que el cambio no duplica otro documento.

## Estructura general

| Carpeta | Proposito |
|---------|-----------|
| `00-gobernanza` | Reglas, ramas, revision, seguridad y trazabilidad |
| `01-contexto` | Vision, alcance y glosario |
| `02-dominio` | Modulos, entidades, reglas y eventos |
| `03-producto` | Vision de producto, hoja de ruta y backlog |
| `04-requisitos` | Requisitos, historias y matriz de trazabilidad |
| `05-arquitectura` | Vistas, decisiones y criterios de arquitectura documental |
| `06-datos` | Modelo conceptual y diccionario de datos |
| `07-api` | Lineamientos conceptuales de API |
| `08-uml` | Diagramas y fuentes visuales |
| `09-microservicios` | Servicios propuestos, limites y dependencias |
| `10-ambientes-publicacion` | Ambientes documentales y promocion manual |
| `11-calidad` | Revision documental |
| `12-experiencia-usuario` | Navegacion, bocetos y sistema visual |
| `13-operacion` | Operacion conceptual |
| `14-manuales` | Manuales e induccion |
| `15-control-proyecto` | Riesgos, dependencias, preguntas y tablero |
| `99-archivo` | Documentos historicos o deprecados |

## Flujo de ramas

```text
architecture-documentation-dev
        ->
       dev
        ->
architecture-documentation-staging
        ->
     staging
        ->
architecture-documentation-qa
        ->
        qa
        ->
architecture-documentation-main
        ->
       main
```

Cada promocion requiere revision humana y aprobacion manual.

## Como proponer un cambio

1. Crear una rama temporal desde `architecture-documentation-dev`.
2. Editar el documento.
3. Actualizar el README de la carpeta si se agrega o mueve contenido.
4. Revisar trazabilidad si el cambio afecta requisitos, modulos, servicios o arquitectura.
5. Validar que no haya informacion sensible.
6. Abrir revision manual.

## Commits

Formato recomendado:

```text
docs(<carpeta>): descripcion breve
```

Ejemplos:

```bash
docs(01-contexto): ampliar alcance documental
docs(02-dominio): documentar orden de modulos
fix(04-requisitos): corregir enlace de matriz
```

## No agregar

- Correos reales.
- Usuarios reales de GitHub.
- Contrasenas.
- Tokens.
- Secrets.
- Credenciales.
- Integraciones reales no aprobadas.
- Pipelines.
- GitHub Actions para promocion documental.
- Configuraciones avanzadas de seguridad.
- Procesos de produccion.

## Checklist antes de revision

- [ ] El cambio tiene objetivo claro.
- [ ] El archivo esta en la carpeta correcta.
- [ ] El README correspondiente esta actualizado.
- [ ] La trazabilidad fue revisada si aplica.
- [ ] No hay datos sensibles.
- [ ] El cambio puede promoverse manualmente.

## Dudas

Registrar preguntas en `15-control-proyecto/preguntas-abiertas.md`.
