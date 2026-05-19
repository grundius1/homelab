# CT101 — n8n (Automatización)
_Actualizado: 2026-05-19 21:21_

## Recursos asignados
arch: amd64
cores: 2
features: nesting=1,keyctl=1
hostname: n8n
memory: 2048
net0: name=eth0,bridge=vmbr0,gw=192.168.1.XX,hwaddr=XX:XX:XX:XX:XX:XX,ip=192.168.1.XX/24,type=veth
onboot: 1
ostype: debian
rootfs: local-lvm:vm-101-disk-0,size=10G
swap: 1024
tags: automation;community-script
timezone: Europe/Madrid
unprivileged: 1

## Versión
2.19.5

## Estado del servicio
active

## Disco
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/pve-vm--101--disk--0  9.8G  6.1G  3.3G  66% /

## Workflows almacenados
0 workflows encontrados en /root/.n8n/workflows/

## Puertos escuchando
LISTEN 0      100        127.0.0.1:25        0.0.0.0:*    users:(("master",pid=266,fd=13))                     
LISTEN 0      511        127.0.0.1:5679      0.0.0.0:*    users:(("MainThread",pid=88,fd=27))                  
LISTEN 0      511                *:5678            *:*    users:(("MainThread",pid=88,fd=24))                  
LISTEN 0      100            [::1]:25           [::]:*    users:(("master",pid=266,fd=14))                     
LISTEN 0      4096               *:22              *:*    users:(("sshd",pid=105,fd=3),("systemd",pid=1,fd=43))
