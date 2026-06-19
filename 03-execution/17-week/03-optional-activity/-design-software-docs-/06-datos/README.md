# Datos

Esta carpeta organiza la vista de datos del proyecto. Su responsabilidad es traducir entidades del dominio a grupos de informacion entendibles, sin saltar todavia a tablas fisicas o decisiones de base de datos.

## Proposito

Evitar que cada modulo nombre o entienda los datos de forma distinta. Aqui se consolidan conceptos compartidos como ficha, ambiente, programa, horario, seguimiento y evento.

## Documentos

| Documento | Que explica | Estado |
|-----------|-------------|--------|
| [modelos.md](./modelos.md) | Modelo conceptual inicial por modulos | Definido |
| [diccionario-datos.md](./diccionario-datos.md) | Datos principales, significado y modulo responsable | Definido |
| [estrategia-migracion.md](./estrategia-migracion.md) | Criterios para cambios futuros de datos | Definido |

## Que no va aqui

- Scripts SQL definitivos.
- Credenciales de base de datos.
- Nombres de servidores.
- Modelos fisicos sin decision de arquitectura.

## Regla

Primero se define el significado en `02-dominio`; despues se documenta la estructura conceptual aqui. Si un dato cambia de significado, tambien debe revisarse glosario, requisitos y trazabilidad.
