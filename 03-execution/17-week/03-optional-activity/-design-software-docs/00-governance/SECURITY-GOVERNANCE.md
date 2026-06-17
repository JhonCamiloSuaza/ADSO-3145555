# Security Governance

> Estado: 🟢 Estable | Última actualización: 2026-06-17
> Autor: Arquitectura de Software SENA Nacional | Equipo: Seguridad / DevOps

## Propósito

Establecer a nivel conceptual las directrices de seguridad de la información para el repositorio documental del SENA, previniendo la exposición accidental de secretos y definiendo pautas de gobernanza de datos.

## Clasificación de Información Documental

La información dentro del repositorio se maneja bajo las siguientes clasificaciones conceptuales:

| Clasificación | Descripción | Ejemplos | Restricción |
|---------------|-------------|----------|------------|
| **Público** | Información abierta para consulta de cualquier equipo | Requisitos de negocio, diagramas de arquitectura general | Ninguna |
| **Interno** | Información técnica para consumo exclusivo del SENA | Decisiones de arquitectura detalladas (ADRs), catálogo de servicios | No divulgar fuera de la organización |
| **Confidencial** | Información sensible de diseño y lógica | Integraciones detalladas, diagramas de red | Acceso limitado a roles de desarrollo y arquitectura |

## Reglas de Documentación Sensible

### ❌ PROHIBIDO guardar en el repositorio

- Contraseñas, tokens de acceso, API keys o secretos reales.
- Direcciones IP privadas o nombres de hosts privados reales.
- Datos personales reales de aprendices, instructores o personal administrativo.
- Strings de conexión a bases de datos productivas.
- Claves privadas o certificados SSL reales.

### ✅ PERMITIDO utilizando datos de ejemplo (Mock Data)

- Estructuras de API genéricas y esquemas de datos.
- Políticas de autenticación y autorización generales.
- Parámetros de configuración abstractos.

### Marcado de Documentos con Clasificación Especial

Si un documento detalla configuraciones que requieren precauciones especiales:

```markdown
# [CLASIFICACIÓN] Título del Documento

> Clasificación: INTERNO / CONFIDENCIAL
> Acceso recomendado a: Roles técnicos autorizados
> Estado: Draft / Estable
```

---

## Control de Acceso Conceptual a la Documentación

### Acceso a nivel de ramas

El control de acceso conceptual se alinea con la jerarquía de ramas del repositorio:
- `main`: Representa el estado estable y publicado.
- `qa`: Representa el contenido validado funcionalmente.
- `staging`: Representa la documentación integrada previa a la validación.
- `dev`: Representa borradores y documentación en desarrollo.
- `architecture-documentation-*`: Ramas de control y tránsito asociadas a cada entorno.

---

## Directrices ante Exposición de Secretos

En caso de que se detecte la inclusión accidental de una credencial o dato sensible real en el repositorio:

1. **Rotación Inmediata**: Revocar y cambiar de inmediato la credencial o el parámetro en el sistema real afectado.
2. **Corrección de Contenido**: Crear un commit reemplazando la información sensible por placeholders o ejemplos simulados.
3. **Saneamiento del Historial**: Si el elemento comprometido quedó registrado en el historial de Git, el DevOps Lead aplicará herramientas de saneamiento (como `git-filter-repo` o `bfg`) para purgar la referencia del histórico del repositorio de forma segura.

---

## Checklist de Seguridad para PRs

Antes de proceder a mergear cambios entre ramas en el flujo de promoción, el revisor debe verificar conceptualmente:
- [ ] No contiene secretos, tokens ni contraseñas.
- [ ] Utiliza placeholders genéricos (`https://<host-name>/api`) en lugar de datos reales.
- [ ] No incluye datos de identificación personal de usuarios reales.
- [ ] Los diagramas representan flujos lógicos sin exponer topologías de infraestructura física privada.

