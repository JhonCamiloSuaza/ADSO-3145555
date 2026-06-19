# Reglas de limites de servicio

> Estado: En progreso | Ultima actualizacion: 2026-06-19

Estas reglas ayudan a decidir si una capacidad debe ser modulo interno, componente o microservicio separado.

## Regla base

Primero se documenta el limite funcional. Despues se decide si ese limite necesita implementacion independiente.

## Criterios para separar un servicio

Un servicio puede separarse cuando cumple varias de estas condiciones:

- Tiene reglas de negocio propias.
- Cambia a un ritmo diferente del resto del sistema.
- Tiene datos que puede gobernar de forma clara.
- Necesita escalar, auditarse u operarse de manera independiente.
- Tiene contratos API o eventos bien definidos.

## Criterios para mantener como modulo

Debe mantenerse como modulo interno cuando:

- Comparte demasiadas reglas con otro modulo.
- No tiene datos propios.
- Su comportamiento depende completamente de otro modulo.
- Separarlo aumenta complejidad sin beneficio claro.

## Decisiones actuales

| Decision | Justificacion |
|----------|---------------|
| Iniciar con limites documentales | El proyecto esta en fase de documentacion y analisis |
| No crear carpetas reales de servicios aun | Evita simular implementaciones que no existen |
| Mantener M08 Horarios como limite fuerte | Es el nucleo operativo del proyecto |
| Mantener documentos y auditoria como transversales | Dan soporte a varios modulos |
