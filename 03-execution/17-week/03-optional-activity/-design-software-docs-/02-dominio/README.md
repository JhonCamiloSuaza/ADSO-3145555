# Dominio

Esta carpeta describe el negocio del proyecto Horarios SENA: modulos, entidades, reglas y eventos. No documenta tablas, columnas ni decisiones de almacenamiento; esos temas viven en `06-datos`.

## Documentos

| Documento | Proposito | Estado |
|-----------|-----------|--------|
| [mapa-dominio.md](./mapa-dominio.md) | Mapa de los 10 modulos funcionales y subdominios | En progreso |
| [modulos](./modulos/) | Vista visible de los 10 modulos definidos en la imagen base | En progreso |
| [entidades-y-reglas.md](./entidades-y-reglas.md) | Entidades principales, invariantes y reglas de negocio | Definido |
| [eventos-dominio.md](./eventos-dominio.md) | Eventos de dominio y significado funcional | Definido |

## Regla de separacion

- Dominio explica conceptos de negocio.
- Requisitos explican que debe hacer el sistema.
- Arquitectura explica decisiones tecnicas.
- APIs y microservicios explican contratos, limites y dependencias.
