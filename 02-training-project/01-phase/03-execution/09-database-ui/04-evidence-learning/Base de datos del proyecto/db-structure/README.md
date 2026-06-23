# Base de Datos

Estructura SQL independiente del backend para PostgreSQL.

La documentacion completa de base de datos esta centralizada en:

- `../docs/database/README.md`
- `../docs/database/estructura-bd.md`
- `../docs/database/data-model.md`
- `../docs/database/change-management.md`
- `../docs/database/sql-inventory.md`

## Ejecucion rapida

Levantar solo PostgreSQL:

```bash
docker-compose up -d
```

La base queda publicada en:

```text
localhost:5432
```

Para levantar backend y base de datos juntos, usar el `docker-compose.yaml` de la raiz del proyecto.
