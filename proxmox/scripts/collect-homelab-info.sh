#!/bin/bash
# =============================================================
#  collect-homelab-info.sh
#  Recopila datos de todos los contenedores y los guarda
#  en la estructura del repo homelab/
#
#  EJECUTAR DESDE: ordenador1 (como root)
#  USO: bash collect-homelab-info.sh
#
#  Requiere: acceso SSH sin contraseña a ordenador2
#  Para configurarlo: ssh-copy-id root@<IP_ORDENADOR2>
# =============================================================

set -e

# ── Configura aquí la IP de ordenador2 ──────────────────────
ORD2_IP="192.168.1.XX"
REPO_DIR="$HOME/homelab"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

# Colores para el output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✅ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
err()  { echo -e "${RED}❌ $1${NC}"; }

echo ""
echo "=============================================="
echo "  Homelab Info Collector"
echo "  $(date)"
echo "=============================================="
echo ""

# ── Crea estructura de directorios ──────────────────────────
mkdir -p "$REPO_DIR"/{docs,proxmox/{scripts,configs},monitoring}
mkdir -p "$REPO_DIR"/containers/{vscode-server,n8n,zrok,postgresql,ollama,picoclaw}

# ── Función helper para ejecutar en CT local ────────────────
collect_ct() {
  local CTID=$1
  local CMD=$2
  pct exec "$CTID" -- bash -c "$CMD" 2>/dev/null || echo "(no disponible)"
}

# ── Función helper para ejecutar en CT remoto (ord2) ────────
collect_ct_remote() {
  local CTID=$1
  local CMD=$2
  ssh -o ConnectTimeout=5 "root@${ORD2_IP}" \
    "pct exec $CTID -- bash -c '$CMD'" 2>/dev/null || echo "(no disponible)"
}

# =============================================================
#  NODO 1 — ordenador1
# =============================================================
echo "── Recopilando datos de ordenador1..."

cat > "$REPO_DIR/docs/node-ordenador1.md" << HEREDOC
# Nodo: ordenador1
_Actualizado: ${TIMESTAMP}_

## Hardware
$(lscpu | grep -E "Model name|^CPU\(s\)|Thread|Core(s) per")

## Memoria
$(free -h)

## Almacenamiento
$(pvesm status)

## Contenedores en este nodo
$(pct list)

## Red
$(ip -brief addr show)
HEREDOC
ok "ordenador1 → docs/node-ordenador1.md"

# =============================================================
#  NODO 2 — ordenador2
# =============================================================
echo "── Recopilando datos de ordenador2..."

if ssh -o ConnectTimeout=5 -o BatchMode=yes "root@${ORD2_IP}" true 2>/dev/null; then
  ssh "root@${ORD2_IP}" bash << 'REMOTE'
cat << INFO
## Hardware
$(lscpu | grep -E "Model name|^CPU\(s\)|Thread|Core(s) per")

## Memoria
$(free -h)

## Almacenamiento
$(pvesm status)

## Contenedores en este nodo
$(pct list)
INFO
REMOTE
  # Captura correcta
  ssh "root@${ORD2_IP}" "
    echo '# Nodo: ordenador2';
    echo '_Actualizado: ${TIMESTAMP}_';
    echo '';
    echo '## Hardware';
    lscpu | grep -E 'Model name|^CPU\(s\)|Thread|Core';
    echo '';
    echo '## Memoria';
    free -h;
    echo '';
    echo '## Almacenamiento';
    pvesm status;
    echo '';
    echo '## Contenedores en este nodo';
    pct list;
    echo '';
    echo '## Red';
    ip -brief addr show;
  " > "$REPO_DIR/docs/node-ordenador2.md" 2>/dev/null
  ok "ordenador2 → docs/node-ordenador2.md"
else
  warn "No hay SSH a ordenador2. Configura: ssh-copy-id root@${ORD2_IP}"
  warn "Los datos de ordenador2 se omitirán."
fi

# =============================================================
#  CT 100 — vscode-server (ordenador1)
# =============================================================
echo "── CT100 vscode-server..."

cat > "$REPO_DIR/containers/vscode-server/info.md" << HEREDOC
# CT100 — VSCode Server
_Actualizado: ${TIMESTAMP}_

## Recursos asignados
$(cat /etc/pve/lxc/100.conf | grep -v "^#")

## Sistema operativo
$(collect_ct 100 "cat /etc/os-release | grep -E 'NAME|VERSION'")

## Disco
$(collect_ct 100 "df -h /")

## Procesos principales
$(collect_ct 100 "ps aux --no-headers | grep -v '\[' | sort -rk3 | head -5")

## Puertos escuchando
$(collect_ct 100 "ss -tlnp | grep LISTEN")
HEREDOC
ok "CT100 → containers/vscode-server/info.md"

# =============================================================
#  CT 101 — n8n (ordenador1)
# =============================================================
echo "── CT101 n8n..."

N8N_VERSION=$(collect_ct 101 "n8n --version 2>/dev/null || node /usr/local/lib/node_modules/n8n/bin/n8n --version 2>/dev/null || echo 'ver desconocida'")
N8N_STATUS=$(collect_ct 101 "systemctl is-active n8n 2>/dev/null || pm2 list 2>/dev/null | grep n8n | awk '{print \$10}' || echo 'revisar manualmente'")
N8N_DISK=$(collect_ct 101 "df -h /")
N8N_WORKFLOWS=$(collect_ct 101 "ls /root/.n8n/workflows/ 2>/dev/null | wc -l || echo '0'")

cat > "$REPO_DIR/containers/n8n/info.md" << HEREDOC
# CT101 — n8n (Automatización)
_Actualizado: ${TIMESTAMP}_

## Recursos asignados
$(cat /etc/pve/lxc/101.conf | grep -v "^#")

## Versión
${N8N_VERSION}

## Estado del servicio
${N8N_STATUS}

## Disco
${N8N_DISK}

## Workflows almacenados
${N8N_WORKFLOWS} workflows encontrados en /root/.n8n/workflows/

## Puertos escuchando
$(collect_ct 101 "ss -tlnp | grep LISTEN")
HEREDOC
ok "CT101 → containers/n8n/info.md"

# Exportar workflows si existen
WFCOUNT=$(collect_ct 101 "ls /root/.n8n/workflows/ 2>/dev/null | wc -l || echo 0")
if [ "$WFCOUNT" -gt 0 ] 2>/dev/null; then
  mkdir -p "$REPO_DIR/automation/n8n-workflows"
  collect_ct 101 "cat /root/.n8n/workflows/*.json 2>/dev/null" \
    > "$REPO_DIR/automation/n8n-workflows/exported-workflows.json" 2>/dev/null
  ok "n8n workflows exportados → automation/n8n-workflows/"
fi

# =============================================================
#  CT 103 — zrok (ordenador1)
# =============================================================
echo "── CT103 zrok..."

cat > "$REPO_DIR/containers/zrok/info.md" << HEREDOC
# CT103 — Zrok (Tunneling)
_Actualizado: ${TIMESTAMP}_

## Recursos asignados
$(cat /etc/pve/lxc/103.conf | grep -v "^#")

## Versión
$(collect_ct 103 "zrok version 2>/dev/null || echo 'ver desconocida'")

## Estado del servicio
$(collect_ct 103 "systemctl is-active zrok 2>/dev/null || echo 'revisar manualmente'")

## Disco
$(collect_ct 103 "df -h /")

## Puertos escuchando
$(collect_ct 103 "ss -tlnp | grep LISTEN")
HEREDOC
ok "CT103 → containers/zrok/info.md"

# =============================================================
#  CT 104 — postgresql (ordenador1)
# =============================================================
echo "── CT104 postgresql..."

PG_VERSION=$(collect_ct 104 "psql --version 2>/dev/null || pg_lsclusters 2>/dev/null | tail -1 || echo 'ver desconocida'")
PG_DBS=$(collect_ct 104 "su - postgres -c 'psql -c \"\l\" 2>/dev/null' 2>/dev/null || echo 'No se pudo conectar'")
PG_STATUS=$(collect_ct 104 "systemctl is-active postgresql 2>/dev/null || echo 'revisar manualmente'")

cat > "$REPO_DIR/containers/postgresql/info.md" << HEREDOC
# CT104 — PostgreSQL (Base de datos)
_Actualizado: ${TIMESTAMP}_

## Recursos asignados
$(cat /etc/pve/lxc/104.conf | grep -v "^#")

## Versión
${PG_VERSION}

## Estado del servicio
${PG_STATUS}

## Bases de datos
${PG_DBS}

## Disco (NFS_ord2 — compartido entre nodos)
$(collect_ct 104 "df -h /")

## Puertos escuchando
$(collect_ct 104 "ss -tlnp | grep LISTEN")
HEREDOC
ok "CT104 → containers/postgresql/info.md"

# =============================================================
#  CT 200 — ollama (ordenador2)
# =============================================================
echo "── CT200 ollama (ordenador2)..."

if ssh -o ConnectTimeout=5 -o BatchMode=yes "root@${ORD2_IP}" true 2>/dev/null; then

  OLLAMA_MODELS=$(collect_ct_remote 200 "ollama list 2>/dev/null || echo 'ollama no responde'")
  OLLAMA_DISK=$(collect_ct_remote 200 "df -h /")
  OLLAMA_RAM=$(collect_ct_remote 200 "free -h")
  OLLAMA_CPU=$(collect_ct_remote 200 "nproc")

  cat > "$REPO_DIR/containers/ollama/info.md" << HEREDOC
# CT200 — Ollama (IA Local)
_Actualizado: ${TIMESTAMP}_

## Recursos asignados
$(ssh "root@${ORD2_IP}" "cat /etc/pve/lxc/200.conf 2>/dev/null | grep -v '^#'" 2>/dev/null)

## Modelos instalados
${OLLAMA_MODELS}

## Recursos disponibles
CPUs: ${OLLAMA_CPU}

${OLLAMA_RAM}

## Disco
${OLLAMA_DISK}

## Puertos escuchando
$(collect_ct_remote 200 "ss -tlnp | grep LISTEN")
HEREDOC
  ok "CT200 → containers/ollama/info.md"

else
  warn "Sin SSH a ordenador2 — CT200 omitido"
fi

# =============================================================
#  CT 105 — picoclaw (ordenador2)
# =============================================================
echo "── CT105 picoclaw (ordenador2)..."

if ssh -o ConnectTimeout=5 -o BatchMode=yes "root@${ORD2_IP}" true 2>/dev/null; then
  cat > "$REPO_DIR/containers/picoclaw/info.md" << HEREDOC
# CT105 — Picoclaw
_Actualizado: ${TIMESTAMP}_

## Recursos asignados
$(ssh "root@${ORD2_IP}" "cat /etc/pve/lxc/105.conf 2>/dev/null | grep -v '^#'" 2>/dev/null)

## Sistema operativo
$(collect_ct_remote 105 "cat /etc/os-release | grep -E 'NAME|VERSION'")

## Procesos principales
$(collect_ct_remote 105 "ps aux --no-headers | grep -v '\[' | sort -rk3 | head -10")

## Puertos escuchando
$(collect_ct_remote 105 "ss -tlnp | grep LISTEN")

## Disco
$(collect_ct_remote 105 "df -h /")
HEREDOC
  ok "CT105 → containers/picoclaw/info.md"
fi

# =============================================================
#  RESUMEN GENERAL del clúster
# =============================================================
echo "── Generando resumen del clúster..."

cat > "$REPO_DIR/docs/cluster-summary.md" << HEREDOC
# Resumen del Clúster
_Actualizado: ${TIMESTAMP}_

## ordenador1 — Estado de contenedores
$(pct list)

## ordenador1 — Almacenamiento
$(pvesm status)

## ordenador2 — Estado de contenedores
$(ssh "root@${ORD2_IP}" "pct list" 2>/dev/null || echo "(sin acceso SSH)")

## ordenador2 — Almacenamiento
$(ssh "root@${ORD2_IP}" "pvesm status" 2>/dev/null || echo "(sin acceso SSH)")
HEREDOC
ok "Resumen → docs/cluster-summary.md"

# =============================================================
#  RESULTADO FINAL
# =============================================================
echo ""
echo "=============================================="
echo "  ✅ Recopilación completada"
echo "=============================================="
echo ""
echo "Archivos generados en: $REPO_DIR"
echo ""
find "$REPO_DIR" -name "*.md" -o -name "*.json" | sort | while read f; do
  SIZE=$(wc -l < "$f") 
  echo "  📄 ${f#$REPO_DIR/}  (${SIZE} líneas)"
done
echo ""
echo "Próximo paso:"
echo "  cd $REPO_DIR && git add . && git commit -m 'docs: update container info ${TIMESTAMP}'"
echo ""

# =============================================================
#  SANITIZADO DE SEGURIDAD — elimina datos sensibles
#  Se ejecuta siempre al final, antes del commit
# =============================================================
sanitize() {
  echo "── Sanitizando datos sensibles..."

  for f in $(find "$REPO_DIR" -name "*.md" -o -name "*.conf" -o -name "*.sh" | grep -v ".git"); do

    # MACs reales → XX:XX:XX:XX:XX:XX
    sed -i 's/hwaddr=[A-Fa-f0-9:]\{17\}/hwaddr=XX:XX:XX:XX:XX:XX/g' "$f"
    sed -i 's/\([0-9a-fA-F]\{2\}:\)\{5\}[0-9a-fA-F]\{2\}/XX:XX:XX:XX:XX:XX/g' "$f"

    # IPs internas → 192.168.1.XX
    sed -i 's/192\.168\.[0-9]\{1,3\}\.[0-9]\{1,3\}/192.168.1.XX/g' "$f"

    # IPv6 con MAC embebida → fe80::XX/64
    sed -i 's/fe80::[a-fA-F0-9:]\{1,\}\/64/fe80::XX\/64/g' "$f"

    # Token de VSCode Server
    sed -i 's/--connection-token=[^ ]*/--connection-token=REDACTED/g' "$f"

    # Líneas de procesos internos de vscode (ps aux output)
    sed -i '/\.vscode\/cli\/servers/d' "$f"

    # Rutas absolutas internas sensibles
    sed -i 's|/root/\.n8n|~/.n8n|g' "$f"
    sed -i 's|/root/\.vscode|~/.vscode|g' "$f"

  done

  ok "Sanitizado completado — repo listo para commit"
}

sanitize
