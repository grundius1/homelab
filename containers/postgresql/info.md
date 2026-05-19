# CT104 — PostgreSQL (Base de datos)
_Actualizado: 2026-05-19 21:21_

## Recursos asignados
arch: amd64
cores: 1
features: nesting=1,keyctl=1
hostname: postgresql
memory: 1024
net0: name=eth0,bridge=vmbr0,gw=192.168.1.XX,hwaddr=XX:XX:XX:XX:XX:XX,ip=192.168.1.XX/24,type=veth
onboot: 1
ostype: debian
rootfs: NFS_ord2:104/vm-104-disk-0.raw,size=150G
swap: 512
tags: community-script;database
timezone: Europe/Madrid
unprivileged: 1

## Versión
psql (PostgreSQL) 18.3 (Debian 18.3-1.pgdg13+1)

## Estado del servicio
active

## Bases de datos

[1mPostgreSQL LXC Container[m
    🌐  [m[33m Provided by: [1;92mcommunity-scripts ORG [33m| GitHub: [1;92mhttps://github.com/community-scripts/ProxmoxVE[m

    🖥️  [m[33m OS: [1;92mDebian GNU/Linux - Version: 13[m
    🏠  [m[33m Hostname: [1;92mpostgresql[m
    💡  [m[33m IP Address: [1;92m192.168.1.XX[m
                                                         List of databases
       Name       |  Owner   | Encoding | Locale Provider |   Collate   |    Ctype    | Locale | ICU Rules |   Access privileges   
------------------+----------+----------+-----------------+-------------+-------------+--------+-----------+-----------------------
 mi_base_datos_ia | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
 postgres         | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
 template0        | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | =c/postgres          +
                  |          |          |                 |             |             |        |           | postgres=CTc/postgres
 template1        | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | =c/postgres          +
                  |          |          |                 |             |             |        |           | postgres=CTc/postgres
(4 rows)

## Disco (NFS_ord2 — compartido entre nodos)
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      147G  1.2G  138G   1% /

## Puertos escuchando
LISTEN 0      200          0.0.0.0:5432      0.0.0.0:*    users:(("postgres",pid=225,fd=6))                                                                                                                                           
LISTEN 0      200             [::]:5432         [::]:*    users:(("postgres",pid=225,fd=7))                                                                                                                                           
LISTEN 0      511                *:80              *:*    users:(("apache2",pid=186023,fd=4),("apache2",pid=186022,fd=4),("apache2",pid=186021,fd=4),("apache2",pid=186020,fd=4),("apache2",pid=186019,fd=4),("apache2",pid=211,fd=4))
LISTEN 0      4096               *:22              *:*    users:(("sshd",pid=129,fd=3),("systemd",pid=1,fd=45))                                                                                                                       
