# Ambientes y publicacion documental

Esta carpeta explica como se promueve la documentacion entre estados de revision. No describe servidores ni despliegues reales; describe el flujo manual para que un cambio pase de trabajo inicial a documentacion estable.

## Por que existe

La documentacion tambien necesita ciclo de vida. Un archivo puede estar en construccion, en revision, validado por calidad o publicado como referencia estable. Esta carpeta explica ese recorrido sin automatizaciones ocultas.

## Documentos

| Documento | Que explica | Estado |
|-----------|-------------|--------|
| [ambientes.md](./ambientes.md) | Significado documental de `dev`, `staging`, `qa` y `main` | Definido |
| [configuracion-local.md](./configuracion-local.md) | Forma simple de trabajar Markdown en el repositorio | Definido |
| [flujo-publicacion.md](./flujo-publicacion.md) | Pasos manuales para publicar cambios documentales | Definido |

## Que no va aqui

- Credenciales.
- Scripts de despliegue reales.
- GitHub Actions para promover documentacion.
- Configuracion de servidores.

## Regla

La promocion documental debe ser visible, manual y entendible por cualquier integrante del equipo.
