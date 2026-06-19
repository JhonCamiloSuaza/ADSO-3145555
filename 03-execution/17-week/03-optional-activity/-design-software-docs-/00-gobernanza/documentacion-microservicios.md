# Documentacion de microservicios propuestos

> Estado: Definido | Ultima actualizacion: 2026-06-19

Este documento explica como documentar servicios propuestos sin inventar implementaciones reales.

## Regla principal

No crear carpetas en `09-microservicios/servicios/` solo para llenar estructura. Un servicio se documenta con carpeta propia cuando tenga:

- Responsabilidad clara.
- Modulos relacionados.
- Datos principales.
- Dependencias identificadas.
- Decision registrada o pregunta resuelta.

## Ubicacion

Los servicios propuestos se listan primero en:

```text
09-microservicios/catalogo-servicios.md
```

Cuando un servicio este aprobado para documentacion detallada, se crea:

```text
09-microservicios/servicios/<nombre-del-servicio>/
```

## Plantilla

Usar:

```text
09-microservicios/_plantilla/
```

La plantilla contiene:

| Archivo | Que documenta |
|---------|---------------|
| `README.md` | Responsabilidad, modulos relacionados y dependencias |
| `contrato-api.md` | Contrato conceptual de API si aplica |
| `modelo-datos.md` | Datos principales y reglas del servicio |
| `eventos.md` | Eventos que publica o consume conceptualmente |
| `guia-operacion.md` | Consideraciones de operacion conceptual |

## Que no debe incluir

- Repositorios reales si no existen.
- Credenciales.
- Variables reales.
- Procedimientos reales de publicacion.
- Procedimientos reales de recuperacion.
- Guias operativas de produccion.
- Integraciones reales no aprobadas.

## Criterio de revision

Antes de aceptar un servicio documentado, revisar:

- Esta relacionado con uno o mas modulos funcionales.
- No duplica responsabilidad de otro servicio.
- Tiene dependencias visibles.
- Tiene datos principales identificados.
- Esta enlazado en `catalogo-servicios.md`.
- No contiene informacion sensible.

## Regla

En fase 1, los microservicios son una vista de arquitectura documental. No representan implementaciones reales hasta que el proyecto lo decida formalmente.
