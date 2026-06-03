# Módulo 9: Monitoreo y Analítica de Proyectos Formativos

## 1. Introducción

Dentro de la arquitectura institucional del SENA, el módulo **Monitoreo y Analítica de Proyectos Formativos** tiene como propósito proporcionar visibilidad operativa, académica y estratégica sobre el comportamiento de los proyectos formativos durante su ciclo de ejecución.

Este módulo no administra proyectos formativos, fichas, aprendices, instructores ni diseños curriculares, ya que dicha información es gestionada por otros módulos institucionales.

Su función principal consiste en consolidar información proveniente de diferentes dominios del sistema para generar seguimientos, indicadores, alertas y métricas que permitan evaluar el avance del proceso formativo desde el nivel aprendiz hasta el nivel nacional.

---

## 2. Objetivo del Módulo

Monitorear el desempeño y evolución de los proyectos formativos del SENA mediante la consolidación de información académica, operativa e institucional que permita:

* Evaluar el avance del proceso formativo.
* Identificar riesgos y retrasos.
* Generar indicadores estratégicos.
* Emitir alertas tempranas.
* Facilitar la toma de decisiones.
* Mantener trazabilidad histórica de la ejecución formativa.

---

## 3. Alcance Nacional

El módulo debe proporcionar información consolidada para todas las regionales y centros de formación del país.

Debe permitir monitorear:

* Proyectos formativos activos.
* Fichas en ejecución.
* Registros.
* Programas técnicos y tecnológicos.
* Centros de formación.
* Regionales del SENA.

La información debe estar disponible para análisis a nivel:

* Aprendiz.
* Ficha.
* Programa.
* Centro.
* Regional.
* Nacional.

---

## 4. Problema de Negocio que Resuelve

Actualmente la información sobre el avance real de los proyectos formativos suele encontrarse distribuida en múltiples sistemas, reportes y registros operativos.

Esto dificulta responder preguntas institucionales como:

* ¿Qué tan avanzado se encuentra un proyecto formativo?
* ¿Qué fichas presentan retrasos?
* ¿Qué programas tienen mejor desempeño?
* ¿Qué regionales presentan mayores riesgos?
* ¿Qué resultados de aprendizaje muestran menor cumplimiento?

El módulo centraliza la información de monitoreo para generar conocimiento institucional y apoyar la toma de decisiones.

---

## 5. Visión Funcional

El módulo debe entenderse como un sistema de monitoreo del proceso formativo y no como un gestor de tareas o entregables.

Su objetivo es responder preguntas estratégicas sobre el comportamiento y desempeño de los proyectos formativos.

---

## 6. Niveles de Monitoreo

### 6.1 Nivel Aprendiz

Permite conocer:

* Participación en el proyecto.
* Cumplimiento de actividades asignadas.
* Evidencias asociadas.
* Avance del proceso formativo.
* Cumplimiento de resultados de aprendizaje.

**Pregunta que responde:**

> ¿El aprendiz está avanzando adecuadamente en su proceso de formación?

---

### 6.2 Nivel Ficha

Permite conocer:

* Estado general del proyecto.
* Nivel de avance.
* Cumplimiento de hitos.
* Riesgos identificados.
* Tendencia de ejecución.

**Pregunta que responde:**

> ¿La ficha está cumpliendo adecuadamente el desarrollo de su proyecto formativo?

---

### 6.3 Nivel Programa

Permite conocer:

* Programas con mejor desempeño.
* Programas con retrasos recurrentes.
* Programas con mayor cantidad de observaciones.
* Tendencias de cumplimiento.

---

### 6.4 Nivel Centro

Permite conocer:

* Proyectos activos.
* Proyectos retrasados.
* Proyectos finalizados.
* Cumplimiento general del centro.

---

### 6.5 Nivel Regional

Permite conocer:

* Comportamiento de proyectos por regional.
* Comparativos entre centros.
* Indicadores de ejecución regional.

---

### 6.6 Nivel Nacional

Permite conocer:

* Estado consolidado de los proyectos formativos del país.
* Cumplimiento institucional.
* Riesgos nacionales.
* Tendencias estratégicas.

---

## 7. Seguimiento Institucional

### Concepto de Seguimiento

Un seguimiento no representa una simple observación.

Representa una fotografía institucional del estado del proyecto en un momento determinado.

### Información Registrada

* Proyecto formativo.
* Ficha.
* Programa.
* Centro.
* Regional.
* Fecha del seguimiento.
* Estado actual.
* Porcentaje de avance.
* Nivel de riesgo.
* Cumplimiento de actividades.
* Cumplimiento de RAP.
* Observaciones relevantes.
* Evidencias asociadas.

### Ejemplo

**Seguimiento #45**

| Campo                       | Valor                                         |
| --------------------------- | --------------------------------------------- |
| Proyecto                    | ADSO-2026                                     |
| Ficha                       | 2978451                                       |
| Regional                    | Huila                                         |
| Centro                      | Gestión y Desarrollo Sostenible Surcolombiano |
| Estado                      | En ejecución                                  |
| Avance                      | 68%                                           |
| Riesgo                      | Medio                                         |
| Cumplimiento de actividades | 72%                                           |
| Cumplimiento RAP            | 65%                                           |
| Observaciones registradas   | 3                                             |

---

## 8. Gestión de Evidencias

Permite asociar soportes que respalden el estado reportado en cada seguimiento.

### Tipos de Evidencia

* Documentos PDF.
* Archivos Word.
* Hojas de cálculo.
* Enlaces externos.

### Objetivos

* Soportar auditorías.
* Validar seguimientos.
* Mantener trazabilidad.


---

## 9. Gestión de Riesgos

Permite identificar situaciones que puedan afectar el cumplimiento del proyecto formativo.

### Niveles de Riesgo

* Bajo.
* Medio.
* Alto.
* Crítico.

### Ejemplos

* Bajo avance.
* Incumplimiento de hitos.
* Falta de evidencias.
* Retrasos recurrentes.
* Bajo cumplimiento de RAP.

---

## 10. Sistema de Alertas y Notificaciones

Las notificaciones no son únicamente mensajes informativos.

Son mecanismos de gestión institucional orientados a activar acciones correctivas.

### Alerta Académica

El proyecto presenta retraso superior al porcentaje permitido.

**Destinatarios:**

* Instructor.
* Coordinador.

---

### Alerta de Cumplimiento

Existe incumplimiento de actividades programadas.

**Destinatarios:**

* Instructor.
* Responsable académico.

---

### Alerta de Riesgo

La ficha presenta bajo desempeño o bajo cumplimiento de resultados de aprendizaje.

**Destinatarios:**

* Coordinador.
* Líder académico.

---

### Alerta Gerencial

Incremento significativo de proyectos retrasados en una regional.

**Destinatarios:**

* Directivos.
* Dirección Regional.

---

## 11. Entidades del Módulo

### SeguimientoProyecto

Representa el estado consolidado de un proyecto en un momento determinado.

#### Atributos

* id
* proyecto_formativo_id
* ficha_id
* fecha_seguimiento
* porcentaje_avance
* porcentaje_cumplimiento_actividades
* porcentaje_cumplimiento_rap
* nivel_riesgo
* estado_proyecto
* observaciones
* registrado_por

---

### EvidenciaSeguimiento

#### Atributos

* id
* seguimiento_id
* nombre_archivo
* url_archivo
* tipo_evidencia
* fecha_carga

---

### RiesgoProyecto

#### Atributos

* id
* seguimiento_id
* descripcion
* nivel_riesgo
* estado

---

### AlertaProyecto

#### Atributos

* id
* seguimiento_id
* tipo_alerta
* destinatario
* mensaje
* fecha_generacion
* estado

---

## 12. Relación con Otros Módulos

### Módulo 5 – Programas de Formación

Consume:

* Diseño curricular.
* Competencias.
* RAP.

### Módulo 6 – Oferta y Programas

Consume:

* Fichas.
* Proyecto formativo.
* Matrículas.

### Módulo 7 – Actores

Consume:

* Aprendices.
* Instructores.
* Coordinadores.

### Módulo 8 – Horarios

Consume:

* Programación académica.
* Eventos programados.
* Cronogramas.

---

## 13. Arquitectura de Microservicios

### Monitoring Service

Responsable de:

* Seguimientos.
* Métricas.
* Consolidación de información.
* Estados de avance.

### Analytics Service

Responsable de:

* Indicadores.
* Reportes.
* Dashboards.
* Estadísticas institucionales.

### Risk Management Service

Responsable de:

* Riesgos.
* Alertas.
* Clasificación de criticidad.

### Notification Service

Responsable de:

* Notificaciones.
* Recordatorios.
* Alertas automáticas.

---

## 14. Indicadores Estratégicos

### Indicadores de Avance

* Avance promedio por programa.
* Avance promedio por centro.
* Avance promedio por regional.
* Avance promedio nacional.

### Indicadores de Cumplimiento

* Actividades cumplidas.
* Actividades pendientes.
* Entregables completados.
* Entregables vencidos.

### Indicadores Pedagógicos

* RAP alcanzados.
* RAP pendientes.
* Competencias fortalecidas.
* Competencias en riesgo.

### Indicadores de Riesgo

* Proyectos en riesgo.
* Fichas en riesgo.
* Programas en riesgo.
* Regionales en riesgo.

---

## 15. Valor Estratégico para el SENA

El módulo de Monitoreo y Analítica de Proyectos Formativos constituye una plataforma de inteligencia institucional que permite evaluar el comportamiento del proceso formativo en tiempo real.

Su propósito no es administrar proyectos, sino proporcionar visibilidad, control, seguimiento y analítica sobre la ejecución de los proyectos formativos del país, permitiendo monitorear el cumplimiento de competencias, resultados de aprendizaje y objetivos institucionales.

De esta manera se convierte en uno de los principales generadores de conocimiento estratégico dentro de la arquitectura del sistema.