# Archivo historico

Esta carpeta conserva documentos que ya no estan vigentes pero que conviene mantener por trazabilidad. No es una papelera; es memoria documental controlada.

## Cuando usar esta carpeta

- Un documento fue reemplazado por una version nueva.
- Una decision antigua ya no aplica.
- Una carpeta cambio de estructura y se quiere conservar contexto.
- Un documento tiene valor historico, pero no debe confundirse con la version vigente.

## Como archivar

1. Confirmar que el documento ya no es vigente.
2. Indicar en el documento original que fue reemplazado, si aplica.
3. Moverlo a esta carpeta o a una subcarpeta descriptiva.
4. Registrar el motivo en `CHANGELOG.md` cuando el cambio sea relevante.

## Reglas

- No archivar documentos activos.
- No eliminar historia importante sin registrar reemplazo.
- No guardar credenciales, secretos ni datos sensibles.
- No usar esta carpeta para documentos incompletos que todavia deben trabajarse.

## Subcarpetas sugeridas

| Carpeta | Uso |
|---------|-----|
| `deprecados` | Documentos reemplazados o fuera de uso |
| `decisiones-antiguas` | Decisiones conservadas por historia |
| `referencias` | Material que sirve como antecedente, no como norma vigente |
