# Validación de Escalabilidad: Arquitectura Documental SENA Nacional

> Estado: 🟢 Estable | Última actualización: 2026-06-17
> Autor: Equipo de Arquitectura | Área: Arquitectura de Software SENA Nacional

---

## ¿Para qué existe este documento?

Este documento responde de forma técnica y detallada a la pregunta:

> **¿Por qué la estructura documental del repositorio `design-software-docs` es una arquitectura de calidad, es escalable a nivel nacional y resiste el crecimiento del sistema SENA en el tiempo?**

Está escrito para que cualquier persona —ya sea un evaluador técnico, un coordinador académico, un instructor o un par de desarrollo— pueda leerlo y salir con la certeza de que el diseño propuesto no fue hecho al azar, sino con fundamento sólido en principios de ingeniería de software aplicados al contexto de la documentación.

---

## 1. El Problema que se Está Resolviendo

El SENA a nivel nacional tiene un ecosistema de software complejo. No es una sola aplicación, sino un conjunto de **procesos institucionales interconectados** que abarcan desde cómo se diseña un programa de formación hasta cómo un aprendiz sube una evidencia de su proyecto formativo.

Si cada equipo, centro o regional documenta a su manera, sin estructura ni control de versiones, ocurre lo siguiente:

| Síntoma sin arquitectura | Consecuencia |
|--------------------------|-------------|
| Cada desarrollador guarda sus documentos en carpetas propias | Imposible saber qué está vigente y qué está desactualizado |
| Se mezclan reglas de negocio con código técnico en el mismo documento | El diseñador no puede entender el documento del desarrollador y viceversa |
| No hay historial de por qué se tomó una decisión | Si un técnico se va, el conocimiento se pierde |
| No existen revisiones formales antes de publicar documentación | Se puede publicar información incorrecta como si fuera oficial |
| No hay relación entre los requisitos del SENA y los servicios de software | No hay manera de auditar si el software realmente cumple lo que prometió |

La arquitectura documental de este repositorio fue diseñada para **resolver todos esos problemas** de raíz.

---

## 2. La Solución: Estructura en Capas del `00` al `15`

En lugar de guardar todo en una sola carpeta, el repositorio está organizado en **16 secciones temáticas**, cada una con una responsabilidad clara y bien delimitada. Esto se conoce en ingeniería de software como **separación de responsabilidades (Separation of Concerns)**.

```text
design-software-docs-main/
│
├── 00-governance/          ← Reglas de cómo se trabaja el repositorio
├── 01-context/             ← Por qué existe el sistema y qué necesita el SENA
├── 02-domain/              ← Las reglas de negocio del SENA (independiente del código)
├── 03-product/             ← La visión del producto, el roadmap y el backlog
├── 04-requirements/        ← Requisitos funcionales y no funcionales
├── 05-architecture/        ← Diseño del sistema, decisiones técnicas y diagramas
├── 06-data/                ← Modelos de datos, migraciones y persistencia
├── 07-api/                 ← Contratos de API y lineamientos de integración
├── 08-uml/                 ← Diagramas UML en fuente editable y exportaciones
├── 09-microservices/       ← Documentación individual de cada microservicio
├── 10-devops/              ← Setup local, CI/CD y configuración de entornos
├── 11-quality/             ← Estrategias de pruebas y calidad del software
├── 12-ux-ui/               ← Design system, prototipos y flujos de usuario
├── 13-operations/          ← Observabilidad, alertas e incidentes
├── 14-training/            ← Manuales, guías y material de onboarding
├── 15-project-control/     ← Riesgos, dependencias y trazabilidad general
│
└── 99-archive/             ← Documentos históricos y decisiones antiguas
```

**Cada carpeta tiene una única razón de ser.** Esto significa que cuando alguien necesita información, sabe exactamente dónde buscarla. No hay que adivinar ni preguntar a nadie.

---

## 2.1 ¿Qué va en cada carpeta y para qué sirve?

Esta sección explica de forma concreta qué tipo de documentos se crean dentro de cada carpeta, qué significa cada una y a qué módulos o microservicios del sistema le aporta.

---

### 📁 `00-governance/` — Las Reglas del Juego del Repositorio

**¿Qué significa?** Es la carpeta que define cómo se trabaja dentro del repositorio. No habla del SENA ni del software, habla de cómo el equipo de desarrollo gestiona los propios documentos.

**¿Qué se mete aquí?**
- Las convenciones de Git: cómo se nombran las ramas, cómo se escriben los commits
- La estrategia de ramas: el flujo de `architecture-documentation-dev → dev → ... → main`
- La matriz de aprobaciones: quién revisa qué antes de publicar
- Las reglas de seguridad documental: qué información nunca debe subirse al repositorio
- Los criterios de "listo para revisar" y "listo para publicar" (Definition of Ready / Done)

**¿A qué módulos le sirve?** A **todos**. Estas reglas aplican para todos los equipos sin excepción. Si alguien de `horario-api` quiere subir documentación, consulta esta carpeta para saber cómo hacerlo correctamente.

---

### 📁 `01-context/` — El "Por Qué" del Sistema

**¿Qué significa?** Aquí se explica el contexto institucional del proyecto: por qué el SENA decidió construir este sistema, cuál es la necesidad real, a quiénes va a beneficiar y cuál es el alcance geográfico e institucional.

**¿Qué se mete aquí?**
- El contexto institucional del SENA a nivel nacional
- El problema o necesidad que motiva el desarrollo del sistema
- Los actores externos e internos involucrados (quiénes son los beneficiarios)
- Los límites del sistema: qué está adentro y qué está afuera del alcance

**¿A qué módulos le sirve?** A todos, especialmente a `organizacion-api` (para entender la estructura institucional), a `aprendiz-api` e `instructor-api` (para entender quiénes son los usuarios) y a `integracion-sena-api` (para entender con qué sistemas externos debe conectarse).

---

### 📁 `02-domain/` — Las Reglas de Negocio del SENA

**¿Qué significa?** Es la carpeta más importante para entender el sistema desde el punto de vista institucional. Aquí se documentan los procesos reales del SENA escritos en lenguaje de negocio, sin mezclarlos con código ni tecnología.

**¿Qué se mete aquí?**
- Un archivo por cada subdominio funcional (ej. `05-planeacion-horaria.md`)
- Las reglas de negocio: "un instructor no puede dictar dos fichas al mismo tiempo"
- Los eventos de negocio: "cuando una ficha abre, el sistema notifica a los instructores asignados"
- Los glosarios de términos institucionales del SENA
- Las relaciones entre subdominios: cómo el currículo afecta a las fichas, cómo las fichas afectan a los horarios

**¿A qué módulos le sirve?**
| Microservicio | Subdominio de negocio que consulta |
|--------------|-----------------------------------|
| `horario-api` | Planeación horaria |
| `ficha-api` | Ejecución de formación |
| `aprendiz-api` | Comunidad formativa |
| `instructor-api` | Comunidad formativa |
| `ambiente-api` | Recursos académicos |
| `avance-aprendiz-api` | Avance y evidencias |
| `proyecto-formativo-api` | Proyectos formativos |
| `reporte-api` | Reportes y documentos |
| `notificacion-api` | Seguimiento y alertas |
| `auditoria-api` | Gobierno y auditoría |
| `integracion-sena-api` | Integraciones SENA |

---

### 📁 `03-product/` — La Visión y Hoja de Ruta del Producto

**¿Qué significa?** Aquí se documenta el producto de software desde la perspectiva del dueño del producto (Product Owner): qué se va a construir, en qué orden de prioridad y cuándo.

**¿Qué se mete aquí?**
- La visión general del producto (el objetivo final del sistema)
- El roadmap o hoja de ruta (qué se construye en qué etapa del proyecto)
- El backlog de alto nivel (lista priorizada de funcionalidades)
- Las épicas y los historias de usuario de mayor nivel

**¿A qué módulos le sirve?** Sirve como guía de priorización para todos los microservicios. Si el roadmap dice que en la etapa 1 se construye `ficha-api` y `aprendiz-api`, el equipo de desarrollo sabe dónde enfocar sus esfuerzos de documentación primero.

---

### 📁 `04-requirements/` — Qué Debe Hacer el Sistema

**¿Qué significa?** Esta carpeta contiene los requisitos formales: las condiciones que el sistema de software debe cumplir sí o sí para ser aceptado por el SENA.

**¿Qué se mete aquí?**
- **Requisitos funcionales**: "El sistema debe permitir registrar la asistencia diaria de un aprendiz en una ficha" (REQ-012)
- **Requisitos no funcionales**: "El sistema debe responder en menos de 2 segundos el 95% de las peticiones bajo carga normal" (NFCR-001)
- Las restricciones de cumplimiento normativo del SENA
- Los criterios de aceptación de cada funcionalidad

**¿A qué módulos le sirve?** Cada microservicio debe poder demostrar que implementa al menos un requisito de esta carpeta. Por ejemplo:
- `REQ-012` → lo implementa `ficha-api`
- `REQ-025` → lo implementa `horario-api`
- `NFCR-001` → aplica a todos los microservicios que exponen una API

---

### 📁 `05-architecture/` — Cómo Está Construido el Sistema

**¿Qué significa?** Esta carpeta contiene el diseño técnico global del sistema: cómo están conectados los microservicios, qué patrones de arquitectura se usan y cuáles fueron las decisiones técnicas importantes y por qué se tomaron.

**¿Qué se mete aquí?**
- La vista general de arquitectura (cómo encajan todos los microservicios entre sí)
- El modelo de despliegue (en qué ambientes corre el sistema)
- Los aspectos transversales (seguridad, logging, manejo de errores)
- Los **ADRs** (Architecture Decision Records): registros de decisiones como "¿por qué usamos microservicios y no un monolito?"

**¿A qué módulos le sirve?** A todos, pero especialmente a los más críticos en cuanto a diseño: `horario-api` (motor de asignación), `integracion-sena-api` (orquestador de sistemas externos) y `auditoria-api` (aspecto transversal de trazabilidad).

---

### 📁 `06-data/` — Cómo se Guardan los Datos del Sistema

**¿Qué significa?** Aquí se documenta la estrategia de persistencia de datos a nivel global: qué tecnologías de base de datos se usan, cómo se migran los datos entre versiones y cómo se relacionan los datos de los diferentes microservicios.

**¿Qué se mete aquí?**
- El modelo de datos compartido o referencial (ej. el catálogo de centros de formación)
- Las estrategias de migración de datos entre versiones del sistema
- Las políticas de retención y eliminación de datos
- La estrategia de backup y recuperación

> ⚠️ **Importante:** El modelo de datos propio de cada microservicio NO va aquí, va dentro de `09-microservices/services/<servicio>/data-model.md`. Esta carpeta es para datos compartidos o decisiones globales de persistencia.

**¿A qué módulos le sirve?** Principalmente a `aprendiz-api`, `ficha-api`, `reporte-api` y `auditoria-api`, que comparten referencias a entidades comunes del SENA como centros, programas y fichas.

---

### 📁 `07-api/` — Cómo se Comunican los Servicios con el Mundo

**¿Qué significa?** Esta carpeta centraliza los estándares y contratos de todas las APIs del sistema. Es la referencia de cómo cualquier sistema externo (o microservicio interno) debe llamar a los servicios del SENA.

**¿Qué se mete aquí?**
- Los lineamientos de diseño de APIs (convenciones de URLs, formatos de fecha, paginación, errores)
- Los contratos OpenAPI/Swagger de cada microservicio (archivos `.yaml` o `.json`)
- Las políticas de autenticación y autorización (cómo funciona el token de acceso)
- Las guías de versionamiento de APIs

**¿A qué módulos le sirve?** A todos los microservicios que exponen una API, es decir, a los 14. El contrato de `horario-api`, por ejemplo, vive en `07-api/contracts/horario-api.yaml` y es la referencia que usa tanto el frontend como otros microservicios para saber cómo llamar al motor de horarios.

---

### 📁 `08-uml/` — Los Diagramas del Sistema

**¿Qué significa?** Aquí se guardan todos los diagramas técnicos del sistema en su **fuente editable** (archivos `.puml` o `.wsd`) y sus exportaciones (`.svg` o `.png`). Guardar solo la imagen sin la fuente editable es un error grave, porque nadie puede modificar el diagrama después.

**¿Qué se mete aquí?**
- Diagramas de secuencia (cómo fluye una petición entre microservicios)
- Diagramas de componentes (cómo se conectan los servicios)
- Diagramas de clases (la estructura de entidades del dominio)
- Diagramas de estados (ciclo de vida de una ficha, de un aprendiz, etc.)

**¿A qué módulos le sirve?** Los diagramas de secuencia son especialmente críticos para `horario-api` (proceso de asignación), `integracion-sena-api` (flujo de sincronización con SOFIA Plus) y `notificacion-api` (flujo de alertas).

---

### 📁 `09-microservices/` — La Documentación Técnica de Cada Servicio

**¿Qué significa?** Esta es la carpeta más grande y más detallada del repositorio. Contiene la documentación técnica individualizada de cada uno de los 14 microservicios del sistema. Es la que más consultan los desarrolladores en su día a día.

**¿Qué se mete aquí?**
- Una subcarpeta por cada microservicio real del sistema (nunca servicios ficticios)
- Dentro de cada subcarpeta, cinco archivos estándar siempre con el mismo nombre:
  - `README.md` → qué hace el servicio y cómo se relaciona con el dominio
  - `api-contract.md` → sus endpoints, peticiones y respuestas
  - `data-model.md` → sus tablas o colecciones de datos propias
  - `events.md` → los eventos que publica y consume
  - `runbook.md` → cómo se despliega, configura y opera

**¿A qué módulos le sirve?** Es la carpeta propia de todos los microservicios. Cada equipo de desarrollo tiene su subcarpeta asignada y trabaja ahí sin interferir con los demás.

---

### 📁 `10-devops/` — Cómo se Construye y Despliega el Sistema

**¿Qué significa?** Aquí se documenta todo lo relacionado con el ciclo de vida del software desde el código hasta el despliegue: cómo un desarrollador arranca el proyecto en su computador, cómo funciona el pipeline de integración continua y cómo se despliega en cada ambiente.

**¿Qué se mete aquí?**
- La guía de configuración local (`local-setup.md`): pasos para que un desarrollador nuevo pueda correr el proyecto
- La documentación del pipeline CI/CD (`ci-cd.md`): qué pasa cuando se hace un push al repositorio
- La descripción de ambientes (`environments.md`): diferencias entre `dev`, `staging`, `qa` y `main`

**¿A qué módulos le sirve?** Es crítico para todos los microservicios, pero especialmente útil para `integracion-sena-api` (que tiene dependencias externas complejas) y `auditoria-api` (que requiere configuración especial de logs).

---

### 📁 `11-quality/` — Cómo se Garantiza que el Sistema Funciona Bien

**¿Qué significa?** Esta carpeta documenta la estrategia de calidad del software: qué tipos de pruebas se hacen, cómo se revisa el código y cuáles son los criterios mínimos de calidad que debe cumplir cualquier cambio antes de llegar a producción.

**¿Qué se mete aquí?**
- La estrategia general de pruebas (unitarias, integración, end-to-end)
- Los criterios de code review (qué revisa un par antes de aprobar un PR)
- Los umbrales de cobertura de código aceptables
- Los criterios de aceptación funcional que valida el QA Lead

**¿A qué módulos le sirve?** A todos, pero es especialmente relevante para `horario-api` (lógica de asignación compleja), `avance-aprendiz-api` (juicios evaluativos con impacto en el aprendiz) y `reporte-api` (documentos oficiales que no pueden tener errores).

---

### 📁 `12-ux-ui/` — Cómo Se Ve y Se Siente el Sistema para el Usuario

**¿Qué significa?** Aquí se documenta el diseño visual e interactivo del sistema: los colores, tipografías, componentes reutilizables, flujos de navegación y prototipos de las pantallas.

**¿Qué se mete aquí?**
- El design system: paleta de colores, tipografías y componentes UI
- Los wireframes o mockups de las pantallas principales
- Los flujos de usuario: cómo navega un aprendiz, cómo navega un instructor
- Las guías de accesibilidad

**¿A qué módulos le sirve?** Principalmente al frontend que consume los microservicios. Dentro del ecosistema de servicios, le aporta contexto a `aprendiz-api`, `instructor-api` y `ficha-api`, que son los que más interacción directa tienen con el usuario final.

---

### 📁 `13-operations/` — Cómo Se Monitorea el Sistema en Producción

**¿Qué significa?** Esta carpeta documenta cómo se vigila que el sistema esté funcionando bien cuando ya está en producción: qué alertas existen, cómo se responde ante incidentes y cómo se recupera el sistema ante una falla.

**¿Qué se mete aquí?**
- La estrategia de observabilidad (logs, métricas y trazas distribuidas)
- Los procedimientos de manejo de incidentes (qué hacer si el sistema cae)
- La estrategia de backup y recuperación de datos
- Los runbooks operacionales de los servicios más críticos

**¿A qué módulos le sirve?** Es crítico para `auditoria-api` (que es la fuente de verdad de todos los eventos del sistema), `notificacion-api` (que tiene alta frecuencia de uso) y `horario-api` (que es el motor central del sistema).

---

### 📁 `14-training/` — Cómo se Capacita a los Nuevos Integrantes

**¿Qué significa?** Esta carpeta contiene el material de onboarding y formación técnica para cualquier persona que llegue nueva al equipo: desarrolladores, instructores del SENA que van a usar el sistema o administradores.

**¿Qué se mete aquí?**
- El manual del desarrollador: cómo configurar el ambiente, cómo hacer un PR, cómo deployar
- Las guías de usuario final: cómo usa el sistema un aprendiz, un instructor o un coordinador
- Los videos o tutoriales de las funcionalidades principales
- Los FAQ (preguntas frecuentes) del proyecto

**¿A qué módulos le sirve?** Sirve a todos, especialmente para reducir el tiempo que tarda un nuevo desarrollador en ser productivo con `ficha-api`, `horario-api` o `aprendiz-api`, que son los módulos más usados y más complejos de entender.

---

### 📁 `15-project-control/` — El Control General del Proyecto

**¿Qué significa?** Es la carpeta que mantiene el registro de salud del proyecto: qué preguntas están abiertas, qué riesgos existen, qué dependencias hay entre módulos y cómo se mapean los requisitos del SENA con el software construido.

**¿Qué se mete aquí?**
- La **Matriz de Trazabilidad**: la tabla que conecta cada requisito del SENA (REQ-XXX) con el microservicio que lo implementa
- El registro de preguntas abiertas (`open-questions.md`): decisiones técnicas aún sin resolver
- El registro de riesgos y dependencias entre módulos
- El backlog técnico del proyecto

**¿A qué módulos le sirve?** Es el documento de cierre de ciclo para todos los microservicios. Si alguien pregunta "¿este sistema cumple el requisito REQ-035 del SENA?", la respuesta está en la matriz de trazabilidad de esta carpeta, que apunta directamente a `avance-aprendiz-api` o al servicio que corresponda.

---

### 📁 `99-archive/` — La Memoria Histórica del Proyecto

**¿Qué significa?** Aquí van los documentos que ya no están vigentes pero que no se pueden borrar porque tienen valor histórico. No es una papelera; es un archivo institucional.

**¿Qué se mete aquí?**
- Documentos que fueron reemplazados por versiones más actualizadas
- Decisiones técnicas antiguas que quedaron obsoletas
- Versiones anteriores de diseños o prototipos que ya no se usan

**¿A qué módulos le sirve?** A todos en caso de auditoría. Si algún día el SENA pregunta "¿qué diseño tenía el módulo de horarios en su primera versión?", la respuesta está aquí.

---

## 3. Los 12 Subdominios del SENA y Dónde Viven

Un **subdominio** es un área funcional del negocio del SENA. Es la representación de un proceso real de la institución, escrito en lenguaje de negocio (no técnico). Todos los subdominios se documentan en la carpeta `02-domain/`.

La razón de usar `02-domain/` para esto y no `09-microservices/` es fundamental: **el negocio no cambia por que cambie la tecnología**. Si mañana se decide migrar el microservicio de horarios de Java a Node.js, las reglas de negocio de cómo se asignan los horarios siguen siendo exactamente las mismas. Al tenerlas separadas, el cambio tecnológico no borra ni altera el conocimiento institucional.

| # | Subdominio | Qué documenta en `02-domain/` |
|---|------------|-------------------------------|
| 1 | **Organización académica** | Cómo está estructurado el SENA: centros, sedes, áreas, coordinaciones y jerarquía nacional. Define quién reporta a quién y cómo se agrupa la institución. |
| 2 | **Currículo** | Los programas de formación, las competencias que definen, los resultados de aprendizaje (RAP) y los niveles de formación (Técnico, Tecnólogo, Especialización). |
| 3 | **Comunidad formativa** | Los actores del sistema: aprendices, instructores, coordinadores, asesores empresariales y egresados. Sus perfiles, roles dentro del sistema y relaciones entre sí. |
| 4 | **Recursos académicos** | Los ambientes de formación (talleres, aulas, laboratorios), los materiales didácticos, la maquinaria y las herramientas o software que se usan en la formación. |
| 5 | **Planeación horaria** | Las reglas de negocio de cómo se arma un horario: disponibilidad de instructores, asignación de ambientes, cruce de fichas, restricciones y conflictos posibles. |
| 6 | **Ejecución de formación** | El control operativo de las fichas: apertura, asistencias, guías de aprendizaje, planeación pedagógica y gestión del día a día de la formación. |
| 7 | **Proyectos formativos** | El ciclo de vida de los proyectos formativos: su formulación, vinculación con competencias, seguimiento y entrega final del aprendiz. |
| 8 | **Avance y evidencias** | Los juicios evaluativos, la carga de evidencias por parte del aprendiz, las calificaciones de los instructores y el portafolio de aprendizaje. |
| 9 | **Seguimiento y alertas** | Los mecanismos del SENA para detectar riesgos: alertas de proyectos y fichas, y Notificaciones de proyectos y fichas en riesgo. |
| 10 | **Reportes y documentos** | La generación de documentos oficiales: certificados, constancias de estudio, reportes de deserción, estadísticas nacionales y reportes para directivos. |
| 11 | **Integraciones SENA** | Las fronteras con los sistemas externos: cómo se comunica el sistema con **SOFIA Plus**, **BETOWA**, el Portal de Empleo SENA, el Sistema de Bienestar, entre otros. |
| 12 | **Gobierno y auditoría** | El control interno: trazabilidad de accesos al sistema, registro de transacciones críticas, políticas de retención de datos y cumplimiento normativo. |

---

## 4. Los 14 Microservicios y Dónde Viven

Un **microservicio** es la unidad técnica de software que implementa las reglas de uno o más subdominios. Cada microservicio tiene su propia carpeta dentro de `09-microservices/services/` y contiene los mismos archivos estándar, lo que garantiza que cualquier desarrollador, sin importar qué servicio le asignen, sabe exactamente dónde encontrar cada tipo de información.
Propósito

Esta sección documenta los servicios candidatos identificados durante el diseño de la arquitectura del sistema nacional SENA. Su objetivo es definir responsabilidades, límites funcionales, contratos, eventos y dependencias de cada servicio antes de la implementación.

Estructura
09-microservices/
│
├── README.md
├── service-catalog.md
├── communication-patterns.md
│
└── services/
    ├── organizacion-api/
    ├── programa-formacion-api/
    ├── diseno-curricular-api/
    ├── ficha-api/
    ├── aprendiz-api/
    ├── instructor-api/
    ├── ambiente-api/
    ├── horario-api/
    ├── proyecto-formativo-api/
    ├── avance-aprendiz-api/
    ├── reporte-api/
    ├── notificacion-api/
    ├── integracion-sena-api/
    └── auditoria-api/
Catálogo de Servicios
Servicio	Subdominio Asociado	Responsabilidad Principal
organizacion-api	Organización Académica	Gestionar la estructura organizacional del SENA.
programa-formacion-api	Currículo	Administrar programas de formación.
diseno-curricular-api	Currículo	Gestionar competencias, RAP y diseños curriculares.
ficha-api	Comunidad Formativa	Administrar fichas de formación.
aprendiz-api	Comunidad Formativa	Gestionar información del aprendiz.
instructor-api	Comunidad Formativa	Gestionar información del instructor.
ambiente-api	Recursos Académicos	Administrar ambientes de formación.
horario-api	Planeación Horaria	Gestionar programación y disponibilidad.
proyecto-formativo-api	Proyectos Formativos	Gestionar proyectos formativos.
avance-aprendiz-api	Avance y Evidencias	Registrar avances y evidencias.
reporte-api	Reportes y Documentos	Generar reportes institucionales.
notificacion-api	Seguimiento y Alertas	Gestionar comunicaciones y alertas.
integracion-sena-api	Integraciones SENA	Integrar sistemas institucionales externos.
auditoria-api	Gobierno y Auditoría	Gestionar trazabilidad y auditoría.
```text
09-microservices/
│
├── service-catalog.md          ← Índice global: lista todos los servicios, su estado y propietario
│
└── services/
    ├── organizacion-api/       ← Gestiona centros, sedes y estructura organizativa
    ├── programa-formacion-api/ ← Gestiona los programas y su versionamiento curricular
    ├── diseno-curricular-api/  ← Administra competencias, RAPs y las fichas del currículo
    ├── ficha-api/              ← Controla la apertura, estado y ciclo de vida de las fichas
    ├── aprendiz-api/           ← Gestiona el perfil, la matrícula y el estado del aprendiz
    ├── instructor-api/         ← Gestiona el perfil, la disponibilidad y la asignación del instructor
    ├── ambiente-api/           ← Administra la disponibilidad de aulas, talleres y laboratorios
    ├── horario-api/            ← Motor de asignación horaria y detección de conflictos
    ├── proyecto-formativo-api/ ← Gestiona el ciclo de vida del proyecto formativo del aprendiz
    ├── avance-aprendiz-api/    ← Registra juicios, evidencias y calificaciones
    ├── reporte-api/            ← Genera documentos oficiales y estadísticas institucionales
    ├── notificacion-api/       ← Envía alertas, recordatorios y avisos a los actores del sistema
    ├── integracion-sena-api/   ← Orquesta la comunicación con SOFIA Plus, BETOWA y otros sistemas
    └── auditoria-api/          ← Registra y expone el log de transacciones para auditoría interna
```

### ¿Qué contiene la carpeta de cada microservicio?

Todos siguen exactamente la misma estructura interna:

| Archivo | Qué documenta |
|---------|---------------|
| `README.md` | Propósito del servicio, bounded context, subdominio asociado, propietario, repositorio de código y dependencias |
| `api-contract.md` | Descripción de los endpoints, los request/response y los códigos de error del servicio |
| `data-model.md` | El modelo de datos propio (tablas o colecciones) que gestiona ese microservicio |
| `events.md` | Los eventos de dominio que publica y los que consume desde otros servicios |
| `runbook.md` | Procedimiento de despliegue, variables de entorno necesarias, rollback y troubleshooting |

Esta estandarización es la que garantiza que **el conocimiento no depende de la persona**, sino del repositorio.

---

## 4.1 Guía de Interacciones y Dependencias entre Servicios

Para que los equipos de desarrollo y arquitectura entiendan cómo interactúan los microservicios en el ecosistema nacional, estos se clasifican en tres categorías lógicas de dependencia. Ningún servicio trabaja aislado; todos cooperan siguiendo esta jerarquía:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    SERVICIOS TRANSVERSALES Y DE SOPORTE                 │
│      (reporte-api)    (notificacion-api)    (integracion-sena-api)      │
└────────────────────┬───────────────────────────────────┬────────────────┘
                     │ consume datos                     │ integra / notifica
                     ▼                                   ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                    SERVICIOS CORE (ORQUESTADORES)                       │
│     (horario-api)    (ficha-api)    (proyecto-formativo-api)            │
└────────────────────┬────────────────────────────────────────────────────┘
                     │ requiere datos maestros
                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                    SERVICIOS FUNDACIONALES (BASE)                       │
│  (organizacion-api)    (aprendiz-api)    (instructor-api)   (ambiente-api)│
└─────────────────────────────────────────────────────────────────────────┘
```

### 1. Servicios Fundacionales (Base de Datos Maestros)
Son los cimientos del sistema. Almacenan la información primaria del SENA y **no dependen de otros microservicios** para operar. En cambio, todos los demás servicios consumen su información.

- **`organizacion-api`**: Define los Centros de Formación, Sedes y Regionales.
- **`programa-formacion-api`** y **`diseno-curricular-api`**: Definen qué competencias y RAPs (Resultados de Aprendizaje) existen a nivel nacional.
- **`aprendiz-api`** e **`instructor-api`**: Registran las hojas de vida, perfiles y estados de las personas.
- **`ambiente-api`**: Administra la existencia y características físicas de las aulas, laboratorios y talleres.

---

### 2. Servicios Core (Orquestadores de Proceso)
Son los servicios que implementan la lógica viva de la formación. Para funcionar, **requieren consumir datos maestros de los servicios fundacionales**:

- **`ficha-api` (Depende de: Currículo, Organización y Personas)**
  - *¿Por qué?* Para abrir una Ficha de formación, necesita saber qué programa curricular sigue (`programa-formacion-api`), a qué centro pertenece (`organizacion-api`), qué aprendiz se matricula (`aprendiz-api`) y qué instructor técnico lidera la ficha (`instructor-api`).
- **`horario-api` (Depende de: Ficha, Instructor y Ambiente)**
  - *¿Por qué?* Para agendar una sesión, requiere verificar que la Ficha esté activa (`ficha-api`), que el instructor tenga disponibilidad horaria (`instructor-api`) y que el laboratorio físico no esté reservado por otro grupo (`ambiente-api`).
- **`proyecto-formativo-api` (Depende de: Ficha y Diseño Curricular)**
  - *¿Por qué?* Asocia un proyecto a una ficha específica (`ficha-api`) y valida que las entregas del proyecto apunten a cumplir las competencias curriculares (`diseno-curricular-api`).
- **`avance-aprendiz-api` (Depende de: Ficha y Proyecto Formativo)**
  - *¿Por qué?* Permite calificar los RAPs de los aprendices matriculados en una ficha (`ficha-api`) con base en el cumplimiento de las fases de su proyecto formativo (`proyecto-formativo-api`).

---

### 3. Servicios Transversales (Soporte e Integración Global)
Son utilidades que operan de forma horizontal en todo el sistema. Consumen eventos o datos de múltiples servicios para realizar tareas automatizadas o de auditoría.

- **`notificacion-api` (Escucha a: Horarios, Fichas y Avances)**
  - *¿Por qué?* Envía correos o alertas automáticas cuando `horario-api` cambia una clase, o cuando `avance-aprendiz-api` detecta que un aprendiz está en riesgo de deserción por notas.
- **`reporte-api` (Consume de: Todos los servicios)**
  - *¿Por qué?* Para generar un certificado digital de estudio, necesita jalar la información de la persona (`aprendiz-api`), el programa cursado (`programa-formacion-api`), la ficha finalizada (`ficha-api`) y los juicios aprobados (`avance-aprendiz-api`).
- **`integracion-sena-api` (Orquesta la sincronización externa)**
  - *¿Por qué?* Sirve de puente con **SOFIA Plus** y **BETOWA**. Recibe la información externa y la distribuye llamando a las APIs internas correspondientes (por ejemplo, registrar una matrícula nueva en `aprendiz-api`).
- **`auditoria-api` (Escucha eventos de: Todos los servicios)**
  - *¿Por qué?* Recibe de forma asíncrona un registro (log) de cada transacción importante que ocurra en el sistema (ej. creación de un horario, asignación de una calificación) para garantizar que todo sea auditable históricamente.

---

## 5. El Flujo de Trazabilidad: De la Necesidad al Servicio

La trazabilidad es la capacidad de responder la pregunta: **"¿Este software realmente hace lo que el SENA necesitaba?"**. En esta arquitectura, esa pregunta se puede responder en cuatro pasos:

```
[04-requirements/]         [02-domain/]              [09-microservices/]      [07-api/]
Requisito del SENA  ──►  Regla de negocio  ──►   Microservicio que     ──►  Contrato técnico
REQ-015: El sistema       del subdominio de         implementa esa regla      que define cómo
debe permitir             Planeación Horaria         horario-api               se llama la API
asignar horarios          (sin restricciones         README.md apunta          para hacer eso
a instructores.           técnicas)                  a REQ-015                 api-contract.md
```

Y todo ese camino queda registrado en `15-project-control/TRACEABILITY-MATRIX.md`, que es el documento donde se consolida la relación entre los requisitos del SENA y los servicios de software que los satisfacen.

---

## 6. Por Qué la Estrategia de Ramas Refuerza la Calidad

El modelo de ramas no es decorativo. Tiene un propósito funcional directo sobre la calidad de la documentación:

```
architecture-documentation-dev
    ↓ (Un borrador pasa por revisión del equipo de arquitectura)
dev
    ↓ (El documento integrado pasa por revisión de múltiples secciones)
architecture-documentation-staging
    ↓
staging
    ↓ (Validación funcional: ¿el documento cumple los requisitos?)
architecture-documentation-qa
    ↓
qa
    ↓ (Aprobación final antes de publicar)
architecture-documentation-main
    ↓
main  ← Solo llega documentación que pasó por TODAS las validaciones anteriores
```

Esto significa que **cualquier documento que esté en `main` fue revisado, al menos, tres veces por actores distintos** antes de llegar ahí. Es el equivalente documental de un pipeline de CI/CD de software.

---

## 7. ¿Qué Pasa Cuando el Sistema Crece?

El sistema del SENA va a crecer. Van a surgir nuevos requisitos, nuevos sistemas y nuevas integraciones. Esta arquitectura está diseñada para absorber ese crecimiento sin generar caos.

### Escenario 1: Se crea un nuevo subdominio
> El SENA decide que necesita documentar la gestión de **Bienestar del Aprendiz** como un subdominio propio.

**Acción:** Se crea el archivo `02-domain/13-bienestar-aprendiz.md`.  
**Impacto en el resto:** Ninguno. Las demás secciones no se tocan.

---

### Escenario 2: Se necesita un nuevo microservicio
> El equipo de desarrollo decide que `notificacion-api` debe dividirse en `notificacion-email-api` y `notificacion-push-api` para escalar de forma independiente.

**Acción:** Se crea `09-microservices/services/notificacion-email-api/` y `09-microservices/services/notificacion-push-api/` usando la plantilla de `_template/`. Se actualiza el catálogo `service-catalog.md`.  
**Impacto en el resto:** Solo se agrega una fila en el catálogo. Las reglas de negocio en `02-domain/` no cambian.

---

### Escenario 3: Se agrega una integración con un nuevo sistema externo
> El SENA integra un nuevo sistema de pagos de bienestar.

**Acción:** Se documenta el contrato en `07-api/contracts/` y la integración en `11-integraciones/` dentro de `02-domain/`. Se crea el servicio `pago-bienestar-api` en `09-microservices/`.  
**Impacto en el resto:** Ninguno fuera de las secciones involucradas.

---

### Escenario 4: Cambia una decisión técnica importante
> Se decide migrar la base de datos del módulo de horarios de PostgreSQL a MongoDB.

**Acción:** Se actualiza `09-microservices/services/horario-api/data-model.md` y se crea un nuevo ADR en `05-architecture/decisions/records/ADR-NNN-migracion-horarios-mongodb.md`.  
**Impacto en el resto:** El subdominio en `02-domain/` no cambia. El requisito en `04-requirements/` no cambia. Solo cambia el documento técnico del servicio y queda registrada la decisión con su justificación para la historia.

---

## 8. Resumen Ejecutivo: Los 5 Pilares de la Calidad

| Pilar | Descripción | Beneficio |
|-------|-------------|-----------|
| **Separación de Responsabilidades** | Negocio en `02-domain/`, código en `09-microservices/`, contratos en `07-api/` | El cambio en una capa no destruye las otras |
| **Estandarización por Servicio** | Todos los microservicios tienen la misma estructura interna | Cualquier desarrollador entiende cualquier servicio en minutos |
| **Trazabilidad Completa** | Cada requisito se conecta con el subdominio, el servicio y el contrato de API | Se puede auditar si el software cumple lo prometido |
| **Control de Calidad por Ambientes** | La documentación pasa por `dev → staging → qa → main` | Solo llega a producción lo que fue validado |
| **Modularidad Extrema** | Crear, eliminar o modificar un servicio no afecta a los demás | El sistema puede crecer indefinidamente sin crear desorden |

---

## 9. Conclusión

Esta arquitectura no es solo un conjunto de carpetas bien nombradas. Es la implementación de principios de ingeniería de software ampliamente validados —como la separación de responsabilidades, el bajo acoplamiento, la alta cohesión y la trazabilidad de requisitos— aplicados al problema específico de documentar un sistema distribuido a escala nacional.

> **Un evaluador que pregunta "¿por qué esta arquitectura?"** puede leer este documento y encontrar la respuesta con datos concretos, ejemplos prácticos y comparaciones de escenarios reales de crecimiento.

> **Un desarrollador nuevo que se incorpora al proyecto** puede leer este documento y entender en 10 minutos cómo encaja su trabajo dentro del ecosistema completo del SENA.

> **Un coordinador o directivo que supervisa el proyecto** puede leer este documento y tener la certeza de que el repositorio tiene el nivel de rigor necesario para soportar un sistema crítico de alcance nacional.

---

## Referencias Cruzadas

- [`00-governance/branch-strategy.md`](../00-governance/branch-strategy.md) — Estrategia de ramas y flujo de promoción
- [`02-domain/`](../02-domain/) — Documentación de subdominios de negocio
- [`04-requirements/`](../04-requirements/) — Requisitos funcionales y no funcionales
- [`07-api/`](../07-api/) — Contratos de API y lineamientos de integración
- [`09-microservices/service-catalog.md`](../09-microservices/service-catalog.md) — Catálogo global de microservicios
- [`15-project-control/`](../15-project-control/) — Matriz de trazabilidad y control del proyecto
- [`decisions/records/ADR-001-documentation-branching-model.md`](./decisions/records/ADR-001-documentation-branching-model.md) — Decisión sobre el modelo de ramas
- [`decisions/records/ADR-002-repository-architecture-justification.md`](./decisions/records/ADR-002-repository-architecture-justification.md) — Decisión formal de arquitectura documental
