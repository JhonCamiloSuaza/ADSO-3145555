# Reglas de seguridad documental

Este documento define reglas simples para evitar que el repositorio publique informacion sensible.

## No publicar

- Credenciales, contrasenas, tokens o llaves privadas.
- Archivos `.env`, `.pem`, `.key`, `.p12` o `.pfx`.
- Datos personales reales de aprendices, instructores, directivos o usuarios.
- Correos reales, telefonos, documentos de identidad o identificadores personales.
- Capturas con sesiones abiertas.
- URLs internas privadas, IPs o nombres de host sensibles.

## Usar en ejemplos

| Caso | Valor seguro |
|------|--------------|
| Correo | `usuario@example.com` |
| Token | `TOKEN_DE_EJEMPLO` |
| URL | `https://example.com/api` |
| Documento | `0000000000` aclarando que es ficticio |
| Servicio | `servicio-ejemplo` |

## Antes de subir una imagen

- Ocultar datos personales.
- Verificar que no aparezcan sesiones, tokens ni correos reales.
- Confirmar que la imagen aporta valor documental.
- Guardarla en `recursos/` si realmente se necesita.

## Si aparece informacion sensible

1. Detener nuevos cambios sobre ese contenido.
2. Reemplazar el dato por un ejemplo seguro.
3. Avisar al equipo responsable del repositorio.
4. Registrar la correccion en el PR o changelog.

## Regla

Si un dato no es necesario para entender la documentacion, no debe publicarse.
