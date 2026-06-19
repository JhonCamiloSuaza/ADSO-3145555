# Dependencias

Este documento registra dependencias documentales y funcionales del proyecto.

## Dependencias internas

| Dependencia | Afecta | Motivo |
|-------------|--------|--------|
| Contexto definido | Todas las carpetas | Sin contexto no hay lectura comun |
| Modulos funcionales | Requisitos y microservicios | Los requisitos se organizan por modulo |
| Matriz de trazabilidad | Arquitectura, APIs y servicios | Evita decisiones desconectadas |
| Catalogos base | Infraestructura, programas, actores y horarios | Evita duplicidad |
| Estructura institucional | Ambientes, programas y horarios | Define ubicacion y pertenencia |
| Actores | Horarios, proyectos y eventos | Son participantes de la operacion |

## Dependencias externas conceptuales

| Dependencia | Estado | Nota |
|-------------|--------|------|
| Lineamientos SENA | Referencia | Usar como orientacion institucional |
| Sistemas oficiales SENA | No implementado | No documentar integraciones reales sin decision |
| Reglas academicas internas | Por validar con equipo | Deben convertirse en requisitos |

## Regla

Una dependencia debe tener motivo claro. Si no afecta requisitos, arquitectura, datos o usuarios, no debe agregarse.
