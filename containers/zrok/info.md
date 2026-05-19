# CT103 — Zrok (Tunneling)
_Actualizado: 2026-05-19 21:21_

## Recursos asignados
arch: amd64
cores: 1
features: nesting=1
hostname: zrok
memory: 512
net0: name=eth0,bridge=vmbr0,gw=192.168.1.XX,hwaddr=XX:XX:XX:XX:XX:XX,ip=192.168.1.XX/24,type=veth
ostype: debian
rootfs: local-lvm:vm-103-disk-0,size=4G
swap: 512
unprivileged: 1

## Versión
ver desconocida

## Estado del servicio
active

## Disco
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/pve-vm--103--disk--0  3.9G  866M  2.8G  24% /

## Puertos escuchando
LISTEN 0      100        127.0.0.1:25        0.0.0.0:*    users:(("master",pid=240,fd=13))                     
LISTEN 0      100            [::1]:25           [::]:*    users:(("master",pid=240,fd=14))                     
LISTEN 0      4096               *:22              *:*    users:(("sshd",pid=106,fd=3),("systemd",pid=1,fd=45))
