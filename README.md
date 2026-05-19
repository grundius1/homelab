# 🏠 Homelab — Proxmox Cluster

Infraestructura personal con Proxmox VE 9.1.9, 2 nodos físicos,
contenedores LXC, automatización, IA local y base de datos.

## 🖥️ Hardware

| Nodo | CPU | RAM | Rol |
|------|-----|-----|-----|
| ordenador1 | Intel i5-5300U (4T) | 5.7 GB | Servicios principales |
| ordenador2 | Intel i7-6700HQ (8T) | 15 GB | IA + almacenamiento ZFS |

## 🚀 Servicios

| Contenedor | Servicio | Función |
|------------|----------|---------|
| CT100 | VSCode Server | IDE en navegador |
| CT101 | n8n | Automatización de workflows |
| CT103 | zrok | Tunneling seguro |
| CT104 | PostgreSQL | Base de datos (disco en NFS) |
| CT200 | Ollama | Modelos de IA local (LLM) |

## 💾 Almacenamiento

- **NFS_ord2** (~894 GB) compartido entre ambos nodos
- **ZFS HHDD** (~900 GB) en ordenador2 para datos pesados
- **local-lvm** en cada nodo para OS de contenedores

## 💡 Decisiones técnicas

- **LXC en vez de VMs** — menor overhead con hardware doméstico
- **PostgreSQL en NFS** — permite migración entre nodos sin mover datos
- **Ollama en ordenador2** — mayor RAM para cargar modelos grandes
- **zrok** — acceso externo seguro sin abrir puertos en el router

## 🛠️ Stack

`Proxmox VE 9.1.9` `LXC` `n8n` `Ollama` `PostgreSQL`
`zrok` `NFS` `ZFS` `Debian 12` `Ubuntu 24.04` `Tailscale`

## 📂 Estructura

\`\`\`
├── proxmox/
│   ├── configs/       # Configuración de cada contenedor
│   └── scripts/       # Scripts para recrear el entorno
├── containers/        # Documentación de cada servicio
├── docs/              # Arquitectura, nodos y red
└── automation/        # Workflows de n8n
\`\`\`

## 🔄 Actualizar documentación

\`\`\`bash
bash proxmox/scripts/collect-homelab-info.sh
git add . && git commit -m "docs: update" && git push
\`\`\`
