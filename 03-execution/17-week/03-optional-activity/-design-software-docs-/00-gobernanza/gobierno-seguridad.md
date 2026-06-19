# Gobierno de seguridad documental

> Estado: Definido | Ultima actualizacion: 2026-06-19

Este documento define criterios simples de seguridad para la documentacion. No configura seguridad real, no define usuarios reales y no describe integraciones o herramientas avanzadas.

## Proposito

Evitar que el repositorio publique informacion sensible mientras se construye la arquitectura documental del proyecto Horarios SENA.

## Informacion permitida

| Tipo | Ejemplo permitido |
|------|-------------------|
| Conceptos de dominio | Modulos, entidades, reglas y eventos |
| Requisitos | Requisitos funcionales y no funcionales |
| Arquitectura documental | Decisiones, vistas conceptuales y trazabilidad |
| Ejemplos genericos | Rutas, nombres o datos simulados |

## Informacion no permitida

- Correos electronicos reales.
- Usuarios reales de GitHub.
- Contrasenas.
- Tokens.
- Secrets.
- Credenciales.
- Llaves privadas.
- URLs internas reales.
- Integraciones reales no aprobadas.
- Configuraciones avanzadas de seguridad.

## Revision de seguridad documental

Antes de promover un cambio, revisar:

- El documento no contiene datos personales reales.
- Los ejemplos son genericos.
- No hay credenciales ni secretos.
- No se mencionan usuarios reales.
- No se documentan integraciones reales como si ya existieran.

## Relacion con ramas

La seguridad documental se revisa manualmente en cada promocion:

```text
architecture-documentation-dev -> dev -> architecture-documentation-staging -> staging -> architecture-documentation-qa -> qa -> architecture-documentation-main -> main
```

## Regla

Si un dato no es necesario para entender la documentacion, no debe incluirse.
