# Architecture Decision Record (ADR-004): Uso de Docker Compose para la Base de Datos Local

ID: ADR-004
Autor: Jhon Camilo Suaza Sanchez
**Fecha:** Abril 2026  
**Estatus:** Aceptado e Implementado  
**Contexto:**
El equipo requería un motor de base de datos estable para levantar el script de la aerolínea (`Adr_Database.sql`) y realizar su integración en el entorno completo del proyecto, a conectar con herramientas modernas y sistemas de backend (Spring o Node).
Forzar a cada desarrollador del equipo a instalar PostgreSQL manualmente en Windows, configurar usuarios, permisos, descargar la interfaz, y correr el script SQL manualmente causa problemas constantes (el llamado *"En mi máquina funciona, en la tuya no"*). 

---

## La Decisión
Establecer un esquema de Contenedores efímeros locales usando **Docker Compose** para abstraer por completo el motor de PostgreSQL.

**Solución Implementada:** 
Se redactó y dispuso de un archivo declarativo `docker-compose.yml` en la raíz del proyecto configurado exáctamente de esta forma:
1. Usar imagen oficial compacta de `postgres:15-alpine` (muy ligera y rápida).
2. Mapear de forma automática nuestro puerto local al interior de la red de Docker (`5432`).
3. Se integró una orden en los "VOLÚMENES" de Docker para que se lea el script general `.sql` y Docker lance PostgreSQL e **inyecte toda la base de datos y los triggers automáticamente** nada más al encender por primera vez.

---

## Impacto
* **Desarrollo Consistente:** Ni tú ni tu equipo requieren instalar software de bases de datos de forma nativa. Solo tener la carpeta local.
* **Agilidad de Despliegue:** Con ejecutar el comando `docker-compose up -d`, en 5 segundos se inicia un servidor funcional de PostgreSQL empresarial, con base de datos, contraseñas predefinidas en el `.yml`, y todo el código SQL inyectado y funcional en primer plano sin teclear más de una vez.
* **Reinicio en Limpio:** Si se contamina la base de datos haciendo pruebas, se borra el contenedor y al relanzarlo la base arranca virgen de nuevo.
