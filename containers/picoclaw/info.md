# CT105 — Picoclaw
_Actualizado: 2026-05-19 21:21_

## Recursos asignados
arch: amd64
cores: 2
features: nesting=1
hostname: picoclaw
memory: 1024
net0: name=eth0,bridge=vmbr0,firewall=1,gw=192.168.1.XX,hwaddr=XX:XX:XX:XX:XX:XX,ip=192.168.1.XX/24,type=veth
ostype: ubuntu
rootfs: HHDD:subvol-105-disk-0,size=20G
swap: 512
unprivileged: 1

## Sistema operativo
(no disponible)

## Procesos principales


## Puertos escuchando
LISTEN 0      4096   127.0.0.53%lo:53        0.0.0.0:*    users:(("systemd-resolve",pid=122,fd=15))            
LISTEN 0      4096         0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=252,fd=3),("systemd",pid=1,fd=48))
LISTEN 0      4096      127.0.0.54:53        0.0.0.0:*    users:(("systemd-resolve",pid=122,fd=17))            
LISTEN 0      100        127.0.0.1:25        0.0.0.0:*    users:(("master",pid=412,fd=13))                     
LISTEN 0      4096            [::]:22           [::]:*    users:(("sshd",pid=252,fd=4),("systemd",pid=1,fd=50))
LISTEN 0      100            [::1]:25           [::]:*    users:(("master",pid=412,fd=14))                     

## Disco
Filesystem              Size  Used Avail Use% Mounted on
HHDD/subvol-105-disk-0   20G  647M   20G   4% /
