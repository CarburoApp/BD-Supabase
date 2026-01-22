# Repositorio de Configuración de Base de Datos – Carburo

📘 **Introducción**  
Este repositorio forma parte del **Trabajo de Fin de Grado (TFG)** de Manuel García Baldo en la **Universidad de Oviedo**. Contiene toda la configuración necesaria para levantar la **base de datos y servicios relacionados** que sustentan el sistema de las aplicaciones de **Carburo**. Esto incluye los contenedores de PostgreSQL/PostGIS, Supabase Auth, Studio, Storage y Analytics, así como los scripts SQL iniciales.

---

## 🛠 Ecosistema y Arquitectura

El sistema se basa en **Supabase**, que proporciona un ecosistema completo de **PostgreSQL**, autenticación, almacenamiento y análisis. La arquitectura de contenedores es la siguiente:

| Contenedor            | Imagen / Versión                 | Función principal                                               | Puertos expuestos al exterior |
|----------------------|---------------------------------|----------------------------------------------------------------|-------------------------------|
| `supabase-db`        | `supabase/postgres:15.8.1.085`  | Base de datos principal con **PostGIS**                        | `${POSTGRES_PORT_EXT:-5432}`|
| `supabase-studio`    | `supabase/studio:latest`        | Dashboard de administración visual                              | `${STUDIO_PORT:-54232}`      |
| `supabase-auth`      | `supabase/gotrue:v2.186.0-rc.5`| Autenticación y gestión de JWT                                  | `${POSTGRES_AUTH_PORT_EXT:-9999}`               |
| `supabase-meta`      | `supabase/postgres-meta:v0.95.2`| Gestión de metadata de Supabase                                 | Interno: 8080               |
| `supabase-storage`   | `supabase/storage-api:latest`    | Almacenamiento de archivos (local / multi-tenant)              | Interno: 5000               |
| `supabase-analytics` | `supabase/logflare:latest`       | Logging y métricas de analytics                                 | 4000                         |

> Nota: Algunos servicios solo exponen puertos internamente y se comunican entre contenedores. Los puertos externos definitivos son los indicados arriba.

---

## ⚙ Detalles Relevantes

### PostgreSQL + PostGIS
- **Versión:** 15.8.1 (no se usa la 17 por problemas de compatibilidad con Supabase).  
- **Usuario administrador principal:** `POSTGRES_USER=supabase_admin`. **Obligatorio usar este usuario**, de lo contrario la DB no carga.  
- **Base de datos principal:** `POSTGRES_DB=carburo`.  
- **Extensiones activas:** `postgis` para soporte geoespacial.  
- **Puerto interno:** `${POSTGRES_PORT:-5432}`  
- **Puerto externo:** `${POSTGRES_PORT_EXT:-5432}`  

### Supabase Studio
- Última versión (`latest`).  
- Dashboard web para gestión de DB, roles, Auth y más.  
- Puerto expuesto: `${STUDIO_PORT:-54232}`

### Auth (GoTrue)
- Gestiona usuarios, JWT, OAuth (Google) y correos.  
- Puerto expuesto: `${POSTGRES_AUTH_PORT_EXT:-9999}`
- Integración SMTP configurada con Zoho Mail para envíos:  
  - `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS` definidos en `.env`.  

### Storage
- Almacenamiento de archivos en disco (`./storage/files`).  
- Soporta multi-tenant y configuración de tamaño máximo de archivos.

### Analytics (Logflare)
- Logging y métricas de Supabase.  
- Puerto expuesto: 4000  
- Guarda datos en `_supabase` y `_analytics` dentro de la DB.

---

## 🗂 Archivos SQL y Volúmenes

Los volúmenes montados en `db` incluyen scripts iniciales que configuran:

- Webhooks
- Roles
- JWT y Auth
- Supabase interno (`_supabase`)
- Analytics (`_analytics`)
- Pooler de conexiones

**Autoria:** Modificados por Manuel García Baldo para el proyecto Carburo.  
**Originales:**  
- Archivos SQL obtenidos de [Supabase Docker Volumes](https://github.com/supabase/supabase/tree/master/docker/volumes/db)  
- Docker Compose basado en [Supabase Docker](https://github.com/supabase/supabase)

## 🚀 Comandos Docker Compose

Levantar todos los servicios:

```bash
docker-compose up -d
```

Detener todos los servicios:

```bash
docker-compose down
```

Detener y eliminar volúmenes:

```bash
docker-compose down -v
```

Ver logs de la base de datos (por ejemplo):

```bash
docker-compose logs -f db
```

---

## 🔗 Referencias

- [Supabase Oficial](https://github.com/supabase/supabase)  
- [Supabase Docker Volumes](https://github.com/supabase/supabase/tree/master/docker/volumes)

- ---

## 👨‍💻 Autor

**Manuel García Baldo**  
Universidad de Oviedo  
Trabajo de Fin de Grado - Ingeniería Informática (2025)

---

## 🧾 Licencia

Este proyecto se distribuye bajo licencia **MIT**.  
Puede utilizarse, modificarse o redistribuirse libremente, siempre que se cite la fuente original.

