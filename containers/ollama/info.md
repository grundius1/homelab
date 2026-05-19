# CT200 — Ollama (IA Local)
_Actualizado: 2026-05-19 21:21_

## Recursos asignados
arch: amd64
cores: 6
dev0: /dev/nvidia-modeset,gid=44
dev1: /dev/nvidia-uvm,gid=44
dev2: /dev/nvidia-uvm-tools,gid=44
dev3: /dev/nvidia0,gid=44
dev4: /dev/nvidiactl,gid=44
dev5: /dev/nvidia-caps/nvidia-cap1,gid=44
dev6: /dev/nvidia-caps/nvidia-cap2,gid=44
features: nesting=1,keyctl=1
hostname: ollama
memory: 13312
net0: name=eth0,bridge=vmbr0,gw=192.168.1.XX,hwaddr=XX:XX:XX:XX:XX:XX,ip=192.168.1.XX/24,ip6=auto,type=veth
onboot: 1
ostype: ubuntu
rootfs: local-lvm:vm-200-disk-0,size=100G
swap: 1024
tags: ai;community-script
timezone: Europe/Madrid
unprivileged: 1

## Modelos instalados
ollama

## Recursos disponibles
CPUs: 6

               total        used        free      shared  buff/cache   available
Mem:            13Gi       543Mi       3.1Gi        96Ki       9.4Gi        12Gi
Swap:          1.0Gi          0B       1.0Gi

## Disco
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/pve-vm--200--disk--0   98G   38G   56G  41% /

## Puertos escuchando
LISTEN 0      100        127.0.0.1:25         0.0.0.0:*    users:(("master",pid=655,fd=13))                     
LISTEN 0      4096   127.0.0.53%lo:53         0.0.0.0:*    users:(("systemd-resolve",pid=226,fd=15))            
LISTEN 0      4096         0.0.0.0:22         0.0.0.0:*    users:(("sshd",pid=447,fd=3),("systemd",pid=1,fd=49))
LISTEN 0      4096      127.0.0.54:53         0.0.0.0:*    users:(("systemd-resolve",pid=226,fd=17))            
LISTEN 0      100            [::1]:25            [::]:*    users:(("master",pid=655,fd=14))                     
LISTEN 0      4096               *:11434            *:*    users:(("ollama",pid=235,fd=3))                      
LISTEN 0      4096            [::]:22            [::]:*    users:(("sshd",pid=447,fd=4),("systemd",pid=1,fd=50))
