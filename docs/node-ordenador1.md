# Nodo: ordenador1
_Actualizado: 2026-05-19 21:21_

## Hardware
CPU(s):                                  4
Model name:                              Intel(R) Core(TM) i5-5300U CPU @ 2.30GHz
Thread(s) per core:                      2
CPU(s) scaling MHz:                      93%

## Memoria
               total        used        free      shared  buff/cache   available
Mem:           5.7Gi       2.9Gi       1.0Gi        60Mi       2.1Gi       2.8Gi
Swap:          5.7Gi       1.1Gi       4.5Gi

## Almacenamiento
Name             Type     Status     Total (KiB)      Used (KiB) Available (KiB)        %
HHDD          zfspool   disabled               0               0               0      N/A
NFS_ord2          nfs     active       938764288          631808       938132480    0.07%
local             dir     active        86999080        10913596        71620232   12.54%
local-lvm     lvmthin     active       195833856        21150056       174683799   10.80%

## Contenedores en este nodo
VMID       Status     Lock         Name                
100        running                 vscode-server       
101        running                 n8n                 
103        running                 zrok                
104        running                 postgresql          

## Red
lo               UNKNOWN        127.0.0.1/8 ::1/128 
nic0             UP             
wlo1             DOWN           
tailscale0       UNKNOWN        100.90.141.82/32 fd7a:115c:a1e0::5e35:8d52/128 fe80::XX/64 
vmbr0            UP             192.168.1.XX/24 fe80::XX/64 
veth101i0@if2    UP             
veth104i0@if2    UP             
veth103i0@if2    UP             
veth100i0@if2    UP             
fwbr100i0        UP             
fwpr100p0@fwln100i0 UP             
fwln100i0@fwpr100p0 UP             
