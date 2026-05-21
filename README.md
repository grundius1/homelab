# 🏠 Homelab — Proxmox Cluster

Infraestructura personal con Proxmox VE 9.1.9, 2 nodos físicos y una arquitectura de contenedores LXC para desarrollo remoto, automatización, IA local y datos.

## 🚧 Acceso y alcance

- Este repositorio documenta la arquitectura, los contenedores y la automatización usada para mantener el clúster actualizado.

## 🖥️ Nodo del clúster

| Nodo | CPU | RAM | Rol |
|------|-----|-----|-----|
| ordenador1 | Intel i5-5300U (4 hilos) | 5.7 GB | Servicios principales y gestión Proxmox |
| ordenador2 | Intel i7-6700HQ (8 hilos) | 15 GB | IA local con GPU y almacenamiento ZFS |

## 🧩 Distribución por nodo

- **ordenador1**: `CT100` VSCode Server, `CT101` n8n, `CT103` zrok, `CT104` PostgreSQL. Este nodo concentra la gestión del clúster y servicios de backend ligeros.
- **ordenador2**: `CT200` Ollama, `CT105` Picoclaw. Este nodo soporta IA local y agentes con mayor demanda de memoria/GPU.

## 💾 Almacenamiento

- **NFS_ord2** (~894 GB) compartido entre ambos nodos para datos persistentes.
- **ZFS HHDD** (~900 GB) en `ordenador2` para datos de alto volumen y snapshots.
- **local-lvm** en cada nodo para sistemas operativos y discos de contenedores.

## 🔧 Principales decisiones técnicas

- **LXC** para contenedores ligeros con menor overhead en hardware doméstico.
- **Proxmox** para orquestación de nodos físicos, contenedores y redes.
- **PostgreSQL en NFS** para persistencia compartida y migración de datos.
- **Ollama en nodo 2** para ejecución local de modelos IA con GPU.
- **zrok** para exponer servicios internos sin abrir puertos de router.
- **Tailscale** para acceso remoto seguro a la interfaz de administración.

## 🚀 Servicios y contenedores

| Contenedor | Servicio | Propósito |
|------------|----------|-----------|
| CT100 | VSCode Server | Entorno de desarrollo remoto en navegador |
| CT101 | n8n | Automatización de workflows y orquestación de tareas |
| CT103 | zrok | túnel seguro para exponer servicios internos |
| CT104 | PostgreSQL | Base de datos relacional con volumen NFS compartido |
| CT200 | Ollama | Plataforma local de IA / LLM con GPU passthrough |
| CT105 | Picoclaw | Runtime de agentes IA para experimentación |

## 📌 Detalles de contenedores

### CT100 — VSCode Server
- Ubuntu 24.04
- 2 CPU, 4 GB RAM, 100 GB en `local-lvm`
- Entorno de desarrollo remoto para trabajar dentro del homelab.

### CT101 — n8n
- Versión detectada: 2.19.5
- Plataforma de automatización y workflows locales.
- Integrable con servicios IA y la base de datos local.

### CT103 — zrok
- Túnel seguro para servicios internos.
- Permite tráfico entrante sin configuración de NAT en el router.

### CT104 — PostgreSQL
- PostgreSQL 18.3
- Datos montados en `NFS_ord2` para persistencia compartida.
- Útil para aplicaciones internas y proyectos de IA.

### CT200 — Ollama
- Servidor de IA local / LLM
- 6 CPU y GPU passthrough
- Ejecutado en `ordenador2` con mayor RAM disponible.

### CT105 — Picoclaw
- Runtime de agentes IA ligero
- Contenedor orientado a experimentación de automatización y flujos inteligentes.

## 📚 Documentación

- `docs/cluster-summary.md` — resumen de estado del clúster.
- `docs/node-ordenador1.md` — detalles de hardware y contenedores de `ordenador1`.
- `docs/node-ordenador2.md` — detalles de hardware y contenedores de `ordenador2`.
- `containers/*/info.md` — metadatos de cada contenedor LXC.

## 📝 Recomendaciones futuras

- Añadir URLs directas a servicios como `n8n`, `Ollama` y `VSCode Server` cuando estén disponibles.
- Documentar casos de uso concretos de la automatización y los modelos IA.
- Incluir un diagrama de arquitectura o un mapa de red sencillo.
- Añadir notas sobre backup / restauración de `NFS_ord2` y `ZFS HHDD`.
- Registrar el método de autenticación usado en Proxmox y Tailscale.
- Evitar información sensible en el repositorio público, como credenciales, rutas privadas o datos de producción.
