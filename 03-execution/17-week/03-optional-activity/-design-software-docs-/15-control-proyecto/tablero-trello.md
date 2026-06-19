# Tablero Trello para gestion documental

Este documento define una propuesta base de tablero Trello para gestionar el avance de la documentacion del proyecto Horarios SENA. El tablero debe permitir ver, de forma rapida, que esta pendiente, que se esta trabajando, que esta en revision y que ya quedo terminado.

La idea no es crear burocracia. La idea es que cada tarea documental tenga un estado visible, un responsable de trabajo, una carpeta afectada y un criterio claro para cerrarse.

## Flujo principal del tablero

```text
Product Backlog
        ↓
📝 Pendiente (To Do)
        ↓
⚙️ En Desarrollo (In Progress)
        ↓
🧪 En Pruebas (Testing)
        ↓
✅ Terminado (Done)
```

## Vista tipo Trello

| Product Backlog | 📝 Pendiente | ⚙️ En Desarrollo | 🧪 En Pruebas | ✅ Terminado |
|-----------------|--------------|------------------|---------------|--------------|
| Crear diagrama de los 10 modulos | Revisar redaccion de `00-gobernanza` | Ampliar `02-dominio/entidades-y-reglas.md` | Validar `04-requisitos/matriz-trazabilidad.md` | Completar `01-contexto/alcance.md` |
| Mejorar manual de usuario por modulos | Registrar riesgos documentales | Ajustar `03-producto/backlog-producto.md` | Revisar `09-microservicios/catalogo-servicios.md` | Crear `15-control-proyecto/tablero-trello.md` |
| Crear bocetos de pantallas base | Revisar preguntas abiertas sobre KPIs | Redactar diagramas sugeridos | Validar manuales iniciales | Renombrar carpetas principales a espanol |

## Que significa cada columna

### Product Backlog

Aqui van las ideas, mejoras o necesidades que todavia no entran al ciclo de trabajo.

Una tarjeta puede estar aqui si:

- La idea puede aportar valor, pero aun no esta priorizada.
- Falta definir alcance.
- Falta decidir si realmente se va a trabajar.
- Se necesita validacion antes de convertirla en tarea.

Ejemplos:

- Crear diagrama visual de los 10 modulos.
- Mejorar manual de usuario por modulo.
- Crear ejemplos de pantallas para horarios.
- Revisar si seguridad debe quedar en uno o dos documentos.

### 📝 Pendiente (To Do)

Aqui van las tareas que ya estan claras y listas para iniciar.

Una tarjeta entra aqui cuando:

- Ya se sabe que documento o carpeta afecta.
- Tiene resultado esperado.
- Tiene criterio de cierre.
- No depende de una decision externa urgente.

Ejemplos:

- Revisar `00-gobernanza/reglas-documentacion.md`.
- Ajustar `01-contexto/glosario.md`.
- Validar nombres de archivos en `12-experiencia-usuario`.
- Completar criterios de historias de usuario.

### ⚙️ En Desarrollo (In Progress)

Aqui van las tareas que alguien esta redactando, corrigiendo o estructurando.

Una tarjeta entra aqui cuando:

- Ya se empezo a editar el documento.
- Se esta reescribiendo contenido.
- Se estan ajustando enlaces o estructura.
- Se esta preparando una propuesta documental.

Ejemplos:

- Ampliar `02-dominio/entidades-y-reglas.md`.
- Ajustar `03-producto/backlog-producto.md`.
- Redactar `14-manuales/manual-usuario.md`.
- Crear contenido base para `08-uml/indice-diagramas.md`.

### 🧪 En Pruebas (Testing)

Aqui van los documentos listos para revision. En esta etapa no se prueba codigo; se revisa calidad documental.

Se valida que:

- El texto se entienda sin explicacion externa.
- No haya contenido de relleno.
- No haya campos vacios.
- Los enlaces tengan sentido.
- La trazabilidad este actualizada si aplica.
- No existan credenciales, secretos ni datos sensibles.

Ejemplos:

- Validar matriz de trazabilidad.
- Revisar catalogo de servicios propuestos.
- Revisar manual de administrador.
- Revisar tablero Trello documental.

### ✅ Terminado (Done)

Aqui van las tareas cerradas.

Una tarjeta llega aqui cuando:

- El documento ya fue actualizado.
- El README de la carpeta lo referencia si aplica.
- El contenido tiene sentido.
- La revision documental fue realizada.
- El cambio puede promoverse manualmente por ramas.

Ejemplos:

- Completar `01-contexto`.
- Documentar los 10 modulos funcionales.
- Crear tablero Trello documental.
- Organizar carpetas principales en espanol.

## Formato recomendado de tarjeta

```markdown
Titulo:
[carpeta] accion concreta

Ejemplo:
[02-dominio] Ampliar reglas de negocio por modulo

Descripcion:
Redactar reglas de negocio por cada modulo funcional para que el equipo entienda que significa cada parte del dominio y como se conecta con requisitos, datos y microservicios.

Carpeta o archivo afectado:
02-dominio/entidades-y-reglas.md

Resultado esperado:
- Entidades principales por modulo.
- Reglas de negocio claras.
- Orden logico del dominio.
- Relacion con requisitos y servicios propuestos.

Criterios de aceptacion:
- Se entiende sin explicacion externa.
- No tiene contenido vacio.
- No repite informacion innecesaria.
- Esta enlazado desde el README correspondiente.
- No contiene datos sensibles.
```

## Etiquetas recomendadas

### Por carpeta documental

| Etiqueta | Uso |
|----------|-----|
| `00-gobernanza` | Reglas, ramas, seguridad, revision y trazabilidad |
| `01-contexto` | Vision general, alcance y glosario |
| `02-dominio` | Modulos, entidades, reglas y eventos |
| `03-producto` | Vision, hoja de ruta y backlog |
| `04-requisitos` | Requisitos, historias y matriz de trazabilidad |
| `05-arquitectura` | Arquitectura, ADR y escalabilidad |
| `06-datos` | Modelo conceptual y diccionario de datos |
| `07-api` | Lineamientos, autenticacion y contratos |
| `08-uml` | Diagramas |
| `09-microservicios` | Servicios propuestos, eventos y dependencias |
| `10-publicacion` | Ambientes y promocion manual |
| `11-calidad` | Revision documental |
| `12-ux` | Navegacion, bocetos y sistema visual |
| `13-operacion` | Observabilidad, incidentes y continuidad |
| `14-manuales` | Manuales e induccion |
| `15-control` | Riesgos, dependencias, preguntas y tablero |
| `99-archivo` | Historico y documentos deprecados |

### Por tipo de trabajo

| Etiqueta | Uso |
|----------|-----|
| `redaccion` | Crear o mejorar contenido |
| `estructura` | Renombrar, mover o reorganizar |
| `trazabilidad` | Conectar requisito, modulo, servicio o decision |
| `revision` | Validar claridad, enlaces y consistencia |
| `diagrama` | Crear o actualizar diagramas |
| `manual` | Crear o mejorar guias |
| `riesgo` | Registrar o mitigar riesgos |

## Checklist de cada tarjeta

```text
[ ] Tiene objetivo claro
[ ] Indica carpeta o archivo afectado
[ ] Tiene resultado esperado
[ ] Tiene criterios de aceptacion
[ ] No duplica otra tarjeta
[ ] No contiene datos sensibles
[ ] Actualiza README si aplica
[ ] Actualiza trazabilidad si aplica
```

## Reglas para mover tarjetas

| Movimiento | Condicion |
|------------|-----------|
| Product Backlog -> Pendiente | La tarea ya tiene alcance y prioridad |
| Pendiente -> En Desarrollo | Alguien toma la tarea y empieza a trabajarla |
| En Desarrollo -> En Pruebas | El documento ya fue editado y esta listo para revision |
| En Pruebas -> Terminado | El documento fue revisado y cumple los criterios de aceptacion |

## Criterio final

El tablero debe mostrar el estado real del trabajo documental. Si una tarjeta no permite tomar accion, debe reescribirse. Si una tarjeta no termina en un cambio verificable del repositorio, no deberia estar en el tablero.
