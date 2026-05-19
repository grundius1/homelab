# Nodo: ordenador2
_Actualizado: 2026-05-19 21:21_

## Hardware
CPU(s):                             8
Model name:                         Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
Thread(s) per core:                 2
Core(s) per socket:                 4
CPU(s) scaling MHz:                 85%

## Memoria
               total        used        free      shared  buff/cache   available
Mem:            15Gi       3.1Gi       1.7Gi        68Mi        11Gi        12Gi
Swap:          8.0Gi          0B       8.0Gi

## Almacenamiento
Name             Type     Status     Total (KiB)      Used (KiB) Available (KiB)        %
HHDD          zfspool     active       942931968         4800060       938131908    0.51%
NFS_ord2          nfs   inactive               0               0               0    0.00%
local             dir     active        98497780        16893060        76555172   17.15%
local-lvm     lvmthin     active       354275328        44815828       309459499   12.65%

## Contenedores en este nodo
VMID       Status     Lock         Name                
102        stopped                 openclaw            
105        running                 picoclaw            
200        running                 ollama              

## Red
lo               UNKNOWN        127.0.0.1/8 ::1/128 
nic0             UP             
wlp2s0           DOWN           
vmbr0            UP             192.168.1.XX/24 fe80::XX/64 
veth200i0@if2    UP             
veth105i0@if2    UP             
fwbr105i0        UP             
fwpr105p0@fwln105i0 UP             
fwln105i0@fwpr105p0 UP             
