# Seguridad documental

> Estado: 🟡 En progreso | Última actualización: 2026-06-16
> Autor: Por definir | Equipo: Por definir

Este repositorio puede ser consultado por varios equipos. La documentación debe usar ejemplos seguros y evitar exposición de información sensible.

## No publicar

- Credenciales, contraseñas, tokens o llaves privadas.
- Certificados, archivos `.env`, `.pem`, `.key`, `.p12` o `.pfx`.
- Datos personales reales de aprendices, instructores, administradores o usuarios.
- Correos reales, teléfonos, números de documento o identificadores personales.
- Capturas de pantalla con sesiones abiertas o datos operativos reales.
- URLs internas privadas, IPs, nombres de host o rutas de red sensibles.
- Procedimientos que permitan saltarse controles de seguridad.

## Usar en ejemplos

| Caso | Valor seguro |
|------|--------------|
| Correo | `usuario@example.com` |
| Token | `TOKEN_DE_EJEMPLO` |
| URL | `https://example.com/api` |
| Servicio | `sena-horarios-service` |
| Documento | `1234567890` solo si se aclara que es ficticio |

## Antes de subir capturas

- Revisar que no haya nombres reales.
- Ocultar correos, documentos, tokens y sesiones.
- Confirmar que la captura aporta valor documental.
- Guardar la imagen en `assets/images/` y referenciarla desde el documento.

## Si se detecta una fuga

1. No crear más commits con el secreto o dato sensible.
2. Avisar al responsable del repositorio y al equipo de seguridad o arquitectura.
3. Rotar la credencial si aplica.
4. Abrir un PR que reemplace el contenido por un ejemplo seguro.
5. Evaluar limpieza de historial si el dato quedó versionado.

## Contacto de Seguridad

En caso de detectar una posible fuga de información sensible, se debe coordinar de inmediato con los roles responsables:

- **Responsable del Repositorio**: `@administrador-repositorio` (Rol de administración general)
- **Equipo de Arquitectura**: `@equipo-arquitectura` (Canal de consulta técnica)

Ante una credencial comprometida: **rotar primero, notificar después**. No se debe esperar confirmación del equipo para iniciar el proceso de rotación en el sistema afectado.

## Checklist de Validación

- [ ] Sin credenciales, tokens ni contraseñas.
- [ ] Sin datos personales de aprendices o funcionarios.
- [ ] Direcciones de red y endpoints representados con nombres de dominio genéricos.
- [ ] Capturas de pantalla anonimizadas y guardadas en la carpeta de recursos.
- [ ] Ejemplos validados únicamente con datos simulados.

